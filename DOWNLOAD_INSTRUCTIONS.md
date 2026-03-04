# 📥 GTZAN Dataset Download Instructions

## Quick Download Guide

**Dataset Size**: ~1.2 GB (uncompressed)
**Download Time**: 5-10 minutes (depending on your internet speed)

---

## ✅ Method 1: Kaggle (RECOMMENDED - Fastest & Most Reliable)

### Step 1: Download

1. Go to: https://www.kaggle.com/datasets/andradaolteanu/gtzan-dataset-music-genre-classification
2. Click the **"Download"** button
3. You'll get: `archive.zip` (~1.3 GB)

**Note**: Requires a free Kaggle account (sign up takes 1 minute)

### Step 2: Extract and Install

**Option A: Using Finder (macOS GUI)**

1. Open `archive.zip` (double-click to extract)
2. You'll see a folder called `Data`
3. Inside `Data`, find the folder `genres_original`
4. Rename `genres_original` to `genres`
5. Move the `genres` folder to: `/Volumes/Data_IA/music_genres/GTZAN/`

**Option B: Using Terminal (Fast)**

```bash
# Navigate to Downloads
cd ~/Downloads

# Extract archive
unzip archive.zip

# Create target directory
mkdir -p /Volumes/Data_IA/music_genres/GTZAN

# Move and rename the genres folder
mv Data/genres_original /Volumes/Data_IA/music_genres/GTZAN/genres

# Clean up (optional)
rm -rf Data archive.zip
```

### Step 3: Verify

Run this command to verify:

```bash
ls /Volumes/Data_IA/music_genres/GTZAN/genres/
```

**Expected output** (10 folders):
```
blues/      classical/  country/    disco/      hiphop/
jazz/       metal/      pop/        reggae/     rock/
```

---

## 🔄 Method 2: Google Drive (Alternative)

### Download Link

https://drive.google.com/drive/folders/1-1N_0DrFOloR77vO8N-kyjq72GLT3s05

### Instructions

1. Download the `genres` folder
2. Move it to: `/Volumes/Data_IA/music_genres/GTZAN/`

---

## 🌐 Method 3: Direct Download (Slow - Not Recommended)

**Warning**: This method can be very slow (hours)

```bash
cd /Volumes/Data_IA/music_genres/GTZAN
wget http://opihi.cs.uvic.ca/sound/genres.tar.gz
tar -xzf genres.tar.gz
rm genres.tar.gz
```

---

## 📂 Final Directory Structure

After installation, you should have:

```
/Volumes/Data_IA/music_genres/GTZAN/
└── genres/
    ├── blues/          (100 .wav files)
    ├── classical/      (100 .wav files)
    ├── country/        (100 .wav files)
    ├── disco/          (100 .wav files)
    ├── hiphop/         (100 .wav files)
    ├── jazz/           (100 .wav files)
    ├── metal/          (100 .wav files)
    ├── pop/            (100 .wav files)
    ├── reggae/         (100 .wav files)
    └── rock/           (100 .wav files)

Total: 1,000 audio files (~1.2 GB)
```

---

## ✅ Verification

### Check from Terminal

```bash
# Check directory exists
ls -la /Volumes/Data_IA/music_genres/GTZAN/genres/

# Count total files
find /Volumes/Data_IA/music_genres/GTZAN/genres/ -name "*.wav" | wc -l
# Should output: 1000
```

### Check from Jupyter Notebook

Run cell 5 in the notebook. You should see:

```
✅ Dataset found!
   Location: /Volumes/Data_IA/music_genres/GTZAN/genres
   Genres (10): blues, classical, country, disco, hiphop, jazz, metal, pop, reggae, rock
   ...
   Total audio files: 1000

✅ Dataset ready to use!
```

---

## ❓ Troubleshooting

### Problem: "Dataset NOT found"

**Solution**: Check the path is exactly:
```
/Volumes/Data_IA/music_genres/GTZAN/genres/
```

Not:
- ❌ `/Volumes/Data_IA/music_genres/GTZAN/genres_original/`
- ❌ `/Volumes/Data_IA/music_genres/GTZAN/Data/genres/`

### Problem: "Dataset may be incomplete"

**Solution**: Re-download from Kaggle. Make sure you have all 10 genre folders with ~100 files each.

### Problem: Download is very slow

**Solution**:
1. Stop any running downloads
2. Use Kaggle method (Method 1)
3. Avoid the direct download method (Method 3)

---

## 💾 Disk Space Requirements

- **During download**: ~2.5 GB (archive + extracted files)
- **After cleanup**: ~1.2 GB (just the audio files)
- **After training**: ~1.8 GB (audio + models + features)

---

## 🚀 After Download

Once the dataset is installed:

1. Open the notebook: `jupyter notebook music_genre_classification.ipynb`
2. Run cell 5 to verify the dataset
3. Continue with the rest of the cells to train your models!

---

**Need help?** Check the main [README.md](README.md) or [QUICKSTART.md](QUICKSTART.md)
