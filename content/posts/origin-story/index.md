---
title: "จากคนไม่รู้โค้ดสู่การสร้างบล็อกด้วย AI"
date: 2026-04-16T19:45:00+07:00
lastUpdated: 2026-04-16
description: "บันทึกการเดินทางของนักวิชาการพัฒนาชุมชน จากคนที่ไม่รู้โค้ด สู่การสร้างบล็อกด้วย AI และ Hugo Static Site Generator — พิสูจน์ว่าถ้าผมทำได้ คุณก็ทำได้เช่นกัน"
keywords: [origin-story, ai, hugo, openclaw, neng-lab]
author: "เหน่ง (Nueng)"
tags: ['origin-story', 'ai', 'hugo', 'openclaw']
categories: ['Personal', 'AI', 'Tutorial']
image: "cover.jpg"
draft: false
---

# จากคนไม่รู้โค้ดสู่การสร้างบล็อกด้วย AI: บันทึกการเดินทางของนักวิชาการพัฒนาชุมชน

เมื่อ 6 เดือนก่อน ผมไม่รู้ว่า Hugo คืออะไร คิดว่า CLI เป็นคำสาป และเคยเชื่อว่า "การสร้างบล็อก" เป็นเรื่องของคนรู้โค้ดเท่านั้น แต่ตอนนี้ ผมมีบล็อกที่ทำงานได้จริง — โดยเขียนโค้ดเองไม่ถึง 10 บรรทัด

---

## ผมไม่ใช่โปรแกรมเมอร์

ผมชื่อเหน่ง เป็นนักวิชาการพัฒนาชุมชน ทำงานให้กรมการพัฒนาชุมชน กระทรวงมหาดไทย

งานหลักของผมคือดูแลชุมชน ส่งเสริมอาชีพ และทำโครงการพัฒนาต่างๆ ไม่เกี่ยวกับเทคโนโลยีโดยตรง และที่สำคัญ — **ผมไม่ใช่โปรแกรมเมอร์**

ผมเขียนโค้ดไม่เป็น ไม่เคยเรียน Computer Science และทุกครั้งที่ได้ยินคำว่า "API", "CLI", หรือ "Static Site Generator" ผมจะรู้สึกว่ามันเป็นเรื่องไกลตัว มากเกินไปสำหรับคนทั่วไปอย่างผม

แต่แล้วชีวิตก็เปลี่ยน เมื่อผมได้รู้จักกับ AI

เรื่องนี้คือบันทึกการเดินทางจาก "คนไม่รู้โค้ด" สู่ "คนสร้างบล็อกด้วย AI" ครับ ไม่ใช่เพื่ออวดว่าผมเก่ง แต่เพื่อพิสูจน์ว่า **ถ้าผมทำได้ คุณก็ทำได้เช่นกัน**

---

## เล่น AI (Gemini, Suno)

### จุดเริ่มต้น: ความอยากรู้อยากลอง

ทุกอย่างเริ่มจากความอยากรู้อยากลอง ผมได้ยินข่าวเรื่อง AI มาเยอะมาก ทั้ง Gemini ของ Google, ChatGPT ของ OpenAI และอีกมากมาย แต่ผมไม่เคยลองใช้จริง เพราะคิดว่า "คงไม่เกี่ยวกับผม"

จนวันหนึ่ง ผมตัดสินใจลอง

### Gemini AI: เพื่อนคู่คิดคนแรก

Gemini คือโมเดล AI แบบมัลติโมดัลจาก Google ที่สามารถประมวลผลข้อความ รูปภาพ วิดีโอ และเสียงได้พร้อมกัน ผมเริ่มใช้ Gemini ในเวอร์ชันฟรีก่อน เพราะไม่อยากเสียเงิน

**สิ่งที่ผมทำกับ Gemini:**

- ถามคำถามทั่วไป: "วิธีทำอาหารไทย", "แนะนำหนังสือดีๆ", "วางแผนท่องเที่ยวเชียงใหม่"
- ขอคำแนะนำงาน: "เขียนโครงการพัฒนาชุมชน", "สรุปเอกสารราชการ", "ออกแบบแบบสำรวจ"
- ลองเล่นฟีเจอร์ใหม่: Gemini Live ที่สนทนาแบบเรียลไทม์, Gemini CLI สำหรับสั่งงานด้วยเสียง

**สิ่งที่เรียนรู้:**

