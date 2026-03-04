# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-04

### 🎉 Initial Release

**Major Achievement: 90% Test Accuracy (State-of-the-Art)**

### Added

#### Models
- **CNN Model** - Convolutional Neural Network for genre classification (90% accuracy)
- **Random Forest Model** - Classical ML baseline with handcrafted features (69% accuracy)
- Mel-spectrogram feature extraction (96 mel bands, 10-second segments)
- MFCC feature extraction for classical ML approach

#### Scripts & Tools
- `predict.py` - Standalone prediction script for both models
- `install_from_zip.sh` - Dataset installation from Kaggle archive
- `info.sh` - System information utility

#### Documentation
- `README.md` - Comprehensive technical documentation
- `QUICKSTART.md` - 5-minute quick start guide
- `DOWNLOAD_INSTRUCTIONS.md` - Detailed dataset download guide
- `CONTRIBUTING.md` - Contribution guidelines
- `LICENSE` - MIT License

#### Notebook
- Complete Jupyter notebook with:
  - Data exploration and visualization
  - Feature extraction pipeline
  - Model training and evaluation
  - Comprehensive results analysis
  - Prediction examples

### Key Features

#### Data Augmentation
- **3x augmentation** using temporal segmentation (0-10s, 10-20s, 20-30s)
- Increased dataset from 1,000 → 3,000 samples
- No complex augmentations needed

#### Architecture Innovations
- **No normalization** on mel-spectrograms (raw dB scale works best)
- **No BatchNormalization** (caused training instability)
- **GlobalAveragePooling** instead of Flatten (reduces overfitting)
- **High dropout** (0.3-0.5) optimized for small dataset

#### Performance
- **90% test accuracy** on GTZAN dataset
- **Per-genre excellence**:
  - Blues: 98% F1-score
  - Metal: 96% F1-score
  - Jazz: 93% F1-score
  - Classical: 91% F1-score
- **+30% improvement** over classical ML baseline

### Technical Details

#### CNN Architecture
```
Input: (96, 287, 1) Mel-spectrogram
Conv2D(32) + MaxPool + Dropout(0.3)
Conv2D(64) + MaxPool + Dropout(0.3)
Conv2D(128) + MaxPool + Dropout(0.4)
Conv2D(256) + MaxPool + Dropout(0.4)
GlobalAveragePooling2D
Dense(128) + Dropout(0.5)
Output: Softmax(10)
```

#### Training
- Optimizer: Adam (lr=0.001 → 0.0005)
- Batch size: 32
- Epochs: 46 (early stopping)
- Time: ~3-4 hours (CPU)

#### Dataset
- GTZAN: 1,000 audio files (100 per genre)
- 10 genres: blues, classical, country, disco, hiphop, jazz, metal, pop, reggae, rock
- 30 seconds per track @ 22,050 Hz

### Fixed

#### Critical Bugs
- **Normalization issue** - All normalization schemes destroyed information
  - Solution: Use raw dB-scale spectrograms
  - Impact: Val accuracy 13% → 90%
- **Tempo extraction error** - Array/scalar conversion issues
  - Added proper error handling with fallback to 120 BPM
- **Parameter mismatch** - predict.py used wrong spectrogram parameters
  - Fixed: 128 mels/30s → 96 mels/10s (matches training)

#### Performance Issues
- **Training too slow** - 42s/step with 30s segments
  - Solution: 10-second segments with 3x augmentation
  - Result: 2-5s/step + better accuracy
- **Overfitting** - 75% train vs 57% val (18% gap)
  - Solution: Higher dropout + GlobalAveragePooling
  - Result: Gap reduced to ~5-10%

### Changed
- Switched from 128 → 96 mel bands (better balance)
- Reduced segment length from 30s → 10s (3x augmentation)
- Removed BatchNormalization (caused instability)
- Increased dropout rates (0.25 → 0.3-0.5)

### Removed
- Obsolete download scripts (all sources failed)
- Redundant documentation files (moved to archive/)
- tensorflow-datasets dependency (not needed)
- kaggle API dependency (manual download preferred)

## Development Journey

### Phase 1: Dataset Acquisition (~2 hours)
- Tested multiple automatic download sources (all failed)
- **Solution**: Manual download from Kaggle + custom extraction script

### Phase 2: Normalization Crisis (~6 hours)
- Attempted per-sample standardization → Failed
- Attempted global min-max → Failed
- Attempted global standardization → Failed
- **Solution**: No normalization - raw dB spectrograms work best

### Phase 3: Speed Optimization (~3 hours)
- Original: 42s/step (too slow)
- Over-optimized: 0.5s/step (poor accuracy)
- **Solution**: 10s segments with augmentation (2-5s/step + 90% accuracy)

### Phase 4: Overfitting Reduction (~2 hours)
- Initial: 18% train/val gap
- Applied: Higher dropout + GlobalAveragePooling
- **Result**: ~5-10% gap with excellent test performance

## Diagnostic Methodology

**Key Insight**: Used Random Forest on raw spectrograms (51.5% accuracy) to prove data quality before tuning CNN. This diagnostic test revealed normalization was destroying information, not data quality issues.

## Comparison with Literature

| Source | Accuracy | Notes |
|--------|----------|-------|
| Published papers | 85-92% | State-of-the-art range |
| **This project** | **90%** | **Within SOTA range** ✓ |
| Human agreement | 85-90% | Theoretical ceiling |

## Known Limitations

1. **Rock genre** - 78% F1 (confused with metal/pop)
2. **Small dataset** - Only 1,000 original tracks
3. **CPU training** - 3-4 hours (would be faster with GPU)
4. **No multi-label** - Assumes single genre per track

## Future Roadmap

### Version 1.1 (Planned)
- [ ] Data augmentation (pitch shift, time stretch)
- [ ] Ensemble methods (multiple models)
- [ ] Web demo (Streamlit/Gradio)

### Version 1.2 (Planned)
- [ ] FMA dataset support (larger dataset)
- [ ] Transfer learning from AudioSet
- [ ] Attention mechanisms

### Version 2.0 (Future)
- [ ] Transformer architectures
- [ ] Multi-label classification
- [ ] Real-time streaming prediction

## Citation

If you use this project in your research, please cite:

```bibtex
@software{music_genre_classification_2026,
  author = {Your Name},
  title = {Music Genre Classification: 90% Accuracy with CNNs},
  year = {2026},
  publisher = {GitHub},
  url = {https://github.com/yourusername/music_detect}
}
```

---

**Note**: This project demonstrates that careful data handling and diagnostic testing are more important than complex architectures for achieving state-of-the-art results.
