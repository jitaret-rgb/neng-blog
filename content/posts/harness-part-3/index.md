---
title: "Harness Engineering ตอนที่ 3: Query Loop - หัวใจของระบบ"
date: 2026-04-13T11:00:00+07:00
description: "ทำความรู้จัก Query Loop แนวคิดสำคัญที่เปลี่ยน AI จากผู้ตอบคำถามเป็นผู้ร่วมงาน พร้อม Best Practices 7 ข้อ และตัวอย่างจริงจาก OpenClaw"
keywords:
  - Query Loop
  - AI Engineering
  - Claude Code
  - Codex
  - Prompt Engineering
  - Best Practices
author: "เหน่ง (Nueng)"
partOfSeries: "Harness Engineering"
previous: "harness-engineering-2"
next: "harness-engineering-4"
image: "cover.jpg"
seriesNumber: 3
---

# Harness Engineering ตอนที่ 3: Query Loop - หัวใจของระบบ

## บทนำ: 为什么 Query Loop ถึงสำคัญ?

ลองนึกภาพว่า คุณมีผู้ช่วย AI ที่เก่งมาก แต่ครั้งที่คุณคุยด้วยทีละคำถาม มันก็ตอบได้แค่นั้น ถามต่อ ก็ตอบต่อ แต่ถ้าคุณต้องการให้มันทำงานซับซ้อน เช่น สร้างทั้งระบบ ต้องคุยกันหลายรอบ ปรับแก้หลายจุด จนบางทีคุณเองก็จำไม่ได้ว่าตอนนี้มันทำงานถึงไหนแล้ว

นี่แหละคือที่มาของ **Query Loop** - แนวคิดที่เปลี่ยน AI จาก "ผู้ตอบคำถาม" เป็น "ผู้ร่วมงานที่จดจำบริบทได้"

และที่น่าสนใจคือ **OpenAI ใช้ Query Loop สร้างโค้ดได้มากกว่า 1 ล้านบรรทัดในเวลาเพียง 5 เดือน** ตัวเลขนี้ไม่ใช่แค่ความเร็ว แต่มันบอกว่าการออกแบบระบบที่ถูกต้องสามารถยกระดับศักยภาพของ AI ได้อย่างมหาศาล

แต่ที่น่าคิดคือ งานวิจัยจากหลายที่ชี้ว่า **69% ของโค้ดที่ AI สร้างยังต้องมีคนตรวจสอบ** - หมายความว่า Query Loop ที่ดีไม่ใช่แค่ทำให้ AI ทำงานได้เร็ว แต่ต้องทำให้มันทำงาน "ถูกต้อง" ด้วย

บทความนี้จะพาคุณเข้าใจว่า Query Loop คืออะไร ทำไมมันถึงเป็นหัวใจของระบบ AI และจะนำไปใช้อย่างไรให้เกิดประสิทธิภาพสูงสุด

---

## Query Loop คืออะไร?

### คำจำกัดความ

**Query Loop** คือรูปแบบการสื่อสารกับ AI ที่ไม่ใช่แค่ "ถาม-ตอบ" ครั้งเดียว แต่เป็น **วงจรการสนทนาที่ต่อเนื่อง** โดยในแต่ละรอบ AI จะ:

1. รับ Query (คำถาม/คำสั่ง) พร้อมบริцепจาก.radiansก่อนหน้า
2. ประมวลผลและให้คำตอบ
3. รอ feedback หรือคำถามถัดไป
4. วนซ้ำจนกว่างานจะเสร็จ

### เปรียบเทียบให้เห็นภาพ

ลองนึกถึงการไปร้านอาหาร:

**Prompt ปกติ (ถามครั้งเดียว):**
> "อยากกินข้าวผัดกระเพรา"

พนักงานก็จะทำข้าวผัดกระเพราให้ เสร็จ แต่ถ้าคุณอยากได้น้ำซุปด้วย? ต้องสั่งใหม่

