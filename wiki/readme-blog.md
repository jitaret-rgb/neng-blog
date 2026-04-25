# 📝 คู่มือการใช้งานบล็อกของเหน่ง

บล็อกส่วนตัวสร้างด้วย **Hugo** + ธีม **Stack**  
Deploy ด้วย **GitHub Pages**

---

## 🚀 เริ่มต้นใช้งาน

### 1. เปิด Terminal
```bash
cd ~/workspace/neng-blog
```

### 2. สร้างบทความใหม่
```bash
hugo new content posts/ชื่อบทความ.md
```

### 3. แก้ไขบทความ
เปิดไฟล์ที่สร้างใน `content/posts/ชื่อบทความ.md`

### 4. Publish
แก้ `draft = true` → `draft = false`

### 5. Upload
```bash
git add .
git commit -m "Add new post"
git push
```

รอ 2-5 นาที → บทความออนไลน์! 🎉

---

## 📄 โครงสร้างไฟล์

```
neng-blog/
├── content/
│   ├── posts/          ← เขียนบทความที่นี่
│   │   ├── sawasdee.md
│   │   └── บทความใหม่.md
│   └── about.md        ← หน้าเกี่ยวกับ
├── assets/
│   └── images/         ← ฝากรูปปกบทความ
├── .github/
│   └── workflows/      ← GitHub Actions (auto deploy)
├── themes/
│   └── hugo-theme-stack/
├── hugo.toml           ← ตั้งค่าบล็อก
└── README.md           ← คู่มือนี้
```

---

## ✍️ การเขียนบทความ

### โครงสร้าง Front Matter

```toml
+++
title = 'ชื่อบทความ'
date = 2026-04-05T00:00:00+07:00
draft = false
tags = ['tag1', 'tag2']
categories = ['หมวดหมู่']
image = 'images/รูปปก.jpg'  # ← รูปปก (ใส่ assets/images/)
description = 'คำอธิบายสั้นๆ'
+++

## เนื้อหาบทความ

เขียนเนื้อหาที่นี่...
```

### ตัวอย่างบทความ

```toml
+++
title = 'สวัสดีครับ'
date = 2026-04-05T20:00:00+07:00
draft = false
tags = ['introduction', 'personal']
categories = ['ชีวิตประจำวัน']
description = 'บทความต้อนรับสู่บล็อกใหม่'
+++

## 👋 สวัสดีครับ!

นี่คือบล็อกส่วนตัวของผม...

### หัวข้อย่อย

เนื้อหาในหัวข้อ...

- รายการที่ 1
- รายการที่ 2
- รายการที่ 3

![คำอธิบายรูป](images/รูป.jpg)

```

---

## 🖼️ การเพิ่มรูปภาพ

### 1. ฝากรูปใน `assets/images/`

```bash
mkdir -p assets/images
cp /path/to/รูป.jpg assets/images/
```

### 2. เรียกใช้ในบทความ

```markdown
![คำอธิบายรูป](images/รูป.jpg)
```

### 3. ตั้งเป็นรูปปก

```toml
+++
image = 'images/รูป.jpg'
+++
```

---

## 📁 หมวดหมู่และแท็ก

### Categories (หมวดหมู่)
- ใช้แบ่งประเภทใหญ่ ๆ
- ตัวอย่าง: `งาน`, `เทคโนโลยี`, `ชีวิตประจำวัน`

### Tags (แท็ก)
- ใช้ระบุรายละเอียด
- ตัวอย่าง: `python`, `automation`, `tutorial`

### วิธีใช้

```toml
+++
categories = ['เทคโนโลยี']
tags = ['python', 'automation']
+++
```

---

## 🌐 การ Deploy

### Push ขึ้น GitHub
```bash
git add .
git commit -m "อัพเดทบทความ"
git push
```

### GitHub Actions จะ:
1. Build เว็บอัตโนมัติ
2. Deploy ขึ้น GitHub Pages
3. เสร็จภายใน 2-5 นาที

### เช็คสถานะ
เปิด: https://github.com/jitaret-rgb/neng-blog/actions

---

## ⚙️ การตั้งค่า

### แก้ไข `hugo.toml`

```toml
baseURL = 'https://jitaret-rgb.github.io/neng-blog/'
title = 'บล็อกของเหน่ง'

[params]
  subtitle = "แชร์เรื่องราวเกี่ยวกับงาน เทคโนโลยี และชีวิตประจำวัน"
  defaultTheme = "auto"  # auto/dark/light

[params.author]
  name = "เหน่ง"
  email = "jitaret@gmail.com"
```

