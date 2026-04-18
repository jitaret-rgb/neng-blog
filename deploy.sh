#!/bin/bash
# Build site locally for preview
# Deployment is now handled automatically by GitHub Actions when you push to main

set -e

echo "🚀 Building site..."
rm -rf public
hugo --gc --minify

echo ""
echo "✅ Build complete! Output is in ./public/"
echo ""
echo "📡 Deployment:"
echo "   GitHub Actions will deploy automatically when you push to 'main'."
echo ""
echo "   git add ."
echo "   git commit -m 'your message'"
echo "   git push origin main"
echo ""