Gemini ช่วยผมได้มากกว่าที่คิด ไม่ใช่แค่ตอบคำถาม แต่ช่วย "คิด" ด้วย เช่น เวลาผมจะเขียนโครงการ Gemini ช่วยจัดโครงร่าง เสนอไอเดีย และตรวจคำผิดให้

แต่ Gemini ก็มีข้อจำกัด คือต้องพิมพ์สั่งทุกขั้นตอน ถ้าผมลืมสั่ง มันก็ไม่ทำต่อ เหมือนมีผู้ช่วยที่ขี้เกียจหน่อยๆ

### Suno AI: เมื่อ AI แต่งเพลงได้

หลังจากคุ้นเคยกับ Gemini ผมเริ่มลองเล่น Suno AI — เครื่องมือสร้างเพลงด้วย AI ที่เปลี่ยนข้อความเป็นเพลงเต็มรูปแบบ

**สิ่งที่ผมทำกับ Suno:**

- สร้างเพลงจากข้อความ: พิมพ์ prompt สั้นๆ เช่น "เพลงป๊อปเกี่ยวกับความรัก ภาษาไทย" ก็ได้เพลงเต็ม 4 นาที
- ลองใช้ Custom Lyrics: ใส่เนื้อเพลงเอง แล้วให้ Suno ทำนองให้
- เล่น Cover Feature: อัปโหลดทำนองสั้นๆ แล้วให้ AI สร้างเพลงเต็ม

**สิ่งที่เรียนรู้:**

Suno ทำให้ผมตระหนักว่า AI ไม่ได้ช่วยแค่เรื่อง "งาน" แต่ช่วยเรื่อง "ความคิดสร้างสรรค์" ด้วย ผมที่ไม่เคยแต่งเพลงมาก่อน กลับมีเพลงที่เป็นของตัวเองได้

แต่ตอนนั้น ผมยังมอง AI เป็นแค่ "ของเล่น" ไม่ใช่ "เครื่องมือทำงาน"

### จากช่วงเวลานี้

หลังจากเล่น Gemini และ Suno อยู่ 2-3 เดือน ผมพบว่า AI ใช้งานง่ายกว่าที่คิด ไม่ต้องรู้โค้ดก็สั่งงานได้ และช่วยได้จริงทั้งงานและความคิดสร้างสรรค์

แต่ผมยังรู้สึกว่า "นี่คงแค่นี้แหละ" — จนได้รู้จักกับสิ่งที่เปลี่ยนทุกอย่าง

---

## รู้จัก AI Agent (OpenClaw, QwenPaw)

### การค้นพบ: AI ที่ทำงานแทนเราได้

วันหนึ่ง ผมไปเจอคำว่า "AI Agent" ใน facebook คนพูดกันว่า "AI Agent ทำงานแทนเราได้" ผมสงสัยมาก เพราะที่เคยใช้มา AI ต้องสั่งทุกขั้นตอน แล้วมันทำงานแทนเราได้ยังไง?

ผมเริ่มค้นหา และพบ 2 สิ่งที่เปลี่ยนเกม: **OpenClaw** และ **QwenPaw**

### OpenClaw: ระบบจัดการ AI Agent หลายตัว

OpenClaw คือ framework สำหรับสร้างและจัดการ AI Agent หลายตัวที่ทำงานร่วมกัน ผ่านช่องทางสื่อสารต่างๆ เช่น Telegram, Discord, WhatsApp

**สิ่งที่ทำให้ OpenClaw ต่างจาก Gemini:**

Gemini ต้องสั่งทุกขั้นตอน มี Agent เดียว จำกัดอยู่หน้าเว็บ และไม่มี Memory แต่ OpenClaw ทำงานอัตโนมัติได้ จัดการ Agent หลายตัวพร้อมกัน ใช้งานผ่าน Telegram หรือ Discord ได้ และมีระบบ Memory จำบริบทได้

**ฟีเจอร์ที่ผมชอบ:**

- **Multi-Agent Routing:** สร้าง Agent หลายตัว แต่ละตัวมีหน้าที่ต่างกัน เช่น ตัวหนึ่งเขียนบทความ ตัวหนึ่งตรวจ SEO ตัวหนึ่งโพสต์ลงโซเชียล
- **Memory System:** Agent จำได้ว่าเราคุยอะไรกันไปบ้าง ไม่ต้องเล่าใหม่ทุกครั้ง
- **Tool Integration:** Agent ใช้ tools ได้จริง เช่น อ่านไฟล์ เขียนไฟล์ รันคำสั่ง ใช้งานเบราว์เซอร์