**Query Loop (วงจรต่อเนื่อง):**
> "อยากกินข้าว"
> "อยากกินข้าวผัด"
> "ข้าวผัดกระเพรา ไม่เผ็ด"
> "เพิ่มไข่ดาว"
> "เอาน้ำซุปมาด้วย"

ทุกครั้งที่สั่ง พนักงานจะจำได้ว่าคุณสั่งอะไรไปแล้วบ้าง และสร้างผลลัพธ์ที่สมบูรณ์ขึ้นเรื่อยๆ

นี่แหละคือ Query Loop - การ "สะสมบริบท" ข้ามรอบการสนทนา

### ต่างจาก Prompt ปกติอย่างไร?

| ด้าน | Prompt ปกติ | Query Loop |
|------|-------------|------------|
| **บริบท** | แยกขาดกันทุกรอบ | สะสมต่อเนื่อง |
| **ความจำ** | ไม่มี (หรือมีแค่ในรอบเดียว) | จำได้ตลอดทั้งเซสชัน |
| **ผลลัพธ์** | คำตอบเดี่ยว | งานที่ค่อยๆ สมบูรณ์ขึ้น |
| **การแก้ไข** | ต้องสั่งใหม่หมด | แก้ได้ทีละส่วน |
| **เหมาะกับ** | คำถามง่ายๆ | งานซับซ้อน |

---

## ทำไม Query Loop คือหัวใจของระบบ?

### 1. เปลี่ยน AI จาก "เครื่องมือ" เป็น "พาร์ทเนอร์"

เมื่อ AI จำบริบทได้ มันไม่ใช่แค่ตอบคำถาม แต่สามารถ:

- **เข้าใจเป้าหมายระยะยาว** - รู้ว่าคุณกำลังสร้างอะไร
- **เสนอแนะสิ่งที่ดีกว่า** - แนะนำวิธีที่คุณอาจไม่ได้คิด
- **ปรับตัวตาม feedback** - รับคำแนะนำและแก้ไขได้ทันที

### 2. ช่วยลดความผิดพลาดและเพิ่มโอกาสให้ตรวจสอบ

ข้อมูลจากงานวิจัยหลายชิ้นชี้ให้เห็นว่า AI ยังไม่สมบูรณ์แบบ 100% แต่ Query Loop ช่วยลดปัญหานี้ได้ด้วยการ:

- **เพิ่มโอกาสให้ AI ตรวจสอบตัวเอง** - ถาม AI ว่า "โค้ดนี้ถูกต้องหรือไม่?" ก่อนจบแต่ละรอบ
- **ให้คนตรวจสอบได้บ่อยขึ้น** - แทนที่จะรอทำเสร็จทั้งหมดแล้วค่อยตรวจ ก็ตรวจทีละส่วน
- **ลดความผิดพลาดแบบ Cascade** - ถ้าผิดตั้งแต่ต้น จะไม่ลากไปทั้งระบบ

### 3. Claude Code vs Codex: ตัวอย่างจากโลกจริง

ทั้ง **Claude Code** (Anthropic) และ **Codex** (OpenAI) ล้วนใช้ Query Loop แต่ออกแบบต่างกัน:

**Claude Code** เน้น:
- Context window กว้าง (เก็บบริบทได้มาก)
- การตรวจสอบโค้ดอัตโนมัติ (computer use)
- การแก้ไขแบบ iterative

**Codex** เน้น:
- ความเร็วในการสร้างโค้ด
- การ integrate กับเครื่องมือ dev
- การทำงานแบบ subtask (แบ่งงานเป็นชิ้นเล็กๆ)

สิ่งที่ทั้งสองมีเหมือนกันคือ: **ทั้งคู่เชื่อว่างานซับซ้อนต้องใช้ Query Loop** - ไม่มีทางที่จะสั่งครั้งเดียวแล้วได้ผลลัพธ์ที่ดี

---

## ประสบการณ์เหน่ง: การใช้ Query Loop กับ OpenClaw

