#!/bin/bash
# Bash Build Script for LaTeX Resumes - Builds ALL .tex files
# Usage: ./scripts/build.sh [--clean] [--view]
# Example: ./scripts/build.sh
#          ./scripts/build.sh --view
#          ./scripts/build.sh --clean

CLEAN_FLAG=false
VIEW_FLAG=false

# Parse flags
for arg in "$@"; do
    case $arg in
        --clean) CLEAN_FLAG=true ;;
        --view) VIEW_FLAG=true ;;
    esac
done

SOURCE_DIR="src"
BUILD_DIR="build"
PDF_DIR="pdf"

# Ensure directories exist
mkdir -p "$BUILD_DIR"
mkdir -p "$PDF_DIR"

# Clean option
if $CLEAN_FLAG; then
    echo -e "\033[33mCleaning build artifacts and PDFs...\033[0m"
    rm -f "$BUILD_DIR"/*.aux "$BUILD_DIR"/*.log "$BUILD_DIR"/*.out "$BUILD_DIR"/*.fls "$BUILD_DIR"/*.fdb_latexmk
    rm -f "$PDF_DIR"/*.pdf
    echo -e "\033[32mCleaned.\033[0m"
    exit 0
fi

# Check if src directory has any .tex files
TEX_FILES=$(find "$SOURCE_DIR" -maxdepth 1 -name "*.tex" -type f)
if [ -z "$TEX_FILES" ]; then
    echo -e "\033[31mError: No .tex files found in $SOURCE_DIR/\033[0m"
    exit 1
fi

# Build all .tex files
BUILD_SUCCESS=true
for TEX_FILE in $TEX_FILES; do
    RESUME_NAME=$(basename "$TEX_FILE" .tex)
    PDF_FILE="$PDF_DIR/$RESUME_NAME.pdf"
    
    echo -e "\033[36mBuilding $RESUME_NAME.tex...\033[0m"
    
    # Use latexmk for intelligent builds
    # Run from src directory so LaTeX can find resume.cls
    # -outdir for PDFs, -auxdir for artifacts
    (cd "$SOURCE_DIR" && latexmk -pdf \
        -pdflatex="pdflatex -interaction=nonstopmode -synctex=1" \
        -outdir="../$PDF_DIR" \
        -auxdir="../$BUILD_DIR" \
        "$(basename "$TEX_FILE")")
    
    if [ $? -eq 0 ]; then
        echo -e "\033[32m✅ $RESUME_NAME.pdf built successfully\033[0m"
        
        # View option
        if $VIEW_FLAG; then
            echo -e "\033[33mOpening $PDF_FILE...\033[0m"
            if command -v xdg-open &> /dev/null; then
                xdg-open "$PDF_FILE"
            elif command -v open &> /dev/null; then
                open "$PDF_FILE"
            fi
        fi
    else
        echo -e "\033[31m❌ $RESUME_NAME build failed. Check logs in $BUILD_DIR/\033[0m"
        BUILD_SUCCESS=false
    fi
done

if $BUILD_SUCCESS; then
    echo -e "\033[32m\n✅ All builds completed successfully!\033[0m"
    echo -e "PDFs in: $BUILD_DIR/"
else
    echo -e "\033[31m\n❌ Some builds failed.\033[0m"
    exit 1
fi
