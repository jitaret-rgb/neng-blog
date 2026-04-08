# Memory Space - neng-blog

## Project Context
- **ชื่อโปรเจกต์**: neng-blog
- **เทคโนโลยีหลัก**: Hugo (Static Site Generator) + Hugo Theme Stack
- **โฮสติ้ง**: GitHub Pages
- **URL**: https://jitaret-rgb.github.io/neng-blog/

## Key Decisions

| วันที่ | การตัดสินใจ | เหตุผล |
|--------|-------------|--------|
| 2026-04-08 | เปลี่ยน path partials จาก `layouts/partials/` เป็น `layouts/_partials/` | Hugo Stack Theme ใช้ underscore prefix |
| 2026-04-08 | แก้ไขโครงสร้าง config `[params.comments]` | อย่าใส่ใต้ `[cookies]` จะทำให้ Hugo อ่านไม่เจอ |
| 2026-04-08 | ใช้ `services.googleAnalytics.ID` แทน `params.analytics.google.siteID` | Hugo internal template ต้องการแบบนี้ |
| 2026-04-08 | เพิ่ม `giscus.app` เข้า CSP (script-src, frame-src, connect-src) | ไม่งั้น Giscus จะถูกบล็อก |

## Technical Details

### Giscus Comments Setup
- **ไฟล์**: `layouts/_partials/comments/provider/giscus.html`
- **Config** (`hugo.toml`):
  ```toml
  [params.comments]
    enabled = true
    provider = "giscus"
  
  [params.comments.giscus]
    repo = "jitaret-rgb/neng-blog"
    repoID = "R_kgDOR6Wt7Q"
    category = "Announcements"
    categoryID = "DIC_kwDOR6Wt7c4C6TwS"
    mapping = "pathname"
    theme = "preferred_color_scheme"
  ```

### Google Analytics Setup
- **Config** (`hugo.toml`):
  ```toml
  [services]
    [services.googleAnalytics]
      ID = "G-Q59XSCDQZR"
  ```

### CSP (Content Security Policy)
- **ไฟล์**: `layouts/partials/head/security.html`
- ต้องมี:
  - `script-src` → `https://giscus.app`
  - `frame-src` → `https://giscus.app` (สำหรับ iframe)
  - `connect-src` → `https://giscus.app`

## Common Issues & Fixes

1. **Giscus ไม่แสดง**: ตรวจสอบ CSP ว่าอนุญาติ `giscus.app` หรือไม่
2. **Analytics ไม่ทำงาน**: ใช้ `services.googleAnalytics.ID` ไม่ใช่ `params.analytics`
3. **Partials ไม่โหลด**: Theme Stack ใช้ `_partials/` (มี underscore)

## Session History

### 2026-04-08
- แก้ไข Giscus ไม่แสดง (path ผิด + CSP)
- แก้ไข Google Analytics ไม่ทำงาน (config ผิด)
- ทดสอบ build สำเร็จทั้งคู่
