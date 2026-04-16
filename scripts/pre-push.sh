#!/bin/bash
# pre-push.sh - ตรวจสอบทุกอย่างก่อน push neng-blog
# ใช้: ./scripts/pre-push.sh

set -e  # หยุดทันทีถ้ามี error

echo "🚀 Running Pre-Push Checks..."
echo ""

cd /home/nenglab/.openclaw/workspace/neng-blog

# 1. Check Internal Status
echo "🔍 1. Checking internal workflow status..."
if grep -rE "\*(Reviewer|Writer|Coder).*Complete\*|Status:.*(ตรวจสอบ|เสร็จ|ผ่าน)" content/posts/ --include="*.md" 2>/dev/null; then
  echo "❌ พบ internal workflow status!"
  echo "   กรุณาลบออกก่อน push"
  exit 1
fi
echo "✅ ไม่พบ internal status"
echo ""

# 2. Check Frontmatter (เฉพาะไฟล์ที่แก้ไขล่าสุด)
echo "🔍 2. Checking frontmatter (recent files only)..."
ERRORS=0

# ตรวจเฉพาะไฟล์ที่แก้ไขใน commit นี้
if git diff --cached --name-only | grep -q "content/posts/.*/index.md"; then
  for file in $(git diff --cached --name-only | grep "content/posts/.*/index.md"); do
    if [ -f "$file" ]; then
      if ! grep -q "^title:" "$file" 2>/dev/null; then
        echo "❌ Missing title in $file"
        ERRORS=$((ERRORS + 1))
      fi
      
      if ! grep -q "^date:" "$file" 2>/dev/null; then
        echo "❌ Missing date in $file"
        ERRORS=$((ERRORS + 1))
      fi
      
      if ! grep -q "^tags:" "$file" 2>/dev/null; then
        echo "❌ Missing tags in $file"
        ERRORS=$((ERRORS + 1))
      fi
    fi
  done
else
  echo "  (ไม่มีไฟล์บทความที่แก้ไข)"
fi

if [ $ERRORS -gt 0 ]; then
  echo "❌ พบ $ERRORS files ที่มี frontmatter ไม่ครบ"
  exit 1
fi
echo "✅ Frontmatter ครบถ้วน"
echo ""

# 3. Check Chinese/Korean Characters
echo "🔍 3. Checking for Chinese/Korean characters..."
if grep -rE "为什么 | 对照|한국어" content/posts/ --include="*.md" 2>/dev/null; then
  echo "❌ พบภาษาจีน/เกาหลี!"
  echo "   กรุณาลบออกก่อน push"
  exit 1
fi
echo "✅ ไม่พบภาษาจีน/เกาหลี"
echo ""

# 4. Build Test
echo "🔨 4. Building..."
if ! hugo --gc --minify -q 2>/dev/null; then
  echo "❌ Build ล้มเหลว!"
  exit 1
fi
echo "✅ Build ผ่าน"
echo ""

# 5. Check Git Status
echo "📊 5. Checking git status..."
git status --porcelain
echo "✅ Git status OK"
echo ""

echo "✅ All checks passed!"
echo ""
echo "พร้อม push แล้วครับ!"
exit 0