### QwenPaw: AI Agent ที่รันบนเครื่องตัวเอง

QwenPaw คือ personal AI agent ที่สร้างบนพื้นฐานของ Qwen models จาก Alibaba Cloud เน้นการทำงานแบบ local-first

**สิ่งที่ทำให้ QwenPaw น่าสนใจ:**

- **Local Deployment:** รันบนเครื่องตัวเอง ข้อมูลไม่ออกนอก → ปลอดภัยกว่า
- **Multi-Agent Collaboration:** สร้าง Agent หลายตัวทำงานร่วมกันได้
- **Skills Extension:** เพิ่มความสามารถผ่าน skills เช่น PDF, scheduling, news
- **Magic Commands:** ควบคุม conversation state โดยไม่ต้องรอ AI

### การทดลองแรก: สร้าง Agent เขียนบทความ

หลังจากศึกษา OpenClaw และ QwenPaw อยู่ 1-2 สัปดาห์ ผมตัดสินใจลองสร้าง Agent เขียนบทความดู

**ขั้นตอนที่ผมทำ:**

1. ติดตั้ง OpenClaw: โหลดไฟล์เดียว รันคำสั่งเดียว ก็เสร็จ
2. ตั้งค่า Agent: เขียนไฟล์ SOUL.md (ตัวตน), USER.md (ข้อมูลผู้ใช้), MEMORY.md (ความจำ)
3. เลือกโมเดล: ใช้ Qwen 3.5 Plus (ฟรี ผ่าน Bailian)
4. ทดสอบ: สั่งให้ Agent เขียนบทความสั้นๆ

**ผลลัพธ์:**

Agent เขียนบทความได้จริง! ไม่ใช่แค่ตอบคำถาม แต่เขียนบทความเต็มรูปแบบ มีโครงสร้าง มีหัวข้อ มีเนื้อหา

แต่ตอนนั้น ผมยังคิดว่า "คงเขียนได้แค่บทความทั่วไป" — จนผมลองสั่งให้มันช่วยสร้างบล็อก

### หลังจากเรียนรู้

หลังจากเล่น OpenClaw และ QwenPaw อยู่ 1-2 เดือน ผมพบว่า AI Agent ทำงานแทนเราได้จริง ไม่ต้องสั่งทุกขั้นตอน และ Multi-Agent Systems ทรงพลังมาก

แต่คำถามใหญ่ยังอยู่: **"แล้วคนไม่รู้โค้ดอย่างผม จะสร้างบล็อกได้ยังไง?"**

---

## สร้างบล็อกด้วย Hugo CLI

### ความท้าทาย: ไม่รู้โค้ด จะสร้างบล็อกได้ยังไง?

ผมอยากมีบล็อกเป็นของตัวเอง มานานแล้ว แต่ติดปัญหาใหญ่: **ผมเขียนโค้ดไม่เป็น**

ผมเคยลอง WordPress แล้ว แต่รู้สึกว่าต้องตั้งค่าเยอะมาก ต้องดูแล server เอง ช้าถ้ามี plugin เยอะ และมีค่าใช้จ่าย

จนวันหนึ่ง ผมไปเจอคำว่า **"Hugo Static Site Generator"**

### Hugo คืออะไร?

Hugo คือ Static Site Generator (SSG) ที่เขียนด้วยภาษา Go ขึ้นชื่อเรื่องความเร็วในการ build สูงมาก

**สิ่งที่ทำให้ Hugo ต่างจาก WordPress:**

WordPress เป็น Dynamic Site มี database ต้องมี server รัน และช้าถ้ามี plugin เยอะ แต่ Hugo เป็น Static Site ไม่มี database แค่ไฟล์ HTML/CSS/JS และเร็วมาก

**ฟีเจอร์ที่ผมชอบ:**

- **Blazing Fast Builds:** สร้างหลายพันหน้าในน้อยกว่า 1 วินาที
- **Single Binary:** ไม่ต้องติดตั้ง Node.js, npm — โหลดไฟล์เดียวใช้ได้เลย
- **No Runtime Dependency:** ไม่ต้องมี server รัน — แค่ไฟล์ HTML/CSS/JS
- **SEO-Friendly:** Pre-rendered HTML โหลดทันที Core Web Vitals ดี