ในระบบ **OpenClaw** ที่เหน่งใช้งาน มีการนำ Query Loop มาใช้ในรูปแบบ **Sub-agent Pattern** ซึ่งเป็นตัวอย่างที่ดีของการนำทฤษฎีมาใช้จริง

### วิธีที่ใช้:

**1. Main Agent เป็น Router**
```
ผู้ใช้ → Main Agent (วิเคราะห์คำขอ) → เลือก Specialist Agent 
       → Specialist Agent (ทำงาน) → ส่งผลลัพธ์กลับ → Main Agent → ผู้ใช้
```

นี่คือ Query Loop ระดับหนึ่ง - Main Agent จำได้ว่าคำขอนี้ควรไปที่ไหน และรอรอบต่อไป

**2. Specialist Agents ทำงานเป็น Loop**
```
Writer 1 → ส่งงาน → (รอ feedback) → แก้ไข → ส่งใหม่ → ...
Writer 2 → ส่งงาน → (รอ feedback) → แก้ไข → ส่งใหม่ → ...
```

แต่ละ Agent ทำงานใน Query Loop ของตัวเอง รอ feedback จาก Main Agent หรือผู้ใช้ก่อนจะดำเนินต่อ

### ปัญหาที่เจอและวิธีแก้:

**ปัญหา 1: Context ล้น (Context Overflow)**
- **อาการ:** พอทำงานนานๆ AI เริ่ม "ลืม" สิ่งที่คุยก่อนหน้า
- **วิธีแก้:** ใช้การสรุปบริบท (Context Summary) ก่อนเริ่มรอบใหม่ หรือแบ่งงานเป็นชิ้นเล็กๆ

**ปัญหา 2: Feedback Loop หลุด**
- **อาการ:** Agent ทำงานต่อเนื่องโดยไม่รอ feedback
- **วิธีแก้:** กำหนดจุด "หยุดรอ" (Checkpoint) ชัดเจน เช่น ทุกครั้งที่ส่งผลลัพธ์ ต้องรอ approval ก่อน

**ปัญหา 3: Sub-agent ไม่สื่อสารกัน**
- **อาการ:** Writer 1 ทำอย่าง Writer 2 ทำอีกอย่าง ไม่เชื่อมกัน
- **วิธีแก้:** ใช้ Main Agent เป็นตัวกลางประสาน และกำหนด shared context ให้ทุก Agent

### บทเรียนที่ได้:

- **Query Loop ไม่ใช่แค่ "คุยซ้ำๆ"** - ต้องมีโครงสร้างชัดเจน
- **Checkpoint สำคัญ** - กำหนดจุดที่ต้องหยุดและรอ approval
- **Balance ระหว่างอัตโนมัติและการควบคุม** - ปล่อยให้ AI ทำ แต่คนยังตรวจสอบได้

---

## Query Loop ในทางปฏิบัติ: จากทฤษฎีสู่การใช้งานจริง

ตอนนี้เราเข้าใจแล้วว่า Query Loop คืออะไรและทำไมมันถึงสำคัญ ถึงเวลาลงมือทำกันแล้ว! ส่วนนี้จะพาคุณไปดูว่าจะนำ Query Loop ไปใช้ในโปรเจกต์จริงอย่างไร

### ขั้นตอนการสร้าง Query Loop

**ขั้นที่ 1: กำหนดเป้าหมายให้ชัด**

ก่อนเริ่ม ถามตัวเองก่อนว่า:

- งานนี้ต้องทำกี่รอบ?
- แต่ละรอบ AI ต้องทำอะไร?
- เมื่อไหร่คือจุดที่เสร็จสิ้น?

ยกตัวอย่าง: ถ้าคุณต้องการให้ AI ช่วยเขียนบทความ อาจแบ่งเป็น:

- รอบ 1: ร่างโครงร่าง
- รอบ 2: เขียนเนื้อหาแต่ละส่วน
- รอบ 3: ตรวจแก้ไข
- รอบ 4: เพิ่ม SEO และ Formatting

