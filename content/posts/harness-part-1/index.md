+++
title = 'Harness Engineering ตอนที่ 1: ทำไม AI ต้องมี Harness?'
date = 2026-04-13T10:00:00+07:00
draft = false
tags = ['harness-engineering', 'ai', 'claude-code', 'engineering', 'beginner-guide']
categories = ['Tutorial', 'AI']
image = 'cover.jpg'
description = 'บทนำสู่ Harness Engineering เรียนรู้ว่าทำไม AI ที่เขียนโค้ดได้ต้องมี Harness ควบคุม และ Harness Engineering ต่างจาก Prompt Engineering อย่างไร'
+++

# Harness Engineering ตอนที่ 1: ทำไม AI ต้องมี Harness?

**คำโปรย:** "Prompt กำหนดวิธีพูด, Harness กำหนดวิธีทำงาน" — เรียนรู้หลักการพื้นฐานของ Harness Engineering จาก Harness Books โดย wquguru

---

## 📚 ส่วนนำ: จาก "โมเดลฉลาด" สู่ "ระบบที่ไว้ใจได้"

这些年，人们喜欢把会写代码的模型叫作智能体。这个词带着明显的乐观色彩...

**คำแปล:** "ทุกวันนี้ คนชอบเรียกโมเดลที่เขียนโค้ดได้ว่า 'Agent' — คำนี้เต็มไปด้วยความ lạc 觀 ราวกับว่าแค่โมเดลอ่าน repository ได้ ใช้ tools ได้ เขียน patch ได้ มันก็ทำงานใน engineering environment ได้โดยอิสระ"

แต่ความจริงคือ...

**Engineering environment มี consequences ที่ชัดเจน:**
- Terminal, Filesystem, Git History ไม่ใช่ abstract space
- 任何改动都会留下痕迹 (ทุกการ改动ทิ้งร่องรอย)
- 目录会变化，进程会中断，配置会损坏 (directory เปลี่ยน, process ขัดข้อง, configuration เสียหาย)

**核心问题:** ไม่ใช่โมเดลฉลาดพอหรือยัง แต่คือ **ระบบมี constraints พอหรือยัง**

---

## 🤖 Harness Engineering คืออะไร?

### คำนิยามจาก Harness Books:

> **Harness Engineering** =一组持续生效的控制结构 (constraint structures ที่ continuous生效)
>
> **用来约束模型在工程环境中的行为边界** (用来ควบคุม behavior boundary ของโมเดลใน engineering environment)

### สรุปง่ายๆ:

| Prompt Engineering | Harness Engineering |
|-------------------|---------------------|
| กำหนดวิธี**พูด** | กำหนดวิธี**ทำ** |
| เน้นผลลัพธ์จากโมเดล | เน้น constraints ของระบบ |
| โมเดลเป็นศูนย์กลาง | ระบบเป็นศูนย์กลาง |
| "ทำให้โมเดลฉลาด" | "ทำให้ระบบไว้ใจได้" |

### **หลักการสำคัญ:**

```
Prompt 决定它怎么说话
Harness 决定它怎么做事
```

**(Prompt กำหนดวิธีพูด, Harness กำหนดวิธีทำงาน)**

---

## ⚠️ ทำไมต้องมี Harness?

### ปัญหาพื้นฐาน: **โมเดลไม่เสถียร**

**从 Harness Books:**

> "一个部件如果本质上不稳定，系统就必须围绕这个事实设计；否则，问题只会在事故复盘里集中出现"
>
> **(ถ้า component ไม่เสถียรโดยธรรมชาติ ระบบต้องออกแบบ围绕ข้อเท็จจริงนี้ ไม่อย่างนั้นปัญหาจะปรากฏใน post-incident review)**

### ตัวอย่างจริง:

| โมเดลทำงานปกติ | โมเดลทำงานผิดปกติ |
|----------------|-----------------|
| ✅ เขียนโค้ดถูกต้อง | ❌ เขียนโค้ดผิด |
| ✅ ใช้ tools ถูกต้อง | ❌ ใช้ tools ผิด (rm -rf, curl malware) |
| ✅ แก้ไฟล์ถูกต้อง | ❌ แก้ไฟล์ผิด (config เสีย, database พัง) |
| ✅ Commit ถูกต้อง | ❌ Commit ผิด (history พัง, branch หาย) |

**สรุป:** ไม่มี Harness = ความสามารถขยาย **accident radius**

---

## 🛡️ Harness มีอะไรบ้าง?

### จาก Harness Books (Claude Code Case Study):

| Harness Component | หน้าที่ | ตัวอย่าง |
|------------------|--------|---------|
| **Prompt Layering** | แบ่งระดับ prompt | System prompt, User prompt, Tool prompt |
| **Permissions** | ควบคุม tool access | อ่านไฟล์ได้, เขียนไฟล์บางที่ได้, รัน command บางอย่างได้ |
| **Query Loop** | จัดการ state ต่อเนื่อง | ไม่ใช่ตอบคำถามแล้วจบ แต่ทำงานต่อเนื่อง |
| **Context Management** | จัดการ memory & context | CLAUDE.md, compact conversation, session memory |
| **Recovery Paths** | ฟื้นฟูจากข้อผิดพลาด | Handle prompt too long, max output tokens, interrupt |
| **Multi-Agent Verification** | ตรวจสอบโดย agent อื่น | Synthesis แยกจาก Verification |

