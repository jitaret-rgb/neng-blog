# 🖼️ Image Checklist — ตรวจสอบรูปก่อน Publish

> **สร้าง:** 2026-04-10  
> **วัตถุประสงค์:** ป้องกันรูปซ้ำ/รูปหาย/รูปไม่แสดงในบล็อก

---

## ✅ **ขั้นตอนตรวจสอบรูป (ก่อน Commit)**

### **ขั้นตอนที่ 1: วางรูปในโฟลเดอร์**

```bash
content/posts/[article-slug]/
├── index.md          # บทความ
├── cover.jpg         # รูปปก (1200x630 px)
├── image1.jpg        # รูปประกอบ 1 (800x600 px)
└── image2.jpg        # รูปประกอบ 2 (800x600 px)
```

**กฎ:**
- ✅ ใช้ชื่อรูปที่ชัดเจน (ไม่ใช้ `image.jpg` ซ้ำๆ)
- ✅ วางรูปในโฟลเดอร์เดียวกับ `index.md` (Page Bundle)
- ✅ ใช้ relative path ในบทความ

---

### **ขั้นตอนที่ 2: ตรวจสอบรูปซ้ำ (MD5 Hash)**

```bash
# เข้าโฟลเดอร์บทความ
cd content/posts/[article-slug]/

# เช็ค MD5 hash ของรูปทั้งหมด
md5sum *.jpg

# หรือใช้คำสั่งนี้เพื่อหารูปซ้ำทันที
md5sum *.jpg | sort | uniq -d -w32
```

**ผลลัพธ์:**
- ✅ **ไม่มี output** = ไม่มีรูปซ้ำ (ผ่าน)
- ❌ **มี hash ที่ซ้ำกัน** = มีรูปซ้ำ (ต้องแก้)

**ตัวอย่าง:**
```bash
# ❌ มีรูปซ้ำ
a13b26beb7588bf827635e7476cad402  image1.jpg
a13b26beb7588bf827635e7476cad402  image2.jpg  ← ซ้ำ!

# ✅ ไม่มีรูปซ้ำ
a13b26beb7588bf827635e7476cad402  image1.jpg
b24c37fc86992c8387646f858921de51  image2.jpg
```

---

### **ขั้นตอนที่ 3: ตรวจสอบใน index.md**

```bash
# เช็คการใช้รูปในบทความ
grep -E "!\[.*\]\(.*\.(jpg|png|webp)\)" index.md
```

**ตรวจสอบ:**
- ✅ รูปทุก hình được sử dụng trong bài
- ✅ Không có hình nào được dùng 2 lần (trừ khi cố ý)
- ✅ Tên hình khớp với file thực tế

**Ví dụ:**
```markdown
✅ Đúng:
![Cover](cover.jpg)
![Concept](image1.jpg)
![Example](image2.jpg)

❌ Sai:
![Cover](cover.jpg)
![Concept](cover.jpg)  ← Lặp!
```

---

### **ขั้นตอนที่ 4: Xóa Cache (nếu cần)**

```bash
# Xóa generated images cũ
rm -rf resources/_gen/images/posts/[article-slug]/

# Build lại Hugo
hugo --gc --minify
```

---

### **ขั้นตอน 5: Kiểm tra Build**

```bash
# Build và kiểm tra log
hugo --gc --minify 2>&1 | grep -i "error\|warn"

# Kiểm tra số lượng images được xử lý
hugo --gc --minify 2>&1 | grep "Processed images"
```

**Kết quả mong đợi:**
```
✅ Processed images: [số hợp lý]
✅ Không có lỗi
```

---

## 🔍 **Dấu hiệu Hình Lặp**

### **1. File Size Giống Nhau 100%**

```bash
ls -la *.jpg
```

**Ví dụ:**
```bash
# ❌ Nghi ngờ (cùng kích thước)
-rw-r--r-- 1 user user 102355 image1.jpg
-rw-r--r-- 1 user user 102355 image2.jpg  ← Giống hệt!

# ✅ Bình thường (khác kích thước)
-rw-r--r-- 1 user user 102355 image1.jpg
-rw-r--r-- 1 user user  85432 image2.jpg
```

**Lưu ý:** File size giống nhau **chưa chắc** đã lặp, nhưng là dấu hiệu để kiểm tra MD5.

---

### **2. MD5 Hash Giống Nhau**

```bash
md5sum *.jpg | awk '{print $1}' | sort | uniq -d
```

**Kết quả:**
- ✅ **Không có output** = Không lặp
- ❌ **Có hash** = Có hình lặp

---

### **3. Trong Bài Viết Dùng Cùng 1 Hình 2 Lần**

```bash
grep -o 'image1.jpg' index.md | wc -l
```

**Kết quả:**
- ✅ **= 1** = Dùng 1 lần (đúng)
- ❌ **> 1** = Dùng lặp (cần xem lại)

---

## 🛠️ **Công Cụ Kiểm Tra Nhanh**

### **Script: check-images.sh**