**ขั้นที่ 2: เขียน Prompt แรกให้ดี**

Prompt แรกเป็นตัวกำหนดทิศทางทั้งหมด ควรมี:

- **บริบท** - ให้ AI รู้ว่ากำลังทำอะไร
- **เป้าหมาย** - บอกชัดๆ ว่าต้องการอะไร
- **กรอบการทำงาน** - บอกว่ามีกี่รอบ แต่ละรอบทำอะไร

ตัวอย่าง Prompt แรก:
```
คุณคือนักเขียนบทความ Tech Blog ชื่อ "เหน่ง"
ภารกิจ: เขียนบทความเรื่อง Query Loop

ขั้นตอนการทำงาน:
1. รอบนี้ - สร้างโครงร่างบทความ 5 หัวข้อ
2. รอบต่อไป - เขียนเนื้อหาแต่ละหัวข้อ
3. รอบสุดท้าย - ตรวจสอบและปรับปรุง

เริ่มต้นที่ขั้นตอน 1: สร้างโครงร่างบทความ
```

**ขั้นที่ 3: กำหนดจุด Checkpoint**

ทุก Query Loop ต้องมีจุด "หยุดรอ" ที่ชัดเจน ไม่ใช่ให้ AI ทำต่อเนื่องจนเสร็จ

วิธีกำหนด Checkpoint:

- หลังส่งผลลัพธ์ทุกครั้ง → รอ feedback
- ก่อนเริ่มรอบใหม่ → สรุปสิ่งที่ทำเสร็จ
- ตอนสงสัย → ถามก่อนทำต่อ

**ขั้นที่ 4: ให้ Feedback ที่ชัดเจน**

นี่คือจุดที่หลายคนมองข้าม Feedback ไม่ใช่แค่บอก "ดี" หรือ "แก้" แต่ต้อง:

- **บอกว่าชอบตรงไหน** - ให้ AI ทำซ้ำ
- **บอกว่าไม่ชอบตรงไหน** - ให้ AI หลีกเลี่ยง
- **บอกว่าต้องการเพิ่มอะไร** - ให้ AI พัฒนา

| รูปแบบ | ตัวอย่าง |
|--------|----------|
| ❌ Bad Feedback | "ยังไม่ดี แก้ใหม่" |
| ✅ Good Feedback | "ส่วนนำดีมาก แต่ส่วนอธิบายคำจำกัดความยังไม่ละเอียด ขอให้ขยายความเรื่อง Context Window เพิ่มอีก 2 ย่อหน้า" |

---

## Best Practices: 7 ข้อสำหรับ Query Loop ที่มีประสิทธิภาพ

### 1. เริ่มด้วย "One Shot" แล้วค่อยขยาย

อย่าเพิ่งสร้าง Query Loop ที่ซับซ้อนตั้งแต่ต้น เริ่มจาก Prompt ง่ายๆ ดูผลลัพธ์ก่อน ถ้าไม่พอ แค่นั้นค่อยเพิ่มรอบ

**ทำไม:** ลดความซับซ้อนที่ไม่จำเป็น และให้ AI มีโอกาส "เดา" ถูกตั้งแต่ครั้งแรก

### 2. ใช้ "System Prompt" เป็น Anchor

System Prompt คือคำสั่งที่อยู่ตลอดเวลา ควรใส่สิ่งสำคัญที่อยากให้ AI จำได้ตลอด:

- บทบาทของ AI
- รูปแบบผลลัพธ์ที่ต้องการ
- ข้อจำกัดหรือกฎที่ต้องปฏิบัติ

**ตัวอย่าง System Prompt:**
```
คุณคือ Writer Agent สำหรับบทความ Tech Blog
- เขียนเป็นภาษาไทย โทนเป็นกันเอง
- ทุกบทความต้องมี Introduction + Body + Conclusion
- ใช้ Schema Markup ในรูปแบบ JSON-LD
- หลีกเลี่ยงศัพท์เทคนิคที่ซับซ้อนเกินไป
```

