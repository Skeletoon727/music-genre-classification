# Quick Start Guide 🚀

Get started with music genre classification in 5 minutes!

## Prerequisites

- Python 3.8 or higher
- At least 4GB free disk space
- Internet connection (for dataset download)

## Step 1: Install Dependencies (2 minutes)

```bash
# Clone or navigate to the project directory
cd music_detect

# Install required packages
pip install -r requirements.txt
```

## Step 2: Download the Dataset (5-10 minutes)

### Option A: Manual Download (Recommended)

1. Go to [Kaggle GTZAN Dataset](https://www.kaggle.com/datasets/andradaolteanu/gtzan-dataset-music-genre-classification)
2. Click "Download" (requires Kaggle account)
3. Extract the zip file to `/Volumes/Data_IA/music_genres/GTZAN/`

Your directory structure should look like:
```
/Volumes/Data_IA/
└── music_genres/
    └── GTZAN/
        └── Data/
            └── genres_original/
                ├── blues/
                ├── classical/
                ├── country/
                └── ... (10 genres total)
```

### Option B: Using Kaggle API

```bash
# 1. Get your Kaggle API credentials
#    - Go to https://www.kaggle.com/account
#    - Click "Create New API Token"
#    - Place kaggle.json in ~/.kaggle/

# 2. Run the download cell in the notebook
#    (Uncomment the download_gtzan_kaggle() call)
```

## Step 3: Run the Notebook (30-60 minutes)

```bash
# Start Jupyter Notebook
jupyter notebook music_genre_classification.ipynb
```

### Quick Execution Guide

Execute cells in order. Key milestones:

1. **Cells 1-2**: Setup ✓ (30 seconds)
2. **Cells 3-4**: Verify dataset ✓ (10 seconds)
3. **Cells 5-6**: Explore data ✓ (1 minute)
4. **Cells 7-8**: Extract features ⏰ (5-10 minutes)
5. **Cells 9-12**: Train Random Forest ✓ (1-2 minutes)
6. **Cells 13-14**: Create spectrograms ⏰ (10-15 minutes)
7. **Cells 15-17**: Train CNN ⏰ (10-30 minutes depending on GPU)
8. **Cells 18-20**: Evaluate and predict ✓ (1 minute)

**Total time**: 30-60 minutes (mostly waiting for feature extraction)

### Pro Tips

- **First time**: Run all cells sequentially
- **Second time**: Features/spectrograms are cached, much faster!
- **GPU**: CNN training is much faster with GPU (2-5 minutes vs 20-30 minutes)

## Step 4: Make Predictions (30 seconds)

### Using the Notebook

```python
# In the notebook, run cell 20:
genre, confidence = predict_genre('path/to/your/audio.wav', model_type='cnn')
print(f"Genre: {genre} ({confidence:.2%})")
```

### Using the Command Line Script

```bash
# Predict with CNN (recommended - 90% accuracy)
uv run python predict.py --audio path/to/audio.wav --model cnn

# Predict with Random Forest (baseline - 69% accuracy)
uv run python predict.py --audio path/to/audio.wav --model rf

# Predict with both models (comparison)
uv run python predict.py --audio path/to/audio.wav --model both
```

Example output:
```
============================================================
Music Genre Prediction
============================================================
Audio file: song.wav
============================================================

🧠 CNN Prediction
------------------------------------------------------------

✅ Predicted Genre: ROCK
   Confidence: 87.34%

Top 3 predictions:
   1. rock         ████████████████████████████████████     87.34%
   2. metal        ████████                                  8.52%
   3. pop          ██                                        2.41%
```

## Troubleshooting

### Common Issues

#### 1. `ModuleNotFoundError: No module named 'librosa'`

**Solution**: Install dependencies
```bash
pip install -r requirements.txt
```

#### 2. `FileNotFoundError: Dataset not found`

**Solution**: Check dataset path
- Expected: `/Volumes/Data_IA/music_genres/GTZAN/Data/genres_original/`
- Verify 10 genre folders exist
- Each folder should have ~100 .wav files

#### 3. `ResourceExhaustedError` during CNN training

**Solution**: Reduce batch size
```python
# In the notebook, cell 16, change:
batch_size=32  # to
batch_size=16  # or even 8
```

#### 4. CNN training is very slow

**Solutions**:
- **Use GPU**: Install `tensorflow-gpu` if you have NVIDIA GPU
- **Reduce epochs**: Change `epochs=100` to `epochs=50`
- **Use cached model**: If training completed once, model is saved

#### 5. Audio file format not supported

**Supported formats**: WAV, MP3, FLAC, OGG

**Solution**: Convert your file
```bash
# Using ffmpeg
ffmpeg -i input.mp3 output.wav
```

## Actual Results Achieved

### Random Forest (Classical ML)
- **Accuracy**: **69%** ✓
- **Training time**: ~1 minute
- **Strengths**: Fast, interpretable, solid baseline
- **Weaknesses**: Lower accuracy, manual feature engineering

### CNN (Deep Learning)
- **Accuracy**: **90%** ⭐ (state-of-the-art range: 85-92%)
- **Training time**: 3-4 hours (CPU)
- **Strengths**: Excellent accuracy, automatic feature learning
- **Best genres**: Blues (98%), Metal (96%), Jazz (93%)
- **Challenging**: Rock (78% - confused with metal/pop)

**Performance gain**: +30% improvement with deep learning (90% vs 69%)

## Next Steps

Once you have the basic system working:

1. **Experiment with hyperparameters**
   - Try different CNN architectures
   - Adjust learning rates, dropout rates
   - Experiment with different optimizers

2. **Try data augmentation**
   - Time stretching
   - Pitch shifting
   - Add background noise

3. **Test on your own music**
   - Use the `predict.py` script
   - Analyze misclassifications
   - Understand model limitations

4. **Explore other datasets**
   - FMA (Free Music Archive) - larger dataset
   - Your personal music collection

5. **Build applications**
   - Web interface with Streamlit/Gradio
   - Music organization tool
   - Playlist generator

## Resources

- **Full documentation**: See [README.md](README.md)
- **Notebook**: `music_genre_classification.ipynb`
- **Prediction script**: `predict.py`

## Need Help?

Check the following resources:

1. **Librosa documentation**: https://librosa.org/
2. **TensorFlow tutorials**: https://www.tensorflow.org/tutorials
3. **GTZAN benchmark papers**: Search "GTZAN music genre classification"

## Cheat Sheet

```bash
# Installation
pip install -r requirements.txt
# or with uv
uv pip install -r requirements.txt

# Start notebook
jupyter notebook music_genre_classification.ipynb

# Predict genre (after training)
uv run python predict.py --audio song.wav --model cnn

# Predict with both models
uv run python predict.py --audio song.wav --model both

# Check GPU availability
python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

# Test librosa installation
python -c "import librosa; print(librosa.__version__)"
```

---

**Happy music classification!** 🎵

If you encounter any issues not covered here, refer to the main [README.md](README.md) for detailed technical information.
