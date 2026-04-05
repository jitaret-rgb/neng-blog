# 📝 บล็อกของเหน่ง

เว็บบล็อกส่วนตัวสร้างด้วย Hugo + Theme PaperMod

---

## 🚀 คำสั่งที่ใช้บ่อย

### ดูตัวอย่างเว็บ (Development Mode)
```bash
cd ~/workspace/neng-blog
hugo server --buildDrafts
```
แล้วเปิด http://localhost:1313/

### สร้างบทความใหม่
```bash
hugo new content posts/ชื่อบทความ.md
```

### แก้ไขบทความ
เปิดไฟล์ใน `content/posts/ชื่อบทความ.md` แล้วแก้ไข

### เผยแพร่บทความ (ลบ draft: true ออก)
```toml
+++
title = 'ชื่อบทความ'
date = 2026-04-05T00:00:00+07:00
draft = false  # ← เปลี่ยนเป็น false
tags = ['tag1', 'tag2']
+++
```

### สร้างเว็บสำหรับ Deploy (Production)
```bash
hugo --minify
```
ไฟล์จะอยู่ในโฟลเดอร์ `public/`

---

## 📁 โครงสร้างโฟลเดอร์

```
neng-blog/
├── content/           # บทความทั้งหมด
│   ├── posts/         # บทความบล็อก
│   └── about.md       # หน้าเกี่ยวกับ
├── themes/            # ธีม (PaperMod)
├── static/            # ไฟล์ static (รูปภาพ, CSS เพิ่ม)
├── public/            # เว็บที่สร้างแล้ว (สำหรับ deploy)
└── hugo.toml          # การตั้งค่าเว็บ
```

---

## 🎨 การตั้งค่า

แก้ไข `hugo.toml` เพื่อเปลี่ยน:
- ชื่อเว็บ
- URL
- เมนู
- การตั้งค่าธีม

---

## 🌐 Deploy

### GitHub Pages (แนะนำ)
1. สร้าง repository ใหม่บน GitHub
2. Push โฟลเดอร์ `neng-blog` ขึ้นไป
3. เปิด GitHub Pages ใน Settings
4. ตั้งค่า GitHub Actions สำหรับ Hugo

### หรือ Deploy เอง
คัดลอกเนื้อหาใน `public/` ไปไว้ที่ web server

---

## 📚 เอกสารเพิ่มเติม

- [Hugo Documentation](https://gohugo.io/documentation/)
- [PaperMod Theme](https://github.com/adityatelange/hugo-PaperMod)
- [PaperMod Demo](https://adityatelange.github.io/hugo-PaperMod/)

---

**สร้างโดย Mick** 🤖  
_2026-04-05_
