#!/bin/bash
# Organize resume project structure
# Moves all .tex and .cls files to src/ directory

echo "📁 Organizing resume project structure..."

# Create src directory if it doesn't exist
mkdir -p src

# Move all .tex files to src/
echo "Moving .tex files to src/..."
mv *.tex src/ 2>/dev/null

# Move resume.cls to src/ (in case it's in root)
if [ -f "resume.cls" ]; then
    echo "Moving resume.cls to src/..."
    mv resume.cls src/
fi

echo "✅ Done! Files organized:"
echo "---"
ls -la src/
echo "---"
echo "Ready to build! Run: ./scripts/build.sh resume2.0 --view"
