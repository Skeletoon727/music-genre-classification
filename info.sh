#!/bin/bash

# Music Genre Classification - Project Info Display

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

clear

echo -e "${BLUE}${BOLD}"
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                                                                   ║"
echo "║              🎵  MUSIC GENRE CLASSIFICATION  🎵                   ║"
echo "║                                                                   ║"
echo "║          Machine Learning for Audio Genre Recognition            ║"
echo "║                                                                   ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo ""
echo -e "${CYAN}${BOLD}📊 PROJECT OVERVIEW${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}✓${NC} Classifies music into ${BOLD}10 genres${NC}"
echo -e "  ${GREEN}✓${NC} Two approaches: ${BOLD}Random Forest${NC} + ${BOLD}CNN${NC}"
echo -e "  ${GREEN}✓${NC} Accuracy: ${BOLD}70-92%${NC}"
echo -e "  ${GREEN}✓${NC} Dataset: ${BOLD}GTZAN${NC} (1,000 tracks)"
echo ""

echo -e "${CYAN}${BOLD}🎯 GENRES SUPPORTED${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${PURPLE}♪${NC} blues      ${PURPLE}♪${NC} classical   ${PURPLE}♪${NC} country    ${PURPLE}♪${NC} disco     ${PURPLE}♪${NC} hiphop"
echo -e "  ${PURPLE}♪${NC} jazz       ${PURPLE}♪${NC} metal       ${PURPLE}♪${NC} pop        ${PURPLE}♪${NC} reggae    ${PURPLE}♪${NC} rock"
echo ""

echo -e "${CYAN}${BOLD}📁 PROJECT FILES${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}Documentation:${NC}"
echo -e "    📖 README.md              - Complete technical documentation"
echo -e "    🚀 QUICKSTART.md          - Quick start guide"
echo -e "    🏗️  PROJECT_STRUCTURE.md  - Architecture overview"
echo -e "    📊 SUMMARY.md             - Visual summary"
echo ""
echo -e "  ${YELLOW}Code:${NC}"
echo -e "    📓 music_genre_classification.ipynb  - Main notebook"
echo -e "    🎯 predict.py             - Prediction script"
echo -e "    📊 visualize.py           - Visualization tool"
echo -e "    🔧 setup.sh               - Setup automation"
echo ""
echo -e "  ${YELLOW}Configuration:${NC}"
echo -e "    📦 requirements.txt       - Python dependencies"
echo -e "    🚫 .gitignore             - Git ignore rules"
echo -e "    📜 LICENSE                - MIT License"
echo ""

echo -e "${CYAN}${BOLD}🚀 QUICK START${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}1.${NC} ${BOLD}Setup${NC}"
echo -e "     ${YELLOW}\$${NC} ./setup.sh"
echo ""
echo -e "  ${GREEN}2.${NC} ${BOLD}Train Models${NC} (run Jupyter notebook)"
echo -e "     ${YELLOW}\$${NC} jupyter notebook music_genre_classification.ipynb"
echo ""
echo -e "  ${GREEN}3.${NC} ${BOLD}Visualize Audio${NC}"
echo -e "     ${YELLOW}\$${NC} python visualize.py --genre jazz"
echo -e "     ${YELLOW}\$${NC} python visualize.py --audio song.wav --stats"
echo ""
echo -e "  ${GREEN}4.${NC} ${BOLD}Predict Genre${NC}"
echo -e "     ${YELLOW}\$${NC} python predict.py --audio song.wav --model both"
echo ""

echo -e "${CYAN}${BOLD}📈 PERFORMANCE${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}Random Forest${NC}  (Classical ML)"
echo -e "    Accuracy:      ${GREEN}70-85%${NC}"
echo -e "    Training:      ${GREEN}1-2 minutes${NC}"
echo -e "    Inference:     ${GREEN}<1 second${NC}"
echo ""
echo -e "  ${BOLD}CNN${NC}  (Deep Learning)"
echo -e "    Accuracy:      ${GREEN}80-92%${NC}"
echo -e "    Training:      ${GREEN}10-30 min (CPU)  /  2-5 min (GPU)${NC}"
echo -e "    Inference:     ${GREEN}<1 second${NC}"
echo ""

echo -e "${CYAN}${BOLD}📚 LEARN MORE${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}→${NC} Complete docs:     ${BOLD}cat README.md${NC}"
echo -e "  ${GREEN}→${NC} Quick start:       ${BOLD}cat QUICKSTART.md${NC}"
echo -e "  ${GREEN}→${NC} Architecture:      ${BOLD}cat PROJECT_STRUCTURE.md${NC}"
echo -e "  ${GREEN}→${NC} Summary:           ${BOLD}cat SUMMARY.md${NC}"
echo ""

echo -e "${CYAN}${BOLD}💡 TIPS${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}•${NC} First time setup takes ~30-60 minutes"
echo -e "  ${YELLOW}•${NC} Features are cached for faster subsequent runs"
echo -e "  ${YELLOW}•${NC} GPU support significantly speeds up CNN training"
echo -e "  ${YELLOW}•${NC} Try visualize.py to understand audio features"
echo ""

echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}  ${BOLD}Ready to classify some music? Start with:${NC} ${GREEN}./setup.sh${NC}           ${BLUE}║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