```bash
#!/bin/bash
# check-images.sh — Kiểm tra hình lặp trong bài viết

FOLDER=$1

if [ -z "$FOLDER" ]; then
    echo "Usage: ./check-images.sh <article-folder>"
    exit 1
fi

cd "content/posts/$FOLDER" || exit 1

echo "🔍 Kiểm tra hình trong: $FOLDER"
echo "─────────────────────────────"

# 1. Kiểm tra file tồn tại
echo "📁 Files:"
ls -la *.jpg *.png *.webp 2>/dev/null || echo "Không tìm thấy hình"

# 2. Kiểm tra MD5 trùng
echo ""
echo "🔐 Kiểm tra MD5 trùng:"
DUPLICATES=$(md5sum *.jpg 2>/dev/null | sort | uniq -d -w32)
if [ -z "$DUPLICATES" ]; then
    echo "✅ Không có hình trùng"
else
    echo "❌ Phát hiện hình trùng:"
    echo "$DUPLICATES"
fi

# 3. Kiểm tra sử dụng trong index.md
echo ""
echo "📝 Sử dụng trong index.md:"
if [ -f "index.md" ]; then
    grep -oE '!\[.*\]\(.*\.(jpg|png|webp)\)' index.md || echo "Không tìm thấy hình trong bài"
else
    echo "Không có file index.md"
fi
```

**Cách dùng:**
```bash
# Làm cho script có thể chạy
chmod +x check-images.sh

# Kiểm tra bài viết
./check-images.sh ai-engineering-part-6
```

---

## 📊 **Khoảng Cách An Toàn Giữa Các Hình**

### **Quy tắc:**

```
✅ Hình khác nhau → MD5 khác nhau → File size có thể khác
❌ Hình giống nhau → MD5 giống nhau → File size giống nhau
```

### **Khi nào hình có thể giống nhau?**

| Trường hợp | Có thể giống nhau? | Ghi chú |
|------------|-------------------|---------|
| Cùng 1 hình dùng 2 lần | ✅ Có (cố ý) | Cần xem lại có cần thiết không |
| Writer Agent tạo hình | ❌ Không | Mỗi hình phải khác nhau |
| Copy-paste từ nguồn | ⚠️ Cẩn thận | Kiểm tra MD5 trước khi dùng |

---

## ✅ **Checklist Trước Khi Commit**

```
□ Bước 1: Đặt tên hình rõ ràng (cover.jpg, image1.jpg, image2.jpg)
□ Bước 2: Kiểm tra MD5 không trùng (md5sum *.jpg)
□ Bước 3: Kiểm tra index.md dùng đúng tên hình
□ Bước 4: Xóa cache cũ (rm -rf resources/_gen/images/...)
□ Bước 5: Build Hugo thành công (hugo --gc --minify)
□ Bước 6: Kiểm tra log không có lỗi
```

---

## 🚨 **Xử Lý Khi Phát Hiện Hình Lặp**

### **Tình huống 1: Writer Agent tạo hình lặp**

```bash
# 1. Xóa hình lặp
rm image2.jpg

# 2. Sửa index.md
# Tìm và thay thế image2.jpg bằng image1.jpg (nếu cần)
# Hoặc xóa dòng dùng hình lặp

# 3. Build lại
hugo --gc --minify
```

### **Tình huống 2: Cần 2 hình khác nhau**

```bash
# 1. Tìm hình thay thế (Unsplash, Tabler, v.v.)
# 2. Tải hình mới với tên khác
wget [URL] -O image2_new.jpg

# 3. Sửa index.md dùng hình mới
# 4. Build lại
```

---

## 📝 **Best Practices**

### **1. Đặt Tên Hình Có Ý Nghĩa**

```bash
# ✅ Tốt
cover.jpg
fine-tuning-concept.jpg
comparison-chart.jpg

# ❌ Tránh
image.jpg
image1.jpg
img_001.jpg
```

### **2. Dùng Hình Từ Nguồn Đáng Tin Cậy**

| Nguồn | License | Ghi chú |
|-------|---------|---------|
| Unsplash | Miễn phí 100% | ✅ Khuyến khích |
| Pexels | Miễn phí 100% | ✅ Khuyến khích |
| Tabler Illustrations | Mua ($29) | ✅ Đã mua |
| Tự chụp/chụp màn hình | Của bạn | ✅ Tốt nhất |

### **3. Giữ Kích Thước Hợp Lý**

| Loại | Kích thước khuyến nghị | File size tối đa |
|------|----------------------|-----------------|
| Cover | 1200x630 px | 200 KB |
| Article image | 800x600 px | 150 KB |
| Thumbnail | 400x300 px | 50 KB |

---

## 🔗 **Tài Liệu Liên Quan**

- [Hugo Image Processing](https://gohugo.io/content-management/image-processing/)
- [Hugo Stack Theme Images](https://stack.cai.im/docs/image-processing/)
- [Unsplash](https://unsplash.com/)
- [Pexels](https://www.pexels.com/)

---

_Cập nhật: 2026-04-10_  
_Tạo bởi: Mick (theo yêu cầu của Neng)_
