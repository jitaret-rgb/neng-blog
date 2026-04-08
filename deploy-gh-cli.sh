#!/bin/bash
# Deploy using GitHub CLI

set -e

echo "🚀 Building site..."
rm -rf public
hugo --gc --minify

echo "📤 Deploying via GitHub CLI..."
gh pages deploy public --branch gh-pages

echo "✅ Done!"
