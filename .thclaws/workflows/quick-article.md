---
name: quick-article
description: เขียนบทความเร็ว — หาข้อมูล + เขียน + รีวิว + build test
args:
  - name: topic
    description: หัวข้อบทความ
    required: true
  - name: slug
    description: ชื่อไฟล์ slug
    required: true
  - name: series
    description: ชื่อซีรีส์ (ถ้ามี)
    required: false
---

# Quick Article Workflow

ขั้นตอนย่อจาก write-article — เหมาะกับบทความสั้น ไม่ซีรีส์

## Step 1: Research

```
/agent researcher หาข้อมูล {{topic}} — คำจำกัดความ, ตัวอย่างจริง, สถิติล่าสุด, แหล่งอ้างอิง ภาษาไทย
```

## Step 2: Write

```
/agent content-writer เขียนบทความเรื่อง {{topic}} slug={{series}}/{{slug}}
ข้อมูลจาก researcher: [ผลลัพธ์ step 1]
บันทึกที่ /neng-blog/content/posts/{{slug}}/index.md
```

## Step 3: Review & Fix

```
/agent reviewer รีวิว + แก้ไข /neng-blog/content/posts/{{slug}}/index.md
- ภาษา, แบรนด์, โครงสร้าง, SEO, frontmatter, takeaways
```

## Step 4: Build Test

```bash
cd /neng-blog && hugo --gc --minify 2>&1
```

- ✅ ไม่มี errors
- ✅ Build สำเร็จ

## Step 5: Done

```bash
git add . && git commit -m "feat: {{topic}}" && git push origin main
```
