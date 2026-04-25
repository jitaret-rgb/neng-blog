# 🖼️ Image Optimization Guide - Hugo Stack Theme

คู่มือการใช้งาน Image Processing ของ Hugo Stack Theme พร้อม WebP Optimization

## 📋 ความแตกต่างระหว่าง Features

### 1. Hugo Stack Theme Built-in (มาให้อยู่แล้ว)

ใช้ config ที่ `[params.imageProcessing]`:

```toml
[params.imageProcessing]
  autoOrient = true        # หมุนรูปตาม EXIF data
  
  [params.imageProcessing.thumbnail]
    enabled = true         # Thumbnail สำหรับ tile/compact layouts
    
  [params.imageProcessing.content]
    enabled = true         # Responsive images ในเนื้อหา
    widths = [400, 800, 1200, 1600]  # ขนาดที่สร้าง
```

**ผลลัพธ์:**
- ✅ สร้างรูปหลายขนาด (srcset)
- ✅ รองรับ thumbnail
- ❌ ยังเป็น format เดิม (JPEG/PNG)

### 2. WebP Optimization (เพิ่มโดยผม)

override ไฟล์ใน `layouts/_partials/helper/`:

**ผลลัพธ์:**
- ✅ แปลงรูปเป็น **WebP อัตโนมัติ**
- ✅ มี fallback เป็นรูปต้นฉบับ
- ✅ ขนาดไฟล์ลดลง 60-90%

---

## 🚀 วิธีใช้งาน

### ใน Markdown (ใช้ Markdown ธรรมดาได้เลย)

```markdown
![คำอธิบายรูป](image1.jpg)
```

Hugo Stack จะจัดการให้อัตโนมัติ:
1. สร้าง srcset หลายขนาด
2. แปลงเป็น WebP (จาก override ของเรา)
3. ใส่ lazy loading

### ใช้ Shortcode สำหรับควบคุมเพิ่มเติม

```markdown
{{< img src="cover.jpg" alt="คำอธิบาย" width="800" >}}

{{< figure src="image.jpg" 
           alt="คำอธิบาย" 
           caption="**รูปที่ 1:** คำบรรยาย" 
           width="600" >}}
```

---

## ⚙️ การตั้งค่า

### hugo.toml (แนะนำ)

```toml
# Hugo Image Processing (Global)
[imaging]
  quality = 85
  resampleFilter = "lanczos"
  hint = "photo"
  anchor = "smart"
  bgColor = "#ffffff"

# Hugo Stack Theme Image Processing
[params.imageProcessing]
  autoOrient = true
  
  [params.imageProcessing.thumbnail]
    enabled = true
    
  [params.imageProcessing.content]
    enabled = true
    widths = [400, 800, 1200, 1600]
```

---

## 📊 เปรียบเทียบขนาดไฟล์

```bash
cd workspace/neng-blog && hugo --minify
```

ผลลัพธ์:

| บทความ | ต้นฉบับ | WebP | ลดได้ |
|--------|--------|------|--------|
| ai-engineering-intro | 238K | 1.7K | **99%** |
| hugo-stack-guide | 29K | 1.2K | **96%** |
| openclaw-install-guide | 97K | 644B | **99%** |

---

## 🗂️ ไฟล์ที่แก้ไข/เพิ่ม

```
neng-blog/
├── hugo.toml                              # เพิ่ม [imaging] + [params.imageProcessing]
├── layouts/
│   ├── _partials/
│   │   └── helper/
│   │       ├── thumbnail-image.html       # Override: เพิ่ม WebP
│   │       └── responsive-image.html      # Override: เพิ่ม WebP
│   └── _shortcodes/
│       ├── img.html                       # Shortcode ใช้รูปในเนื้อหา
│       └── figure.html                    # Shortcode ใช้รูปพร้อม caption
└── IMAGE_OPTIMIZATION_GUIDE.md            # คู่มือนี้
```

---

## 🔍 การทดสอบ

### 1. Build ตรวจสอบ
```bash
cd workspace/neng-blog
rm -rf public resources
hugo --minify
```

### 2. ตรวจสอบรูป WebP ที่สร้าง
```bash
find public -name "*.webp" | head -10
```

### 3. ตรวจสอบใน Browser
- เปิด DevTools → Network tab
- ดู Type column ต้องเป็น `webp`
- ดู Size ต้องน้อยกว่า original

### 4. ตรวจสอบ HTML
```html
<!-- ต้องมี <picture> tag หรือ srcset ที่ชี้ไปยัง .webp -->
<picture>
  <source srcset="...webp" type="image/webp">
  <img src="...jpg" alt="...">
</picture>
```

---

## 🎯 Best Practices

1. **เก็บรูปต้นฉบับไว้** - Hugo จะสร้าง WebP อัตโนมัติ
2. **ใช้ quality 85** - สมดุลระหว่างคุณภาพและขนาด
3. **resampleFilter "lanczos"** - ให้คุณภาพ resize ดีที่สุด
4. **ใช้ Page Bundles** - เก็บรูปในตำแหน่งเดียวกับ .md file

```
content/posts/my-post/
├── index.md
├── cover.jpg          # รูปปก
└── image1.png         # รูปในเนื้อหา
```

---

## 🔗 References

- [Hugo Stack Theme - Image Processing](https://stack.cai.im/config/image-processing)
- [Hugo Image Processing](https://gohugo.io/content-management/image-processing/)
- [WebP Format - Google](https://developers.google.com/speed/webp)