### GitHub Pages: โฮสต์ฟรี พร้อม Custom Domain

หลังจากศึกษา Hugo แล้ว ผมต้องหาที่โฮสต์บล็อก และพบ **GitHub Pages**

GitHub Pages คือบริการ hosting ฟรีจาก GitHub สำหรับ static sites รองรับ custom domain และ HTTPS อัตโนมัติ

**สิ่งที่ทำให้ GitHub Pages น่าสนใจ:**

- **Free Hosting:** โฮสต์ฟรีไม่เสียค่าใช้จ่าย
- **Custom Domain:** ใช้ domain ตัวเองได้ฟรี
- **HTTPS by Default:** SSL/TLS อัตโนมัติผ่าน Let's Encrypt
- **Git Integration:** Push code แล้ว deploy อัตโนมัติ

**ข้อจำกัด:**

ไม่รองรับ server-side code เช่น PHP, Python, Node.js backend และไม่รองรับ database แต่สำหรับบล็อกแบบผม — ที่แค่แสดงบทความ — GitHub Pages เพียงพอแล้ว

### การทดลองแรก: สร้างบล็อกด้วย Hugo + AI

ตอนนี้ ผมมีเครื่องมือครบ: Hugo สำหรับสร้าง static site, GitHub Pages สำหรับโฮสต์ฟรี, และ OpenClaw/QwenPaw สำหรับ AI Agent ช่วยเขียน

ผมเริ่มลงมือทำ

**ขั้นตอนที่ผมทำ:**

1. ติดตั้ง Hugo: โหลดไฟล์เดียวจาก GitHub วางในโฟลเดอร์ที่ใช้งาน ก็เสร็จ
2. สร้างโครงบล็อก: ใช้คำสั่ง `hugo new site myblog` — AI ช่วยพิมพ์ให้
3. เลือกธีม: โหลดธีมฟรีจาก GitHub — AI ช่วยค้นหาและติดตั้ง
4. เขียนบทความ: สั่ง Agent เขียนบทความ — ได้ไฟล์ .md มา
5. Build: รันคำสั่ง `hugo` — ได้โฟลเดอร์ `public/` ที่มีไฟล์ HTML พร้อมใช้งาน
6. Deploy: Push ขึ้น GitHub — GitHub Pages deploy อัตโนมัติ

**ผลลัพธ์:**

บล็อกทำงานได้จริง! เข้าถึงได้ผ่าน internet มี custom domain มี HTTPS — โดยผมเขียนโค้ดเองไม่ถึง 10 บรรทัด

### สรุปการเดินทางนี้

หลังจากสร้างบล็อกด้วย Hugo และ GitHub Pages ผมพบว่าคนไม่รู้โค้ดก็สร้างบล็อกได้ ถ้าใช้เครื่องมือถูก และ AI ช่วยได้เกือบทุกขั้นตอน ตั้งแต่เขียนบทความจนถึง deploy

สิ่งที่สำคัญที่สุด ไม่ใช่แค่ "สร้างบล็อกได้" แต่คือ **"พิสูจน์ว่าทำได้จริง"**

---

## พิสูจน์ว่าทำได้จริง

### บล็อกที่ทำงานได้จริง

ตอนนี้ ผมมีบล็อกที่โฮสต์ฟรีบน GitHub Pages ไม่เสียค่าใช้จ่ายใดๆ มี custom domain ใช้ domain ตัวเองได้ มี HTTPS อัตโนมัติ ปลอดภัย โหลดเร็วมาก เพราะเป็น static site และ SEO-friendly Google index ง่าย

**URL:** https://neng-lab.com/

### สถิติที่น่าสนใจ

หลังจากเปิดบล็อกได้ **9 วัน** (ข้อมูลจาก Google Analytics):

- **จำนวนบทความ:** 20+ บทความ
- **จำนวนผู้อ่าน:** 300+ views
- **เวลาที่ใช้:** เฉลี่ย 2-3 ชั่วโมง/บทความ (รวมเขียน ตรวจ publish)
- **ค่าใช้จ่าย:** 0 บาท (ไม่รวม domain)

### บทเรียนที่ได้

**สิ่งที่ทำแล้วได้ผล:**

