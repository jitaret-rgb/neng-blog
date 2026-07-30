---
name: write-article
description: เขียนบทความ Neng Blog ครบทุกขั้นตอน (หาข้อมูล → เขียน → รูป → รีวิว → build test)
args:
  - name: topic
    description: หัวข้อบทความ
    required: true
  - name: series
    description: ชื่อซีรีส์ (ถ้ามี)
    required: false
  - name: slug
    description: ชื่อไฟล์ slug (เช่น ai-agent-part-1)
    required: true
---

# Workflow: เขียนบทความ Neng Blog

## ขั้นตอนที่ 1: หาข้อมูล (researcher)

รัน researcher agent เพื่อหาข้อมูลก่อนเขียน:

```
/agent researcher ค้นหาข้อมูลเกี่ยวกับ {{topic}} อย่างละเอียดสำหรับเขียนบทความ:
1. คำจำกัดความและแนวคิดหลัก
2. ตัวอย่างการใช้งานจริง (โดยเฉพาะบริบทไทย/รัฐบาล/ชุมชน)
3. สถิติหรือข้อมูลล่าสุด (ปี 2026) พร้อมแหล่งอ้างอิง
4. เปรียบเทียบ tools/tech ถ้าหัวข้อเกี่ยวกับเทคโนโลยี
5. ข้อดีข้อเสีย ให้สมดุล

สรุปเป็น bullet points ภาษาไทย พร้อมอ้างอิงแหล่งที่มา
```

**บันทึกผลลัพธ์** ไว้ใช้ในขั้นตอนถัดไป

## ขั้นตอนที่ 2: เขียนบทความ (content-writer)

รัน content-writer agent โดยส่งข้อมูลจาก step 1:

```
/agent content-writer เขียนบทความ Neng Blog เรื่อง {{topic}}

ข้อมูลจาก researcher:
[วางผลลัพธ์จาก step 1 ที่นี่]

ข้อกำหนด:
- slug: {{slug}}
- series: {{series}} (ถ้ามี)
- ความยาว: 1,500-3,000 คำ
- ภาษาไทยทั้งหมด
- ใส่ code examples ถ้าเหมาะสม
- frontmatter ต้องมี: title, date, description, image, categories, tags, takeaways
- บันทึกไฟล์ที่: /neng-blog/content/posts/{{slug}}/index.md
```

## ขั้นตอนที่ 3: จัดการรูปภาพ

ตรวจสอบและเตรียมรูปภาพ:

1. **Cover image** — ต้องมี `cover.jpg` ที่ `/neng-blog/content/posts/{{slug}}/cover.jpg`
2. **รูปประกอบ** — ถ้ามีรูปในบทความ ต้องอยู่ที่ `/neng-blog/content/posts/{{slug}}/`
3. **Alt text** — ทุกรูปต้องมี alt text ภาษาไทย
4. **Relative path** — ใช้ `![alt](filename.jpg)` ไม่ใช่ absolute path

```bash
# ตรวจสอบว่ามี cover.jpg
ls -la /neng-blog/content/posts/{{slug}}/cover.jpg

# ตรวจสอบ alt text ใน markdown
grep -n '!\[' /neng-blog/content/posts/{{slug}}/index.md
```

**ถ้าไม่มี cover.jpg** — แจ้งให้ผู้ใช้เพิ่มเอง หรือใช้ WebSearch หา royalty-free image

## ขั้นตอนที่ 4: รีวิว + แก้ไข (reviewer)

รัน reviewer agent:

```
/agent reviewer รีวิวและแก้ไขบทความที่ /neng-blog/content/posts/{{slug}}/index.md

ตรวจสอบ:
1. ภาษาไทย 100% (ไม่มีคำจีน/เวียดนามหลุด)
2. ชื่อแบรนด์ถูกต้อง (Twitter → X)
3. H1 แค่ 1 ต่อบทความ
4. Frontmatter ครบ: title, date, description, image, categories, tags, takeaways
5. image: cover.jpg อยู่ใน frontmatter
6. takeaways มี 3-5 ข้อ
7. ทุกรูปมี alt text
8. Internal links ทำงาน
9. Code blocks ภาษาถูกต้อง

แก้ไขโดยตรง ไม่ต้องถาม แล้วสรุปรายงาน
```

## ขั้นตอนที่ 5: Build Test

ทดสอบ build ก่อน push:

```bash
cd /neng-blog
hugo --gc --minify 2>&1
```

**ตรวจสอบ:**
- ✅ ไม่มี console errors
- ✅ ไม่มี warning เกี่ยวกับ frontmatter
- ✅ Build สำเร็จ (exit code 0)

**ถ้า build ไม่ผ่าน** — แก้ไขปัญหาที่พบ แล้ว build ใหม่

## ผลลัพธ์

เมื่อ workflow เสร็จ ระบบจะ:
1. ✅ ข้อมูลวิจัยพร้อมใช้
2. ✅ บทความบันทึกที่ `/neng-blog/content/posts/{{slug}}/index.md`
3. ✅ Cover image พร้อม
4. ✅ ปัญหาต่างๆ แก้ไขแล้ว
5. ✅ Hugo build ผ่าน

## ขั้นตอนถัดไป (Manual)

```bash
# คุณ approve แล้ว push
cd /neng-blog
git add .
git commit -m "feat: {{topic}}"
git push origin main
```