### เปรียบเทียบให้เห็นภาพ:

```
โมเดล = พนักงานใหม่ฉลาดมาก แต่ไม่เสถียร
Harness = ระบบ onboarding, rules, approval workflow, audit trail

ไม่มี Harness = ให้พนักงานใหม่ทำทุกอย่างโดยไม่มี controls
มี Harness = มีระบบตรวจสอบ อนุมัติ และติดตาม
```

---

## 📊 Harness Engineering 10 Principles (สรุปจากบทที่ 9)

1. **错误路径要按主路径设计** — Error paths ต้องออกแบบเหมือน main paths
2. **验证必须进入完成定义** — Verification ต้องเป็นส่วนหนึ่งของ definition of done
3. **权限是系统器官，而不是附属功能** — Permissions เป็น organs ของระบบ ไม่ใช่ add-on
4. **上下文是资源，不是垃圾桶** — Context เป็น resources ไม่ใช่ trash can
5. **多代理要靠角色分离，不靠人海战术** — Multi-agent ใช้ role separation ไม่ใช่ human wave tactics
6. **团队制度比个人技巧重要** — Team practices สำคัญกว่า personal skills
7. **Prompt 决定说话，Harness 决定做事** — Prompt กำหนดวิธีพูด, Harness กำหนดวิธีทำ
8. **โมเดลไม่เสถียรคือข้อเท็จจริง** — Model instability คือ fact ไม่ใช่ bug
9. **约束是前提，不是防御** — Constraints เป็น prerequisite ไม่ใช่ defensive measure
10. **工程克制胜过乐观叙事** — Engineering restraint ชนะ optimistic narrative

---

## 💡 ประสบการณ์เหน่ง: จาก "ใช้ AI" สู่ "สร้าง Harness"

### ช่วงแรก: ใช้ AI โดยไม่มี Harness

```
❌ ปล่อยให้ AI เขียนโค้ดโดยไม่มี checks
❌ ให้ AI access ทุกไฟล์โดยไม่มี permissions
❌ ใช้ AI ตอบคำถามแล้วจบ ไม่มี query loop
❌ ไม่มี recovery paths เมื่อ AI ทำผิด
```

**ผลลัพธ์:**
- โค้ดผิดต้องแก้เองทั้งหมด
- ไฟล์สำคัญเสียหาย
- เสียเวลา debug มากกว่าประหยัด

### ปัจจุบัน: สร้าง Harness

```
✅ ใช้ Qwen (Alibaba) rotate ตามงาน
✅ มี permissions จำกัด access
✅ มี query loop ทำงานต่อเนื่อง
✅ มี recovery paths เมื่อ AI ทำผิด
✅ มี verification โดย agent อื่น

Flow ชัดเจนขึ้น พอใจประมาณ 90%
```

**บทเรียน:** ไม่ต้องไล่ตามโมเดลใหม่ตลอด หาจุดที่เหมาะกับตัวเองแล้วใช้ให้คุ้ม — ดีกว่าเปลี่ยนไปเปลี่ยนมาตลอด

---

## 🎯 สรุปตอนที่ 1

### สิ่งที่ได้เรียนรู้:

✅ **Harness Engineering คืออะไร** — Constraint structures สำหรับ AI ใน engineering environment

✅ **ต่างจาก Prompt Engineering อย่างไร** — Prompt กำหนดวิธีพูด, Harness กำหนดวิธีทำ

✅ **ทำไมต้องมี Harness** — เพราะโมเดลไม่เสถียรโดยธรรมชาติ

✅ **Harness มีอะไรบ้าง** — Prompt layering, permissions, query loop, context management, recovery, verification

✅ **10 Principles ของ Harness Engineering** — หลักการพื้นฐานจาก Harness Books

---

## 📖 ตอนต่อไป: Prompt คือ Control Plane (ไม่ใช่ Input Box)

ตอนนี้เราเข้าใจแล้วว่า Harness Engineering คืออะไร และทำไมต้องมี Harness

**คำถามต่อไป:**
- Prompt คืออะไร? (ไม่ใช่แค่ input box)
- Prompt ทำงานเป็น control plane อย่างไร?
- Prompt layering มีกี่ระดับ?

**Harness Books บทที่ 2** จะตอบคำถามเหล่านี้

ติดตามตอนต่อไปได้เลย 🚀

---

## 📚 อ้างอิง

### แหล่งหลัก:

**Harness Books 2 เล่ม โดย wquguru**
- Book 1: [Claude Code Harness](https://github.com/wquguru/harness-books/blob/main/book1-claude-code/index.md)
- Book 2: [Claude Code vs Codex](https://github.com/wquguru/harness-books/blob/main/book2-comparing/index.md)
- Online Version: [harness-books.agentway.dev](https://harness-books.agentway.dev/book1-claude-code/)

### แหล่งเสริม:

1. IBM - What is AI? https://www.ibm.com/think/topics/artificial-intelligence
2. IBM - Types of AI https://www.ibm.com/think/topics/artificial-intelligence-types
3. Zapier - Human-in-the-loop https://zapier.com/blog/human-in-the-loop/
4. OneTrust - 2025 AI Governance Report https://www.onetrust.com/resources/2025-ai-ready-governance-report/