- เริ่มจากเล็กๆ: ไม่ต้องทำบล็อกใหญ่ตั้งแต่เริ่ม — เริ่มจากบทความเดียว
- ใช้ AI ให้ถูก: AI ช่วยเขียน แต่คนตรวจ — ไม่ใช่ให้ AI ทำหมด
- เรียนรู้ไปทำไป: ไม่ต้องรู้ทุกอย่างก่อนเริ่ม — เรียนรู้ระหว่างทำ
- บันทึกทุกขั้นตอน: เขียน down สิ่งที่เรียนรู้ — จะได้ไม่ลืม

**สิ่งที่ควรระวัง:**

- อย่าเชื่อ AI 100%: AI hallucinate ได้ — ต้องตรวจเสมอ
- อย่ารีบ publish: ตรวจบทความก่อน publish — เพื่อความถูกต้อง
- อย่าลืม backup: backup บทความและ config — กันหาย

---

## ปรัชญา Tech-Enabled, Humanity-Anchored

### เทคโนโลยีเป็นเครื่องมือ ไม่ใช่เป้าหมาย

ตลอดการเดินทางนี้ ผมเรียนรู้สิ่งหนึ่ง: **เทคโนโลยีเป็นเครื่องมือ ไม่ใช่เป้าหมาย**

AI ไม่ได้มีไว้เพื่อแทนที่มนุษย์ แต่มีไว้เพื่อ **เสริม** ให้มนุษย์ทำงานได้ดีขึ้น

### Tech-Enabled: ใช้เทคโนโลยีให้เต็มศักยภาพ

**Tech-Enabled** หมายความว่าใช้ AI ช่วยทำงานซ้ำๆ ใช้ automation ลดงาน manual ใช้ tools ที่เหมาะสมกับงาน และเรียนรู้เทคโนโลยีใหม่ๆ ตลอดเวลา

**ตัวอย่างที่ผมใช้:**

- AI เขียนบทความ: ลดเวลาเขียนจาก 5 ชั่วโมง → 1 ชั่วโมง
- Auto-deploy: Push แล้ว deploy อัตโนมัติ — ไม่ต้องทำ manual
- Memory System: Agent จำบริบทได้ — ไม่ต้องเล่าใหม่

### Humanity-Anchored: ความเป็นมนุษย์คือหัวใจ

แต่เทคโนโลยีอย่างเดียวไม่พอ **Humanity-Anchored** หมายความว่า AI ช่วยเขียน แต่คนตรวจ — เพื่อความถูกต้อง AI เสนอไอเดีย แต่คนตัดสินใจ — เพื่อความเหมาะสม AI ทำงานแทน แต่คนควบคุม — เพื่อความปลอดภัย และแบ่งปันความรู้ — เพื่อสร้าง impact ที่ยั่งยืน

**ตัวอย่างที่ผมทำ:**

- ตรวจบทความก่อน publish: AI เขียน แต่ผมตรวจความถูกต้อง
- ตัดสินใจเอง: AI เสนอไอเดีย แต่ผมตัดสินใจว่าจะใช้ไหม
- แบ่งปันความรู้: เขียนบทความนี้ — เพื่อให้คนอื่นเรียนรู้จากผม

### สมดุลที่ถูกต้อง

สมดุลที่ถูกต้องคือใช้เทคโนโลยีร่วมกับความเป็นมนุษย์

ถ้ามีแต่เทคโนโลยี งานอาจผิดเพราะ AI hallucinate ได้ ขาดความรับผิดชอบเพราะโทษ AI และไม่สร้าง impact เพราะไม่แบ่งปัน

ถ้ามีแต่มนุษย์ ทำงานช้าเพราะทำเองทุกขั้นตอน เหนื่อยง่ายเพราะงานซ้ำๆ มาก และจำกัดศักยภาพเพราะไม่ใช้ tools

แต่ถ้ามีทั้งสองอย่าง งานเร็วเพราะ AI ช่วย งานถูกต้องเพราะคนตรวจ และยั่งยืนเพราะแบ่งปันความรู้

### ปรัชญาที่ผมยึดถือ

**"ใช้เทคโนโลยีให้เต็มศักยภาพ แต่อย่าลืมความเป็นมนุษย์"**

นี่คือปรัชญาที่ผมยึดถือ และจะเป็นแนวทางที่ผมจะใช้ต่อไป

---

## สรุป

### สรุปการเดินทาง

จาก "คนไม่รู้โค้ด" สู่ "คนสร้างบล็อกด้วย AI" — การเดินทางนี้สอนผมหลายอย่าง