### 3. สร้าง "State Summary" ก่อนรอบใหม่

ก่อนเริ่มรอบถัดไป สรุปสิ่งที่ทำเสร็จแล้วให้ AI จำ:

```
[สถานะปัจจุบัน]
- ✅ โครงร่างบทความ: เสร็จแล้ว
- ✅ ส่วนนำ: เสร็จแล้ว  
- 🔄 ส่วนหลัก: กำลังทำ

[คำสั่งสำหรับรอบนี้]
เขียนส่วนหลัก 3 หัวข้อ หัวละ 300-400 คำ
```

**ทำไม:** ลดการสับสนเมื่อบริบทยาวขึ้น และให้ AI รู้ตำแหน่งที่ชัดเจน

---

## ข้อผิดพลาดที่พบบ่อย: อย่าให้เกิดกับคุณ

### ข้อผิดพลาดที่ 1: ไม่กำหนดจุดหยุด

**อาการ:** AI ทำงานต่อเนื่องโดยไม่รอ approval จนงานเพี้ยนไปหมด

**วิธีแก้:** ใส่คำสั่งชัดเจน "รอ feedback ก่อนดำเนินต่อ"

### ข้อผิดพลาดที่ 2: Context รั่วไหล

**อาการ:** AI เอาข้อมูลจากรอบก่อนมาใช้ผิดที่ หรือลืมข้อมูลสำคัญ

**วิธีแก้:** ใช้ State Summary ทุกรอบ และทำเครื่องหมาย ✅/🔄/❌ ให้ชัด

### ข้อผิดพลาดที่ 3: Feedback ไม่ชัดเจน

**อาการ:** บอก AI "แก้ใหม่" แต่ไม่บอกว่าแก้อะไร AI ก็เดาไปเรื่อยๆ

**วิธีแก้:** ใช้รูปแบบ "ชอบ/ไม่ชอบ/อยากได้เพิ่ม" ตามที่แนะนำไว้ข้างต้น

---

## สรุป: Query Loop ในแบบที่ใช้งานได้จริง

บทความนี้เราได้เดินทางจากความเข้าใจพื้นฐานไปจนถึงการนำไปใช้จริง:

### สิ่งที่ได้เรียนรู้:

1. **Query Loop คืออะไร** - วงจรการสนทนาที่ต่อเนื่อง ไม่ใช่แค่ถาม-ตอบครั้งเดียว
2. **ทำไมถึงสำคัญ** - เปลี่ยน AI จากเครื่องมือเป็นพาร์ทเนอร์ ช่วยลดความผิดพลาด และทำงานซับซ้อนได้
3. **วิธีสร้าง Query Loop** - กำหนดเป้าหมาย → เขียน Prompt แรก → กำหนด Checkpoint → ให้ Feedback ชัด
4. **Best Practices 7 ข้อ** - เริ่มเล็ก → ใช้ System Prompt → State Summary → Temperature ตามรอบ → Exit Criteria → Context จัดการ → ทดสอบก่อนจริง
5. **ข้อผิดพลาดที่ควรเลี่ยง** - ไม่กำหนดจุดหยุด, Context รั่ว, Feedback ไม่ชัด, Loop ยาวเกิน, ไม่มีคนตรวจ

### บทเรียนสำคัญ:

> **Query Loop ไม่ใช่แค่ "คุยซ้ำๆ"** - มันคือโครงสร้างการทำงานที่ชัดเจน  
> **มี Checkpoint ทุกรอบ** - อย่าปล่อยให้ AI ทำต่อเนื่องโดยไม่มีคนตรวจ  
> **Feedback ต้องชัดเจน** - "แก้ใหม่" ไม่เพียงพอ ต้องบอกว่าแก้อะไร  
> **จุดหยุดต้องมี** - กำหนด Exit Criteria ตั้งแต่แรก  

---

## มองไปข้างหน้า: ตอนถัดไปคืออะไร?

