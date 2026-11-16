---
name: write-article
description: เขียนบทความ Neng Blog v4.0 — หาข้อมูล → เขียน → รีวิว+validate → อนุมัติ → push
args:
  - name: topic
    description: หัวข้อบทความ
    required: true
  - name: slug
    description: ชื่อไฟล์ slug (เช่น ai-agent-part-1)
    required: true
  - name: series
    description: ชื่อซีรีส์ (ถ้ามี)
    required: false
  - name: seriesNumber
    description: ลำดับตอนในซีรีส์ (ถ้ามี)
    required: false
  - name: previous
    description: slug ตอนก่อนหน้า (ถ้ามี)
    required: false
  - name: next
    description: slug ตอนถัดไป (ถ้ามี)
    required: false
---

# Workflow: เขียนบทความ Neng Blog v4.0

> **เวอร์ชัน:** 4.0 — Unified from .thclaws + wiki v3.16
> **Agents:** 3 (researcher → content-writer → reviewer)
> **เวลาโดยประมาณ:** ~30 นาที (ไม่รวมเวลาเหน่งรีวิว)
> **กฎเหล็ก:** 🔴 ห้าม push ก่อนเหน่งอนุมัติ

---

## Step 1: Research (researcher agent)

ค้นหาข้อมูลก่อนเขียน:

```
/agent researcher ค้นหาข้อมูลเกี่ยวกับ {{topic}} อย่างละเอียดสำหรับเขียนบทความ Neng Blog:

1. คำจำกัดความและแนวคิดหลัก
2. ตัวอย่างการใช้งานจริง (โดยเฉพาะบริบทไทย/รัฐบาล/ชุมชน)
3. สถิติหรือข้อมูลล่าสุด (ปี 2026) พร้อมแหล่งอ้างอิง URL
4. เปรียบเทียบ tools/tech ถ้าหัวข้อเกี่ยวกับเทคโนโลยี
5. ข้อดีข้อเสีย ให้สมดุล ไม่เขียนข้างเดียว
6. แหล่งอ้างอิง 5+ แหล่ง พร้อม URL

สรุปเป็น bullet points ภาษาไทย พร้อมอ้างอิงแหล่งที่มา
```

**บันทึกผลลัพธ์** ไว้ใช้ใน Step 2

---

## Step 2: Write (content-writer agent)

เขียนบทความโดยอ้างอิงข้อมูลจาก Step 1:

```
/agent content-writer เขียนบทความ Neng Blog เรื่อง {{topic}}

ข้อมูลจาก researcher:
[วางผลลัพธ์จาก Step 1 ที่นี่]

ข้อกำหนด:
- slug: {{slug}}
- ความยาว: 1,500-3,000 คำ
- ภาษาไทยทั้งหมด ศัพท์เทคนิคเป็นภาษาอังกฤษ
- หลบสำนวน AI ตั้งแต่เขียน (ไม่ใช่...แต่คือ / em dash ทั้งฟิลด์ / bold ทุกข้อ) — มี review อีกทีที่ Step 3 Phase 3
- ใส่ code examples ถ้าเหมาะสม
- Frontmatter ต้องครบ: title, date, lastUpdated, description, keywords, author, image, categories, tags, draft, takeaways
- ถ้าเป็นซีรีส์: เพิ่ม partOfSeries, seriesNumber, previous, next
- บันทึกไฟล์ที่: /workspace/content/posts/{{slug}}/index.md
```

**ตรวจสอบ:**
```bash
# ยืนยันไฟล์ถูกสร้าง
ls -la /workspace/content/posts/{{slug}}/index.md

# ยืนยัน frontmatter
head -30 /workspace/content/posts/{{slug}}/index.md
```

---

## Step 3: Review + Validate (reviewer agent)

รีวิวและแก้ไขบทความ (รวม language, structure, SEO, schema, build):