**ช่วงแรก (เล่น AI):** เริ่มต้นจาก AI ทั่วไป (Gemini, Suno) ที่ใช้งานง่าย ไม่ต้องรู้โค้ด สร้างความคุ้นเคยกับ AI-generated content และค้นพบว่า AI ช่วยสร้างสรรค์งานได้จริง

**ช่วงต่อมา (รู้จัก AI Agent):** ค้นพบ OpenClaw และ QwenPaw — AI ที่ทำงานอัตโนมัติได้มากกว่า เข้าใจแนวคิด Multi-Agent systems และเริ่มเห็นศักยภาพของ AI ที่ทำงานแทนเราได้

**ช่วงสุดท้าย (สร้างบล็อก):** ใช้ Hugo CLI สร้าง static site — เร็ว ง่าย ไม่ต้องรู้โค้ดมาก โฮสต์ฟรีบน GitHub Pages พร้อม custom domain และพิสูจน์ว่า "คนไม่รู้โค้ด" ก็สร้างบล็อกได้จริง

### สิ่งที่ได้เรียนรู้

1. คนไม่รู้โค้ดก็สร้างบล็อกได้ — ถ้าใช้เครื่องมือถูก
2. AI ช่วยได้จริง — ไม่ใช่แค่คำโฆษณา
3. ค่าใช้จ่ายเกือบเป็นศูนย์ — ไม่ต้องลงทุนมาก
4. เวลาที่ใช้ไม่เยอะ — เฉลี่ย 2-3 ชั่วโมง/บทความ
5. เทคโนโลยีเป็นเครื่องมือ ไม่ใช่เป้าหมาย — ความเป็นมนุษย์คือหัวใจ

### คำเชิญชวน

ถ้าคุณอ่านบทความนี้ แล้วคิดว่า "ผมก็อยากทำบ้าง" — **ผมขอให้คุณลองทำดู**

ไม่ต้องรอให้พร้อม ไม่ต้องรู้ทุกอย่างก่อนเริ่ม — เริ่มจากเล็กๆ เรียนรู้ไปทำไป

และถ้าคุณทำสำเร็จ — **ช่วยแบ่งปันความรู้ให้คนอื่นด้วย**

เพราะการแบ่งปันความรู้ คือวิธีสร้าง impact ที่ยั่งยืนที่สุด

### แล้วพบกันใหม่

นี่คือจุดเริ่มต้นของการเดินทาง ไม่ใช่จุดจบ

ผมจะยังคงเรียนรู้ ยังคงทดลอง และยังคงแบ่งปันความรู้ต่อไป

แล้วพบกันใหม่บทความหน้าครับ!

---

**เกี่ยวกับผู้เขียน:** เหน่ง — นักวิชาการพัฒนาชุมชน กรมการพัฒนาชุมชน กระทรวงมหาดไทย ผู้เชื่อว่า "เทคโนโลยีเป็นเครื่องมือ แต่ความเป็นมนุษย์คือหัวใจ"

