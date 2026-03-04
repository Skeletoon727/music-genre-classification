#!/bin/bash

# Script d'installation du dataset GTZAN depuis Data.zip téléchargé

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         GTZAN Dataset Installation from Data.zip          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Configuration
TARGET_DIR="/Volumes/Data_IA/music_genres/GTZAN"
GENRES_DIR="$TARGET_DIR/genres"

# Rechercher Data.zip dans les emplacements probables
ZIP_LOCATIONS=(
    "~/Downloads/Data.zip"
    "~/Downloads/archive.zip"
    "./Data.zip"
    "./archive.zip"
)

ZIP_FILE=""
for loc in "${ZIP_LOCATIONS[@]}"; do
    expanded_loc="${loc/#\~/$HOME}"
    if [ -f "$expanded_loc" ]; then
        ZIP_FILE="$expanded_loc"
        echo -e "${GREEN}✓${NC} Found: $ZIP_FILE"
        break
    fi
done

if [ -z "$ZIP_FILE" ]; then
    echo -e "${RED}✗${NC} Data.zip not found in common locations"
    echo ""
    echo "Please specify the path to Data.zip:"
    read -p "Path: " user_path

    if [ -f "$user_path" ]; then
        ZIP_FILE="$user_path"
        echo -e "${GREEN}✓${NC} Found: $ZIP_FILE"
    else
        echo -e "${RED}✗${NC} File not found: $user_path"
        exit 1
    fi
fi

# Vérifier la taille du fichier
FILE_SIZE=$(du -h "$ZIP_FILE" | cut -f1)
echo -e "${BLUE}→${NC} File size: $FILE_SIZE"
echo ""

# Créer un répertoire temporaire
TEMP_DIR=$(mktemp -d)
echo -e "${YELLOW}→${NC} Extracting to temporary directory..."

# Extraire
if unzip -q "$ZIP_FILE" -d "$TEMP_DIR"; then
    echo -e "${GREEN}✓${NC} Extraction complete"
else
    echo -e "${RED}✗${NC} Extraction failed"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Trouver le dossier genres_original
GENRES_ORIGINAL=""
if [ -d "$TEMP_DIR/Data/genres_original" ]; then
    GENRES_ORIGINAL="$TEMP_DIR/Data/genres_original"
elif [ -d "$TEMP_DIR/genres_original" ]; then
    GENRES_ORIGINAL="$TEMP_DIR/genres_original"
elif [ -d "$TEMP_DIR/Data/genres" ]; then
    GENRES_ORIGINAL="$TEMP_DIR/Data/genres"
elif [ -d "$TEMP_DIR/genres" ]; then
    GENRES_ORIGINAL="$TEMP_DIR/genres"
else
    echo -e "${RED}✗${NC} Could not find genres folder in archive"
    echo ""
    echo "Archive contents:"
    find "$TEMP_DIR" -maxdepth 2 -type d
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo -e "${GREEN}✓${NC} Found genres folder: $GENRES_ORIGINAL"

# Compter les fichiers
GENRE_COUNT=$(find "$GENRES_ORIGINAL" -maxdepth 1 -type d | wc -l | tr -d ' ')
GENRE_COUNT=$((GENRE_COUNT - 1))  # Soustraire le dossier parent
FILE_COUNT=$(find "$GENRES_ORIGINAL" -name "*.wav" | wc -l | tr -d ' ')

echo -e "${BLUE}→${NC} Genres found: $GENRE_COUNT"
echo -e "${BLUE}→${NC} Audio files: $FILE_COUNT"

if [ "$FILE_COUNT" -lt 900 ]; then
    echo -e "${YELLOW}⚠${NC}  Warning: Expected ~1000 files, found $FILE_COUNT"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$TEMP_DIR"
        exit 1
    fi
fi

# Créer le répertoire de destination
echo -e "${YELLOW}→${NC} Creating target directory..."
mkdir -p "$TARGET_DIR"

# Supprimer l'ancien dataset s'il existe
if [ -d "$GENRES_DIR" ]; then
    echo -e "${YELLOW}⚠${NC}  Existing dataset found"
    read -p "Replace existing dataset? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}→${NC} Removing old dataset..."
        rm -rf "$GENRES_DIR"
    else
        rm -rf "$TEMP_DIR"
        echo "Installation cancelled"
        exit 0
    fi
fi

# Déplacer le dossier
echo -e "${YELLOW}→${NC} Installing dataset..."
mv "$GENRES_ORIGINAL" "$GENRES_DIR"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Dataset installed successfully!"
else
    echo -e "${RED}✗${NC} Failed to move dataset"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Nettoyer
echo -e "${YELLOW}→${NC} Cleaning up..."
rm -rf "$TEMP_DIR"

# Vérification finale
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              Installation Successful! ✓                    ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Dataset location:${NC} $GENRES_DIR"
echo ""

# Lister les genres
echo "Genres installed:"
ls -1 "$GENRES_DIR" 2>/dev/null | while read genre; do
    count=$(ls "$GENRES_DIR/$genre"/*.wav 2>/dev/null | wc -l | tr -d ' ')
    printf "  %-15s %3d files\n" "$genre" "$count"
done

TOTAL=$(find "$GENRES_DIR" -name "*.wav" | wc -l | tr -d ' ')
echo ""
echo -e "${GREEN}Total:${NC} $TOTAL audio files"

# Demander si on doit supprimer le zip
echo ""
read -p "Delete the downloaded Data.zip file? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -f "$ZIP_FILE"
    echo -e "${GREEN}✓${NC} Cleaned up Data.zip"
fi

echo ""
echo "Next steps:"
echo "  1. Open Jupyter notebook:"
echo "     jupyter notebook music_genre_classification.ipynb"
echo ""
echo "  2. Run cell 5 to verify the dataset"
echo ""
echo "  3. Start training your models!"
echo ""
