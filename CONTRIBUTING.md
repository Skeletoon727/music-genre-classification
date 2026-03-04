# Contributing to Music Genre Classification

Thank you for your interest in contributing to this project! This guide will help you get started.

## 🎯 Project Goals

This is an **educational project** focused on:
- Teaching music genre classification with ML/DL
- Providing clear, well-documented code
- Achieving state-of-the-art results (current: 90% accuracy)
- Maintaining simplicity and clarity

## 🚀 Quick Start for Contributors

### 1. Setup Development Environment

```bash
# Clone the repository
git clone <repository-url>
cd music_detect

# Install dependencies
pip install -r requirements.txt
# or with uv
uv pip install -r requirements.txt

# Download dataset (see DOWNLOAD_INSTRUCTIONS.md)
```

### 2. Run Tests

```bash
# Test the prediction script
uv run python predict.py --audio /path/to/test.wav --model both

# Run the notebook
jupyter notebook music_genre_classification.ipynb
```

## 📝 How to Contribute

### Areas for Contribution

We welcome contributions in these areas:

#### 1. **Model Improvements** ⭐
- Data augmentation (pitch shift, time stretch)
- Advanced architectures (ResNet, Attention, Transformers)
- Ensemble methods
- Hyperparameter optimization

**Current performance**: 90% accuracy
**Target**: 92-95% accuracy

#### 2. **Code Quality**
- Add unit tests
- Improve error handling
- Code optimization
- Better documentation

#### 3. **Dataset Support**
- Support for FMA dataset (larger dataset)
- Support for custom datasets
- Multi-label classification (songs with multiple genres)

#### 4. **User Interface**
- Web demo (Streamlit, Gradio)
- Desktop app
- Mobile app integration

#### 5. **Documentation**
- Tutorial videos
- Blog posts explaining the approach
- Translation to other languages
- More detailed technical explanations

#### 6. **Deployment**
- Docker containerization
- API deployment (FastAPI, Flask)
- Model optimization for edge devices
- Cloud deployment guides (AWS, GCP, Azure)

## 🔧 Development Workflow

### 1. Fork & Clone

```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/YOUR_USERNAME/music_detect.git
cd music_detect
```

### 2. Create a Branch

```bash
# Create a feature branch
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/bug-description
```

### 3. Make Changes

- Follow the existing code style
- Add comments for complex logic
- Update documentation if needed
- Test your changes thoroughly

### 4. Commit

```bash
# Stage your changes
git add .

# Commit with a clear message
git commit -m "Add: brief description of your changes"

# Examples:
# "Add: data augmentation with pitch shifting"
# "Fix: tempo extraction error in predict.py"
# "Update: README with new accuracy results"
# "Improve: CNN architecture with attention mechanism"
```

### 5. Push & Pull Request

```bash
# Push to your fork
git push origin feature/your-feature-name

# Create a Pull Request on GitHub
```

## 📋 Pull Request Guidelines

### Before Submitting

- ✅ Code runs without errors
- ✅ Documentation is updated (if applicable)
- ✅ Changes are tested
- ✅ Commit messages are clear

### PR Description Template

```markdown
## Description
Brief description of what this PR does.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Code refactoring

## Testing
How did you test your changes?

## Results (if applicable)
- Previous accuracy: X%
- New accuracy: Y%
- Performance impact: ...

## Checklist
- [ ] Code follows the project style
- [ ] Documentation updated
- [ ] All tests pass
- [ ] No breaking changes (or documented)
```

## 🎨 Code Style

### Python Style
- Follow PEP 8
- Use meaningful variable names
- Add docstrings to functions
- Keep functions focused (single responsibility)

### Example:

```python
def extract_mel_spectrogram(file_path, n_mels=96, duration=10, offset=0.0):
    """
    Extract mel-spectrogram from an audio segment.

    Args:
        file_path (str): Path to audio file
        n_mels (int): Number of mel bands (default: 96)
        duration (float): Duration in seconds (default: 10)
        offset (float): Start time in seconds (default: 0.0)

    Returns:
        numpy.ndarray: Mel-spectrogram in dB scale with shape (n_mels, time)

    Raises:
        FileNotFoundError: If audio file doesn't exist
    """
    # Implementation...
```

### Notebook Style
- Clear markdown explanations
- Section headers for organization
- Comments in code cells
- Visualizations where helpful