```
/agent reviewer รีวิว + แก้ไข + validate บทความที่ /workspace/content/posts/{{slug}}/index.md

ทำทุก Phase:
- Phase 1: Language & Brand (ตรวจคำจีน/เกาหลี/เวียดนาม, ตรวจแบรนด์)
- Phase 2: Structure & Frontmatter (YAML, H1, heading hierarchy)
- Phase 3: Content Quality (AI-Detox + Humanizer pass, internal content leak)
  ตรวจ tell ทั้งฉบับแล้วแก้เอง:
  · §1 not-X-but-Y ("ไม่ใช่...แต่คือ", "ไม่ได้...แค่...แต่") — เจอครั้งเดียวก็แก้ ให้ระบุข้อความตรง ๆ แทน
  · §2 closer บรรทัดเดียวที่สรุปซ้ำย่อหน้าก่อนหน้า
  · §3 วลีดูลึก ("หัวใจของทั้งหมด", "คำถามที่แท้จริงคือ")
  · §8 em dash (—) ในเนื้อหา → จุด/จุลภาค/วงเล็บ (ยกเว้น YAML takeaways ห้ามแตะ)
  · §19 bold ตกแต่งทุกข้อในรายการ → เก็บเฉพาะ label ที่ให้ข้อมูลจริง
  · ข้อความ/ประโยคเดียวกันซ้ำสองรอบในบทความเดียว
  ข้อจำกัด: เปลี่ยนเฉพาะสำนวน — ห้ามลบ fact, ตัวเลข, ชื่อ, ลิงก์/URL, YAML front matter
  (ใช้สกิล `humanizer` ถ้ามีใน workspace — ไม่มีก็ทำตามรายการข้างบน)
- Phase 4: SEO & Technical (Schema, Key Takeaways, Breadcrumb, robots.txt)
- Phase 5: Image & Link (cover.jpg, alt text, broken links)
- Phase 6: References (5+ sources)
- Phase 7: Build Test — ⚠️ container ไม่มี hugo (เช็คแล้ว) → ข้าม build ในเครื่อง พึ่ง CI หลัง push (มี Hugo 0.170.0); ให้ตรวจ YAML parse + โครงไฟล์ด้วย head/grep แทน

แก้ไขโดยตรง ไม่ต้องถาม แล้วสรุปรายงาน
```

**ตรวจสอบผลลัพธ์:**
- ต้องได้ Review Report ที่ระบุว่า **✅ ผ่าน** ทุก Phase
- ถ้ามี ⚠️ หรือ ❌ ให้แก้ไขก่อน proceed
- ต้องผ่าน **Humanizer pass (Phase 3)** ครบก่อน proceed

---

## Step 4: 🭐 Neng Review & Approve (STOP)

**🔴 หยุดตรงนี้ — ต้องรอเหน่งอนุมัติก่อน**

แจ้งเหน่ง:

```
📝 บทความพร้อมรีวิวแล้ว:

- หัวข้อ: {{topic}}
- Slug: {{slug}}
- ไฟล์: /workspace/content/posts/{{slug}}/index.md
- ผล Review: [รายงานจาก Step 3]

กรุณาตรวจและอนุมัติครับ 🙏
```

**รอคำสั่งจากเหน่ง:**
- ✅ "อนุมัติ" → proceed Step 5
- ⚠️ "แก้ตรงนั้น" → แก้ไขแล้วส่งรีวิวใหม่
- ❌ "ไม่ผ่าน" → เขียนใหม่

---

## Step 5: Push & Cleanup

> ⚠️ **สภาพแวดล้อมจริง (เช็ค 2026-11-16)**: ใน container มี `git` + `curl` แต่ **ไม่มี `hugo` และไม่มี SSH key** (`/root/.ssh` ไม่มี, remote เป็น `git@github.com`) → **build ให้ CI ทำ** และ **commit/push ต้องรันบน host** (`~/neng-blog`) เท่านั้น

### 5.1 Pre-Push Checklist (รันใน container ได้)

```bash
cd /workspace

# ตรวจภาษาจีน/เกาหลีหลุด
grep -Pn '[\x{4e00}-\x{9fff}]' content/posts/{{slug}}/index.md
grep -Pn '[\x{ac00}-\x{d7af}]' content/posts/{{slug}}/index.md

# ตรวจ internal content หลุด
grep -nE "\*(Reviewer|Writer|Coder).*Complete\*|Status:.*(ตรวจสอบ|เสร็จ|ผ่าน)" content/posts/{{slug}}/index.md

# ตรวจ labels
grep -nE "(คำโปรย|Intro|เฟส [0-9]|สรุปเฟส)" content/posts/{{slug}}/index.md

# ตรวจ Humanizer: em dash ต้องเหลือแค่ใน YAML takeaways
grep -n '—' content/posts/{{slug}}/index.md
```

