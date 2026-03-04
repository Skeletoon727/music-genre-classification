#!/usr/bin/env python3
"""
Music Genre Prediction Script

Usage:
    python predict.py --audio path/to/audio.wav --model cnn
    python predict.py --audio path/to/audio.wav --model rf
    python predict.py --audio path/to/audio.wav --model both
"""

import argparse
import pickle
import numpy as np
import librosa
from pathlib import Path
import tensorflow as tf

# Configuration
DATA_ROOT = Path('/Volumes/Data_IA')
MODELS_PATH = DATA_ROOT / 'models' / 'music_classification'

# Genre labels
GENRES = ['blues', 'classical', 'country', 'disco', 'hiphop',
          'jazz', 'metal', 'pop', 'reggae', 'rock']


def extract_features(file_path, duration=30):
    """
    Extract classical audio features for Random Forest model

    Args:
        file_path: Path to audio file
        duration: Duration to analyze (seconds)

    Returns:
        numpy array of features
    """
    try:
        # Load audio
        y, sr = librosa.load(file_path, duration=duration)

        # MFCCs (mean and std)
        mfccs = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=20)
        mfccs_mean = np.mean(mfccs, axis=1)
        mfccs_std = np.std(mfccs, axis=1)

        # Spectral features
        spectral_centroid = np.mean(librosa.feature.spectral_centroid(y=y, sr=sr))
        spectral_rolloff = np.mean(librosa.feature.spectral_rolloff(y=y, sr=sr))
        spectral_contrast = np.mean(librosa.feature.spectral_contrast(y=y, sr=sr), axis=1)

        # Zero crossing rate
        zcr = np.mean(librosa.feature.zero_crossing_rate(y))

        # Chroma
        chroma = np.mean(librosa.feature.chroma_stft(y=y, sr=sr), axis=1)

        # Tempo (with error handling)
        try:
            tempo, _ = librosa.beat.beat_track(y=y, sr=sr)
            # Convert to scalar if it's an array
            if isinstance(tempo, np.ndarray):
                tempo = float(tempo) if tempo.size > 0 else 120.0
            elif tempo is None or np.isnan(tempo):
                tempo = 120.0
        except Exception:
            tempo = 120.0

        # Combine all features
        features = np.concatenate([
            mfccs_mean,
            mfccs_std,
            [spectral_centroid, spectral_rolloff, zcr, tempo],
            spectral_contrast,
            chroma
        ])

        return features

    except Exception as e:
        print(f"Error extracting features: {e}")
        return None


def extract_mel_spectrogram(file_path, n_mels=96, duration=10, offset=0.0):
    """
    Extract Mel-spectrogram for CNN model

    IMPORTANT: These parameters must match the training configuration!
    - n_mels=96 (not 128)
    - duration=10 seconds (not 30)
    - Same hop_length and n_fft as training

    Args:
        file_path: Path to audio file
        n_mels: Number of mel bands (96 - matches training)
        duration: Duration to analyze in seconds (10s - matches training)
        offset: Start time in seconds

    Returns:
        Mel-spectrogram as numpy array with shape (96, ~287)
    """
    try:
        # Load audio (10 seconds)
        y, sr = librosa.load(file_path, duration=duration, offset=offset, sr=22050)

        # Create mel spectrogram with same parameters as training
        mel_spec = librosa.feature.melspectrogram(
            y=y, sr=sr,
            n_mels=n_mels,
            n_fft=2048,
            hop_length=512
        )
        mel_spec_db = librosa.power_to_db(mel_spec, ref=np.max)

        return mel_spec_db

    except Exception as e:
        print(f"Error extracting mel-spectrogram: {e}")
        return None