## 🐛 Reporting Bugs

### Before Reporting
1. Check if the bug is already reported (GitHub Issues)
2. Try to reproduce the bug
3. Collect error messages and logs

### Bug Report Template

```markdown
**Description**
Clear description of the bug.

**To Reproduce**
Steps to reproduce:
1. Run command: ...
2. With parameters: ...
3. Error occurs at: ...

**Expected Behavior**
What should happen?

**Actual Behavior**
What actually happens?

**Environment**
- OS: [e.g., macOS 14.0, Ubuntu 22.04]
- Python version: [e.g., 3.11.5]
- TensorFlow version: [e.g., 2.20.0]
- GPU: [Yes/No]

**Error Messages**
```
Paste full error traceback here
```

**Additional Context**
Any other relevant information.
```

## 💡 Suggesting Features

We love new ideas! Before suggesting:
1. Check if it's already proposed (GitHub Issues)
2. Consider if it fits the project goals
3. Think about implementation complexity

### Feature Request Template

```markdown
**Feature Description**
Clear description of the proposed feature.

**Motivation**
Why is this feature useful?

**Proposed Solution**
How would you implement it?

**Alternatives Considered**
Other ways to achieve the same goal?

**Additional Context**
Examples, mockups, references, etc.
```

## 📊 Performance Benchmarks

When contributing model improvements, please include:

### Metrics to Report
- **Test accuracy**: Overall accuracy on test set
- **Per-genre F1-scores**: Performance breakdown
- **Training time**: Time to convergence
- **Inference speed**: Predictions per second
- **Model size**: Number of parameters

### Comparison Format

| Metric | Current (Baseline) | Your Improvement | Change |
|--------|-------------------|------------------|--------|
| Test Accuracy | 90% | 92% | +2% ✓ |
| Training Time | 3-4 hours | 2 hours | -50% ✓ |
| Model Size | 1.2M params | 2.5M params | +108% ⚠ |

## 🧪 Testing Guidelines

### Manual Testing
```bash
# Test on multiple genres
uv run python predict.py --audio blues_track.wav --model cnn
uv run python predict.py --audio metal_track.wav --model cnn
uv run python predict.py --audio jazz_track.wav --model cnn

# Test both models
uv run python predict.py --audio test.wav --model both
```

### Automated Testing (Future)
We plan to add:
- Unit tests with pytest
- Integration tests
- CI/CD with GitHub Actions

## 📚 Resources for Contributors

### Understanding the Project
1. Read [README.md](README.md) - Full technical details
2. Read [QUICKSTART.md](QUICKSTART.md) - Quick overview
3. Study the notebook - Understand the full pipeline

### Learning Resources
- **Music Information Retrieval**: [ISMIR Conference](https://ismir.net/)
- **Audio Processing**: [Librosa Documentation](https://librosa.org/)
- **Deep Learning**: [TensorFlow Tutorials](https://www.tensorflow.org/tutorials)
- **GTZAN Papers**: Search "GTZAN music genre classification" on Google Scholar

## 🎖️ Recognition

Contributors will be:
- Added to the project README
- Credited in release notes
- Mentioned in academic acknowledgments (if applicable)

## ❓ Questions?

- **General questions**: Open a GitHub Discussion
- **Bug reports**: Open a GitHub Issue
- **Feature proposals**: Open a GitHub Issue with [FEATURE] tag

## 📜 Code of Conduct

### Our Standards
- Be respectful and inclusive
- Provide constructive feedback
- Focus on what's best for the project
- Accept criticism gracefully
- Show empathy towards others

### Not Acceptable
- Harassment or discriminatory language
- Personal attacks
- Trolling or insulting comments
- Publishing others' private information
- Unprofessional conduct

## 🎯 Current Priority Areas

**High Priority:**
1. Data augmentation implementation
2. Ensemble method testing
3. Web demo (Streamlit/Gradio)

**Medium Priority:**
4. FMA dataset support
5. Docker containerization
6. Automated testing

**Low Priority:**
7. Mobile integration
8. Multi-language support
9. Advanced architectures (Transformers)

## 📞 Contact

For major contributions or questions, feel free to reach out:
- GitHub Issues: For bugs and features
- GitHub Discussions: For questions and ideas

---

**Thank you for contributing to music genre classification!** 🎵

Every contribution, no matter how small, helps make this project better for everyone learning about audio ML/DL.