### เมนูหลัก

```toml
[[menu.main]]
  name = "Home"
  url = "/"
  weight = 1

[[menu.main]]
  name = "Posts"
  url = "/posts/"
  weight = 2

[[menu.main]]
  name = "Categories"
  url = "/categories/"
  weight = 3

[[menu.main]]
  name = "About"
  url = "/about/"
  weight = 4
```

---

## 🎨 ธีม Stack Features

| ฟีเจอร์ | คำอธิบาย |
|--------|---------|
| 🌙 Dark Mode | เปลี่ยนอัตโนมัติตามระบบ |
| 📱 Responsive | รองรับมือถือ/แท็บเล็ต/คอมพิวเตอร์ |
| 🔍 Search | ค้นหาบทความ |
| 📊 Sidebar | เมนูด้านข้าง |
| 🏷️ Tags | จัดกลุ่มด้วยแท็ก |
| 📁 Categories | จัดหมวดหมู่ |
| ⏱️ Reading Time | แสดงเวลาอ่าน |
| 🔗 Share | แชร์บทความ |

---

## 🛠️ คำสั่งที่ใช้บ่อย

| คำสั่ง | คำอธิบาย |
|--------|---------|
| `hugo new content posts/ชื่อ.md` | สร้างบทความใหม่ |
| `hugo server --buildDrafts` | ดูตัวอย่าง (localhost:1313) |
| `hugo --minify` | Build สำหรับ deploy |
| `git add .` | เพิ่มไฟล์ทั้งหมด |
| `git commit -m "msg"` | บันทึกการแก้ไข |
| `git push` | อัพโหลดขึ้น GitHub |

---

## 💡 เคล็ดลับ

### 1. ดูตัวอย่างก่อน Publish
```bash
hugo server --buildDrafts
```
เปิด http://localhost:1313/

### 2. เขียนด้วย Markdown
- `# Heading 1`
- `## Heading 2`
- `**bold**` → **bold**
- `*italic*` → *italic*
- `[link](url)` → [link](url)
- `![alt](image.jpg)` → รูปภาพ

### 3. จัดการ Draft
- `draft = true` → บทความส่วนตัว (ไม่แสดง)
- `draft = false` → Publish (แสดงออนไลน์)

### 4. Backup
```bash
git status          # เช็คการเปลี่ยนแปลง
git log             # ดูประวัติ
git pull            # ดึงข้อมูลล่าสุด
```

---

## 🔗 ลิงก์ที่เป็นประโยชน์

| หัวข้อ | ลิงก์ |
|--------|-------|
| Hugo Documentation | https://gohugo.io/documentation/ |
| Stack Theme | https://github.com/CaiJimmy/hugo-theme-stack |
| Stack Demo | https://demo.stack.jimmycai.com/ |
| Markdown Guide | https://www.markdownguide.org/ |
| GitHub Pages | https://pages.github.com/ |

---

## ❓ แก้ปัญหา

### บทความไม่แสดงออนไลน์
1. เช็ค `draft = false` หรือยัง
2. รอ GitHub Actions เสร็จ (2-5 นาที)
3. Hard refresh (Ctrl+Shift+R)

### รูปไม่ขึ้น
1. เช็ค path ถูกต้องไหม (`images/รูป.jpg`)
2. รูปอยู่ใน `assets/images/` หรือยัง
3. ชื่อไฟล์ตรงกันไหม (case-sensitive)

### GitHub Actions Failed
1. เปิด: https://github.com/jitaret-rgb/neng-blog/actions
2. ดู log ว่า error ตรงไหน
3. แก้ไขแล้ว push ใหม่

---

## 📞 ติดต่อ

- **GitHub:** https://github.com/jitaret-rgb
- **Telegram:** @Jitaret
- **Email:** jitaret@gmail.com

---

**สร้างโดย Mick** 🤖  
_อัพเดทล่าสุด: 2026-04-05_

---

## 🎯 Quick Start (สำหรับคนขี้เกียจอ่าน)

```bash
# 1. สร้างบทความ
cd ~/workspace/neng-blog
hugo new content posts/บทความใหม่.md

# 2. แก้ไข
code content/posts/บทความใหม่.md
# แก้ draft = false แล้ว save

# 3. Publish
git add .
git commit -m "Add new post"
git push

# 4. รอ 2-5 นาที → เสร็จ!
```

🎉