**ติดตาม:**
- ✈️ Telegram: [@Jitaret](https://t.me/Jitaret)
- 🐙 GitHub: [github.com/jitaret-rgb](https://github.com/jitaret-rgb)
- 📘 Facebook: [facebook.com/jittaret.phromnanra](https://www.facebook.com/jittaret.phromnanra/)
- 📺 YouTube: [@jittaretpromnara5716](https://www.youtube.com/@jittaretpromnara5716)
- 🌐 Neng Lab: [neng-lab.com](https://neng-lab.com/)

**แชร์บทความนี้:** ถ้าคิดว่ามีประโยชน์ ช่วยแชร์ให้เพื่อนๆ ที่สนใจครับ

---

## 📚 แหล่งอ้างอิง

1. **Google Blog** — "The latest AI news we announced in March 2026"  
   https://blog.google/innovation-and-ai/technology/ai/google-ai-updates-march-2026/

2. **AIFOD** — "Google Unveils Major April 2026 Updates for Gemini AI"  
   https://af.net/realtime/google-unveils-major-april-2026-updates-for-gemini-ai-enhanced-multimodal-capabilities-and-new-features/

3. **9to5Google** — "What Gemini features you get with Google AI Pro [Feb 2026]"  
   https://9to5google.com/2026/04/11/google-ai-pro-ultra-features/

4. **eWeek** — "Google's March 2026 AI Drop: Gemini Gets Personal, Proactive, and..."  
   https://www.eweek.com/news/google-march-2026-ai-drop-gemini-updates/

5. **Blake Crosley** — "Suno AI Music Generation: The Definitive Technical Reference"  
   https://blakecrosley.com/guides/suno

6. **Suno Help** — "Suno Model Timeline & Information"  
   https://help.suno.com/en/articles/5782721

7. **Jack Righteous** — "Evolution of Suno AI: V3 to V4.5 Plus Guide"  
   https://jackrighteous.com/blogs/guides-using-suno-ai-music-creation/suno-ai-evolution-v3-to-v4-5-plus

8. **AudioCyper** — "The Musician's Guide to Suno AI Music in 2025"  
   https://www.audiocyper.com/post/suno-ai-chirp

9. **OpenClaw Docs** — "Multi-Agent Routing"  
   https://docs.openclaw.ai/concepts/multi-agent

10. **OpenClaw Docs** — "Features"  
    https://docs.openclaw.ai/concepts/features

11. **GitHub** — "openclaw/AGENTS.md"  
    https://github.com/openclaw/openclaw/blob/main/AGENTS.md

12. **Skywork AI** — "The Ultimate Guide to OpenClaw AI Agent Framework Documentation in 2026"  
    https://skywork.ai/skypage/en/openclaw-ai-agent-framework-docs/2037011884481974272

13. **Qwen-Agent Docs** — "Qwen-Agent Features"  
    https://qwenlm.github.io/Qwen-Agent/en/guide/get_started/features/

14. **GitHub** — "agentscope-ai/QwenPaw"  
    https://github.com/agentscope-ai/QwenPaw

15. **Hugging Face** — "agentscope-ai/QwenPaw-Flash-9B-Q8_0"  
    https://huggingface.co/agentscope-ai/QwenPaw-Flash-9B-Q8_0

16. **Cordoniq** — "Alibaba Cloud's Qwen AI model: Key features, capabilities and use cases"  
    https://www.cordoniq.com/alibaba-clouds-qwen-ai-model-key-features-capabilities-and-use-cases/

17. **Buildifyer** — "Best Static Site Generators in 2026 – Complete Comparison Guide"  
    https://buildifyer.com/en/blog/best-static-site-generators-comparison-2026

18. **CloudCannon** — "The top five static site generators for 2025 (and when to use them!)"  
    https://cloudcannon.com/blog/the-top-five-static-site-generators-for-2025-and-when-to-use-them/

19. **Naturaily** — "Best Static Site Generators in 2026: Top SSGs Compared"  
    https://naturaily.com/blog/best-static-site-generators

20. **Hygraph** — "Our Top 12 picks for Static Site Generators (SSGs) in 2026"  
    https://hygraph.com/blog/top-12-ssgs

21. **GitHub Docs** — "About custom domains and GitHub Pages"  
    https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages

22. **GitHub Docs** — "Managing a custom domain for your GitHub Pages site"  
    https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site

23. **Everhour** — "How to Host a Website on GitHub for Free: A 2026 Guide"  
    https://everhour.com/blog/how-to-host-website-on-github/

---

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "จากคนไม่รู้โค้ดสู่การสร้างบล็อกด้วย AI",
  "description": "บันทึกการเดินทางของนักวิชาการพัฒนาชุมชน จากคนที่ไม่รู้โค้ด สู่การสร้างบล็อกด้วย AI และ Hugo Static Site Generator — พิสูจน์ว่าถ้าผมทำได้ คุณก็ทำได้เช่นกัน",
  "author": {
    "@type": "Person",
    "name": "เหน่ง (Nueng)",
    "jobTitle": "นักวิชาการพัฒนาชุมชน",
    "worksFor": {
      "@type": "Organization",
      "name": "กรมการพัฒนาชุมชน กระทรวงมหาดไทย"
    }
  },
  "datePublished": "2026-04-16T19:45:00+07:00",
  "dateModified": "2026-04-16",
  "publisher": {
    "@type": "Organization",
    "name": "Neng Lab",
    "logo": {
      "@type": "ImageObject",
      "url": "https://neng-lab.com/logo.png"
    }
  },
  "image": "https://neng-lab.com/posts/origin-story/cover.jpg",
  "articleSection": ["Personal", "AI", "Tutorial"],
  "keywords": ["origin-story", "ai", "hugo", "openclaw", "neng-lab"],
  "inLanguage": "th",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://neng-lab.com/posts/origin-story/"
  }
}
</script>
