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
| 2026-04-08 | เปลี่ยน Giscus theme เป็น `noborder_dark` | ต้องการให้สีเข้ากับ blog โดยไม่มีขอบ |
| 2026-04-08 | Giscus สลับ theme ตาม Stack Theme | light → noborder_light, dark → noborder_dark |
| 2026-04-08 | ลบ Custom Homepage (กลับไปแสดง list บทความ) | ลบ `content/_index.md` เพื่อแสดง list posts ตาม default |
| 2026-04-08 | ตั้งค่า default theme เป็น "dark" + เพิ่ม `[params.colorScheme]` | เปลี่ยนจาก "auto" → บังคับ dark mode แต่ยังสลับได้ |
| 2026-04-08 | ปรับสี Stack Theme ให้เข้ากับ Giscus ทั้ง 2 โหมด | `custom.scss` - light/dark mode ใช้สีเดียวกับ `noborder_light`/`noborder_dark` |
| 2026-04-08 | ป้องกัน `.kimi/` ไม่ให้ขึ้น GitHub/GitHub Pages | เพิ่ม `.gitignore` + `ignoreFiles` ใน hugo.toml |

## Technical Details

### Giscus Comments Setup
- **ไฟล์**: `layouts/_partials/comments/provider/giscus.html`
- **Theme**: `noborder_dark` (dark theme ไม่มีขอบ)
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
    lightTheme = "noborder_light"
    darkTheme = "noborder_dark"
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

### 2026-04-08 (ช่วงเช้า)
- แก้ไข Giscus ไม่แสดง (path ผิด + CSP)
- แก้ไข Google Analytics ไม่ทำงาน (config ผิด)
- ทดสอบ build สำเร็จทั้งคู่

### 2026-04-08 (ช่วงบ่าย)
- เปลี่ยน Giscus theme เป็น `noborder_dark` ทั้ง light และ dark mode
- อัปเดต template `giscus.html` ให้ใช้ built-in theme แทน custom CSS
- ปรับ Giscus ให้สลับ theme ตาม Stack Theme: light → noborder_light, dark → noborder_dark
- เพิ่ม MutationObserver แก้ bug Giscus กลับเป็น light หลังกด Refresh
- ป้องกัน `.kimi/memory.md` ไม่ให้ขึ้น GitHub (`.gitignore`) และ GitHub Pages (`ignoreFiles`)
- ทดลองสร้าง/ลบ Custom Homepage (`content/_index.md`) → กลับไปใช้ list posts ตาม default