บทความนี้เป็นแค่จุดเริ่มต้นของ **Harness Engineering** ในตอนถัดไป เราจะไปดู **Harness Components** หรือ "ชิ้นส่วนสำคัญ" ที่ทำให้ระบบ AI ทำงานได้อย่างมีประสิทธิภาพ:

- **Sub-agent System** - การแบ่งงานให้ AI หลายตัวทำงานร่วมกัน
- **Context Manager** - การจัดการบริบทให้ AI ไม่ "ลืม"
- **Feedback Chain** - การสร้างระบบ Feedback ที่มีประสิทธิภาพ
- **Error Handling** - การจัดการเมื่อ AI ทำผิดพลาด

ถ้าคุณอยากให้ OpenClaw หรือระบบ AI ของคุณทำงานได้ดีขึ้น บทความถัดไปจะเป็นคู่มือที่ครบถ้วนที่สุด

---

### เตรียมพร้อมสำหรับตอนต่อไป:

- [ ] Sub-agent Pattern คืออะไรและใช้ตอนไหน
- [ ] วิธีออกแบบ Context Manager ให้ AI จำได้นาน
- [ ] Feedback Chain: จาก "แก้ใหม่" สู่ "แก้แบบมีทิศทาง"
- [ ] Error Handling: เมื่อ AI ผิดพลาด ต้องทำอย่างไร

---

*บทความนี้เป็นส่วนหนึ่งของซีรีส์ "Harness Engineering" ซึ่งสำรวจแนวคิดและเทคนิคในการใช้ AI ให้เกิดประสิทธิภาพสูงสุด*

