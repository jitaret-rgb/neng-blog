#!/bin/bash
# Deploy to GitHub Pages via gh-pages branch

set -e

echo "🚀 Building site..."
rm -rf public
hugo --gc --minify

echo "📁 Setting up gh-pages..."
cd public
git init
git remote add origin git@github.com:jitaret-rgb/neng-blog.git 2>/dev/null || true
git checkout -b gh-pages 2>/dev/null || git checkout gh-pages

echo "📤 Pushing to GitHub..."
git add .
git commit -m "Deploy: $(date '+%Y-%m-%d %H:%M:%S')" || echo "No changes to commit"
git push -f origin gh-pages

echo "✅ Deployed to https://jitaret-rgb.github.io/neng-blog/"