def predict_with_rf(audio_path):
    """
    Predict genre using Random Forest model

    Args:
        audio_path: Path to audio file

    Returns:
        tuple: (predicted_genre, confidence)
    """
    # Load model
    model_path = MODELS_PATH / 'random_forest_model.pkl'

    if not model_path.exists():
        raise FileNotFoundError(f"Random Forest model not found at {model_path}")

    with open(model_path, 'rb') as f:
        model_data = pickle.load(f)

    rf_model = model_data['model']
    scaler = model_data['scaler']
    label_encoder = model_data['label_encoder']

    # Extract features
    print("Extracting audio features...")
    features = extract_features(audio_path)

    if features is None:
        raise ValueError("Failed to extract features")

    # Normalize and predict
    features_scaled = scaler.transform(features.reshape(1, -1))
    predicted_class = rf_model.predict(features_scaled)[0]
    probabilities = rf_model.predict_proba(features_scaled)[0]
    confidence = probabilities[predicted_class]

    # Get genre name
    genre = label_encoder.inverse_transform([predicted_class])[0]

    # Get top 3 predictions
    top_3_idx = np.argsort(probabilities)[-3:][::-1]
    top_3_genres = [(label_encoder.inverse_transform([idx])[0], probabilities[idx])
                    for idx in top_3_idx]

    return genre, confidence, top_3_genres


def predict_with_cnn(audio_path):
    """
    Predict genre using CNN model

    Args:
        audio_path: Path to audio file

    Returns:
        tuple: (predicted_genre, confidence)
    """
    # Load model
    model_path = MODELS_PATH / 'best_model.keras'

    if not model_path.exists():
        raise FileNotFoundError(f"CNN model not found at {model_path}")

    model = tf.keras.models.load_model(str(model_path))

    # Extract mel-spectrogram
    print("Extracting mel-spectrogram...")
    mel_spec = extract_mel_spectrogram(audio_path)

    if mel_spec is None:
        raise ValueError("Failed to extract mel-spectrogram")

    # Prepare for prediction
    mel_spec = mel_spec[np.newaxis, ..., np.newaxis]  # Add batch and channel dimensions

    # Predict
    predictions = model.predict(mel_spec, verbose=0)
    predicted_class = np.argmax(predictions[0])
    confidence = predictions[0][predicted_class]

    # Get genre name
    genre = GENRES[predicted_class]

    # Get top 3 predictions
    top_3_idx = np.argsort(predictions[0])[-3:][::-1]
    top_3_genres = [(GENRES[idx], predictions[0][idx]) for idx in top_3_idx]

    return genre, confidence, top_3_genres


def main():
    parser = argparse.ArgumentParser(description='Predict music genre from audio file')
    parser.add_argument('--audio', '-a', required=True, help='Path to audio file')
    parser.add_argument('--model', '-m', choices=['cnn', 'rf', 'both'], default='both',
                       help='Model to use: cnn (CNN), rf (Random Forest), or both')

    args = parser.parse_args()

    # Validate audio file
    audio_path = Path(args.audio)
    if not audio_path.exists():
        print(f"Error: Audio file not found: {audio_path}")
        return

    print(f"\n{'='*60}")
    print(f"Music Genre Prediction")
    print(f"{'='*60}")
    print(f"Audio file: {audio_path.name}")
    print(f"{'='*60}\n")

    # Predict with selected model(s)
    if args.model in ['rf', 'both']:
        try:
            print("🌳 Random Forest Prediction")
            print("-" * 60)
            genre, confidence, top_3 = predict_with_rf(audio_path)

            print(f"\n✅ Predicted Genre: {genre.upper()}")
            print(f"   Confidence: {confidence:.2%}\n")

            print("Top 3 predictions:")
            for i, (g, conf) in enumerate(top_3, 1):
                bar = '█' * int(conf * 40)
                print(f"   {i}. {g:12s} {bar:40s} {conf:.2%}")
            print()

        except Exception as e:
            print(f"❌ Random Forest prediction failed: {e}\n")

    if args.model in ['cnn', 'both']:
        try:
            print("\n🧠 CNN Prediction")
            print("-" * 60)
            genre, confidence, top_3 = predict_with_cnn(audio_path)

            print(f"\n✅ Predicted Genre: {genre.upper()}")
            print(f"   Confidence: {confidence:.2%}\n")

            print("Top 3 predictions:")
            for i, (g, conf) in enumerate(top_3, 1):
                bar = '█' * int(conf * 40)
                print(f"   {i}. {g:12s} {bar:40s} {conf:.2%}")
            print()

        except Exception as e:
            print(f"❌ CNN prediction failed: {e}\n")

    print(f"{'='*60}\n")


if __name__ == '__main__':
    main()