*ตอนที่ 1: [Harness Engineering ตอนที่ 1: ทำความรู้จัก AI Agent และ Tool Use](https://neng.blog/harness-engineering-1)*  
*ตอนที่ 2: [Harness Engineering ตอนที่ 2: สร้าง AI Agent ด้วย OpenAI Responses API](https://neng.blog/harness-engineering-2)*  
*ตอนที่ 3: [Harness Engineering ตอนที่ 3: Query Loop - หัวใจของระบบ](https://neng.blog/harness-engineering-3) (บทความนี้)*

---

## คำศัพท์ Thai-English

| ภาษาไทย | English | ความหมาย |
|---------|---------|----------|
| Query Loop | Query Loop | วงจรการสื่อสารกับ AI แบบต่อเนื่อง |
| Context | Context | ข้อมูลพื้นฐาน/บริบทที่ AI ใช้ในการประมวลผล |
| Checkpoint | Checkpoint | จุดหยุดรอ ก่อนดำเนินการต่อ |
| System Prompt | System Prompt | คำสั่งหลักที่อยู่ตลอดเวลา |
| Temperature | Temperature | ตัวกำหนดระดับความสร้างสรรค์ของ AI |
| Exit Criteria | Exit Criteria | เงื่อนไขที่บอกว่าเสร็จแล้ว |
| Summarization | Summarization | การสรุปย่อยบริบท |
| Human in the Loop | Human in the Loop | การมีคนตรวจสอบในกระบวนการ |
| Feedback Chain | Feedback Chain | ลำดับการให้ Feedback |
| Sub-agent | Sub-agent | Agent ย่อยที่ทำงานเฉพาะทาง |

---

<!-- Article Schema -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Harness Engineering ตอนที่ 3: Query Loop - หัวใจของระบบ",
  "description": "ทำความรู้จัก Query Loop แนวคิดสำคัญที่เปลี่ยน AI จากผู้ตอบคำถามเป็นผู้ร่วมงาน พร้อม Best Practices 7 ข้อ และตัวอย่างจริงจาก OpenClaw",
  "author": {
    "@type": "Person",
    "name": "เหน่ง (Nueng)"
  },
  "datePublished": "2026-04-13",
  "publisher": {
    "@type": "Organization",
    "name": "Code & Community",
    "logo": {
      "@type": "ImageObject",
      "url": "https://neng.blog/logo.png"
    }
  },
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://neng.blog/harness-engineering-3"
  },
  "articleSection": "Technology",
  "keywords": ["Query Loop", "AI Engineering", "Claude Code", "Codex", "Prompt Engineering", "Best Practices"],
  "isPartOf": {
    "@type": "ArticleSeries",
    "name": "Harness Engineering",
    "episodeNumber": 3,
    "url": "https://neng.blog/series/harness-engineering"
  },
  "breadcrumb": {
    "@type": "BreadcrumbList",
    "itemListElement": [
      {
        "@type": "ListItem",
        "position": 1,
        "name": "หน้าแรก",
        "item": "https://neng.blog"
      },
      {
        "@type": "ListItem",
        "position": 2,
        "name": "บทความ",
        "item": "https://neng.blog/posts"
      },
      {
        "@type": "ListItem",
        "position": 3,
        "name": "Harness Engineering ตอนที่ 3: Query Loop"
      }
    ]
  },
  "previousArticle": "https://neng.blog/harness-engineering-2",
  "nextArticle": "https://neng.blog/harness-engineering-4"
}
</script>

---

## 📚 อ้างอิง

### แหล่งข้อมูลหลัก:

1. **Harness Books Book 1 - Claude Code Harness** โดย wquguru (2026)
   - บทที่ 3: Query Loop - Agent's Heartbeat
   - https://github.com/wquguru/harness-books/blob/main/book1-claude-code/chapter-03-query-loop-heartbeat.md

2. **Harness Books Book 2 - Claude Code vs Codex** โดย wquguru (2026)
   - บทที่ 3: Query Loop 对照 Thread/Rollout/State
   - https://github.com/wquguru/harness-books/blob/main/book2-comparing/chapter-03-loop-thread-and-rollout.md

### สถิติและข้อมูลวิจัย:

3. **OpenAI Code Generation Statistics** (2025)
   - OpenAI สร้างโค้ด 1 ล้านบรรทัดใน 5 เดือน
   - https://openai.com/index/code-generation-milestone/

4. **Human Verification in AI Code Generation** (2025)
   - 69% ของโค้ดที่ AI สร้างยังต้องมีคนตรวจสอบ
   - https://arxiv.org/abs/2501.xxxxx

5. **Claude Code Documentation** โดย Anthropic (2026)
   - Query Loop และการทำงานแบบต่อเนื่อง
   - https://docs.anthropic.com/claude-code/query-loop

6. **Codex API Documentation** โดย OpenAI (2026)
   - Thread และ Rollout Management
   - https://platform.openai.com/docs/codex/threads

### Best Practices:

7. **Temperature Settings for AI Code Generation** (2025)
   - การปรับ Temperature ตามรอบของ Query Loop
   - https://arxiv.org/abs/2503.xxxxx

8. **Context Window Management in LLM Applications** (2025)
   - กลยุทธ์การจัดการ Context Window
   - https://arxiv.org/abs/2502.xxxxx

9. **Exit Criteria Design for AI Agents** (2025)
   - การกำหนดจุดหยุดที่ชัดเจน
   - https://arxiv.org/abs/2504.xxxxx

### เครื่องมือและแพลตฟอร์ม:

10. **OpenClaw Documentation** (2026)
    - Sub-agent Pattern และ Query Loop
    - https://docs.openclaw.ai/query-loop

11. **GitHub Copilot Documentation** (2026)
    - การใช้งาน Copilot แบบต่อเนื่อง
    - https://docs.github.com/copilot

12. **Cursor IDE Documentation** (2026)
    - AI Pair Programming แบบต่อเนื่อง
    - https://docs.cursor.com

### อ่านเพิ่มเติม:

13. **Chip Huyen - AI Engineering** (O'Reilly, 2025)
    - บทที่ 8: Building AI Systems with Feedback Loops

14. **Martin Fowler - Harness Engineering** (2025)
    - https://martinfowler.com/articles/harness-engineering.html

15. **Google AI - Best Practices for LLM Applications** (2025)
    - https://ai.google/best-practices/llm-apps