- [ ] ไม่มีภาษาจีน/เกาหลีหลุด
- [ ] ไม่มี internal content หลุด
- [ ] ไม่มี labels
- [ ] ผ่าน Humanizer pass (Phase 3)
- [ ] เหน่งอนุมัติแล้ว
- [ ] Build → ตรวจใน CI หลัง push (เครื่องนี้ไม่มี hugo)

### 5.2 Commit & Push (ทำบน HOST เท่านั้น)

```bash
# host: ~/neng-blog (มี SSH key GitHub อยู่แล้ว)
cd ~/neng-blog
git add content/posts/{{slug}}/
git commit -m "feat: {{topic}}"
git push origin main
```

ห้ามสั่ง `git push` จากใน container — ไม่มี credential ต้อง fail

### 5.3 Post-Push Check (host)

```bash
cd ~/neng-blog
gh run list --workflow hugo.yml --limit 1                            # ล่าสุดต้อง success
curl -sI https://neng-lab.com/posts/{{slug}}/                        # ต้อง 200
curl -s https://neng-lab.com/posts/{{slug}}/ | grep -o '<title>[^<]*' # ชื่อบทความถูก
git status -sb                                                       # ต้องไม่มี ahead/behind
```

- [ ] CI `success`
- [ ] หน้าเว็บ 200 + `<title>` ถูกต้อง
- [ ] local = remote

### 5.4 Wiki Update

อัพเดทหน้าที่เกี่ยวข้องใน wiki:
- ถ้าเป็นซีรีส์ใหม่ → อัพเดท `/topics` page
- บันทึก log ที่ `wiki/log.md`

---

## Architecture (v4.0)

```
Step 1          Step 2           Step 3              Step 4        Step 5
───────        ───────          ───────             ───────       ───────
Researcher  →  Content-Writer → Reviewer+Validate → Neng Approve → Push
(10 min)       (10 min)         (10 min)            (manual)      (2 min)

3 Agents, 5 Steps, ~32 min (ไม่รวมเวลาเหน่งรีวิว)
```

### Agent Roles

| Agent | หน้าที่ | Tools | Color |
|-------|---------|-------|-------|
| **researcher** | ค้นข้อมูล + cross-reference | WebSearch, WebFetch, Read | 🟢 green |
| **content-writer** | เขียนเนื้อหา + frontmatter + SEO | WebSearch, WebFetch, Read, Write, Edit | 🔵 blue |
| **reviewer** | ตรวจ + แก้ + validate + build test | Read, Edit, Grep, Bash | 🔴 red |

### Quality Gates

| Gate | Agent | ตรวจอะไร |
|------|-------|---------|
| **Language** | reviewer | คำจีน/เกาหลี/เวียดนามหลุด |
| **Brand** | reviewer | Twitter → X |
| **Frontmatter** | reviewer | YAML ครบ, วันที่ถูก |
| **SEO** | reviewer | Keywords, description, Schema |
| **Build** | CI หลัง push | hugo --gc --minify ผ่านบน CI (Hugo 0.170.0) — container ไม่มี hugo |
| **Humanizer** | reviewer | tell ภาษา AI: §1/§2/§3/§8/§19 + ข้อความซ้ำ |
| **Approval** | เหน่ง | เนื้อหา + ดีไซน์ |

---

## Lessons Learned (from v3.16)

| บทเรียน | วิธีป้องกัน |
|---------|-----------|
| Push โดยไม่รออนุมัติ | 🔴 Step 4 บังคับ STOP |
| Labels ในบทความ ("คำโปรย", "เฟส") | Phase 2 grep check |
| Internal status หลุด | Phase 3 grep check |
| ภาษาจีน/เกาหลีหลุด | Phase 1 Unicode range detection |
| Schema ไม่มี | Phase 4 auto-check partials |
| สำนวนมีร่องรอย AI (not-X-but-Y, em dash ทั้งฟิลด์) | Phase 3 Humanizer pass |

---

_Last updated: 2026-11-16 — รวม Humanizer pass เข้า Step 3 (Phase 3) + เพิ่ม Humanizer gate (v4.0)_
