+++
title = 'เปิดโลก AI Assistant: คู่มือติดตั้ง OpenClaw สำหรับมือใหม่ (ฉบับไม่มีพื้นฐานก็ทำได้)'
date = 2026-04-06T08:20:00+07:00
draft = false
tags = ['openclaw', 'ai', 'tutorial', 'beginner', 'installation']
categories = ['Tutorial', 'Technology']
image = 'cover.jpg'
description = 'คู่มือติดตั้ง OpenClaw ทีละขั้นตอน เหมาะสำหรับมือใหม่ที่ไม่มีพื้นฐานก็ทำได้ พร้อมแนะนำ 6 Providers + LLMs ที่คุ้มค่า'
takeaways = [
  "ติดตั้ง OpenClaw ใน 5 ขั้นตอน: Clone → Install Dependencies → Setup Environment → Configure Provider → Start Server",
  "แนะนำ 6 Providers: OpenRouter (หลากหลาย), OpenAI (คุณภาพสูง), Together AI (ราคาถูก), Groq (เร็ว), Ollama (ฟรีบนเครื่อง), Gemini (ฟรี 1,500 req/วัน)",
  "ไม่ต้องมีพื้นฐานโปรแกรมมิ่ง — ทำตามคู่มือทีละขั้นตอนได้เลย"
]
+++

## 👋 บทนำ — OpenClaw คืออะไร?

เคยฝันไหมครับ? ว่าถ้ามี **ผู้ช่วยส่วนตัว** ที่:
- ตอบคำถามได้ตลอด 24 ชม.
- ช่วยเขียนบทความ ค้นหาข้อมูล จัดการไฟล์
- สั่งงานผ่านแชทได้เลย
- **ฟรี!** (หรือถูกมาก)

**OpenClaw** ทำให้ฝันนั้นเป็นจริงครับ!

---

### OpenClaw คืออะไร?

**OpenClaw** คือแพลตฟอร์มสำหรับสร้าง **AI Assistant ส่วนตัว** ที่:

✅ **ควบคุมด้วยข้อความธรรมชาติ** — คุยเหมือนคน  
✅ **เข้าถึงไฟล์ในเครื่องได้** — อ่าน/เขียน/แก้ไขไฟล์  
✅ **ค้นหาเว็บได้** — ดึงข้อมูลจาก internet  
✅ **ทำงานอัตโนมัติ** — ตั้งเวลา ส่งข้อความ  
✅ **จำสิ่งที่คุยกัน** — มี Memory System  
✅ **ฟรี!** — ใช้โมเดลฟรีได้หลายตัว

---

### ทำไมต้องใช้ OpenClaw?

| งาน | ทำเอง | มี OpenClaw |
|-----|-------|-------------|
| **ค้นหาข้อมูล** | เปิดเบราว์เซอร์เอง | สั่ง "มิก ค้นหาเรื่อง..." |
| **เขียนบทความ** | 2-3 ชั่วโมง | 30 นาที |
| **จัดการไฟล์** | เปิด File Explorer | สั่ง "มิก หาไฟล์..." |
| **ตั้งเตือน** | ตั้ง alarm เอง | สั่ง "เตือนฉันเรื่อง..." |
| **สรุปเอกสาร** | อ่านเองทั้งเล่ม | "มิก สรุปให้หน่อย" |

**ประหยัดเวลา:** 70-80%! ⏱️

---

### ต้องมีความรู้ก่อนไหม?

**คำตอบ: ไม่!** 🎉

ถ้าคุณ:
- ✅ พิมพ์แชทได้
- ✅ ดาวน์โหลดโปรแกรมได้
- ✅ ก็อปปี้-วางได้

**คุณก็ใช้ OpenClaw ได้แล้ว!**

บทความนี้จะพาทำทีละขั้นตอน **ไม่มีทางตกแน่นอน!**

---

## 📦 เตรียมตัวก่อนติดตั้ง

### ข้อกำหนดระบบ

```
✅ Node.js: Node 24 (แนะนำ) หรือ Node 22.14+
✅ RAM: 4GB+ (แนะนำ 8GB)
✅ CPU: 2 core+
✅ พื้นที่: 1GB+
✅ OS: macOS, Linux, Windows (Native/WSL2)
✅ Internet: สำหรับดาวน์โหลด
```

### ต้องมีอะไรบ้าง?

1. **คอมพิวเตอร์** (เครื่องไหนก็ได้)
2. **Internet** (สำหรับดาวน์โหลด)
3. **Telegram** (สำหรับแชทกับ AI)
4. **เวลา:** 15-30 นาที

### ใช้เวลาเท่าไหร่?

| ขั้นตอน | เวลา |
|--------|------|
| ติดตั้ง Node.js | 5 นาที |
| ติดตั้ง OpenClaw | 2 นาที |
| สร้าง Bot | 3 นาที |
| ตั้งค่า | 5 นาที |
| **รวม** | **15 นาที** |

---

## 🚀 ติดตั้งทีละขั้นตอน

### ขั้นตอนที่ 1: ติดตั้ง Node.js

OpenClaw ทำงานบน **Node.js** — ไม่ต้องกังวลครับ ติดตั้งง่ายมาก!

#### สำหรับ Windows:

1. **เปิดเว็บ:** https://nodejs.org/
2. **คลิกปุ่มสีเขียว** **"LTS"** (Recommended)
3. **ดาวน์โหลดเสร็จ** → ดับเบิลคลิกไฟล์
4. **กด Next** → Next → Next → Finish
5. **เสร็จ!**



#### สำหรับ macOS:

เปิด Terminal แล้วพิมพ์:

```bash
brew install node
```

(ถ้าไม่มี Homebrew → ติดตั้งจาก https://brew.sh/)

#### สำหรับ Linux:

```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

---

### ✅ ตรวจสอบว่าติดตั้งสำเร็จ

เปิด Command Prompt (หรือ Terminal) แล้วพิมพ์:

```bash
node --version
```

**ถ้าขึ้นแบบนี้ = สำเร็จ!** ✅

```
v20.x.x
```

**ถ้าไม่ขึ้น** → ลองติดตั้งใหม่ หรือ Google error ที่เจอ

---

### ขั้นตอนที่ 2: ติดตั้ง OpenClaw

มีหลายวิธี เลือกวิธีที่สะดวกครับ:

#### วิธีที่ 1: Installer Script (แนะนำ ⭐)

**macOS / Linux / WSL2:**
```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

**Windows (PowerShell):**
```powershell
iwr -useb https://openclaw.ai/install.ps1 | iex
```

#### วิธีที่ 2: npm

```bash
npm install -g openclaw@latest
```

#### วิธีที่ 3: pnpm

```bash
pnpm add -g openclaw@latest
pnpm approve-builds -g  # ← ต้องรันครั้งแรก
```

#### วิธีที่ 4: bun

```bash
bun add -g openclaw@latest
```

รอ 1-2 นาที... เสร็จแล้ว!



---

### ✅ ตรวจสอบว่าติดตั้งสำเร็จ

```bash
openclaw --version
```

**ถ้าขึ้นแบบนี้ = สำเร็จ!** ✅

```
OpenClaw 2026.x.x
```

---

### ขั้นตอนที่ 3: สร้าง Telegram Bot

ตอนนี้เรามี OpenClaw แล้ว — ต่อไปสร้าง "หน้าตา" สำหรับคุย!

#### 1. เปิด Telegram

- บนมือถือ: แอป Telegram
- บนคอม: https://web.telegram.org/

#### 2. ค้นหา BotFather

พิมพ์ในช่องค้นหา: `@BotFather`



#### 3. เริ่มแชท

คลิก **Start** หรือพิมพ์ `/start`

#### 4. สร้าง Bot ใหม่

พิมพ์: `/newbot`

BotFather จะถาม:

**1. ชื่อ Bot:** พิมพ์อะไรก็ได้ (เช่น `Mick AI`)  
**2. Username:** ต้องลงท้ายด้วย `bot` (เช่น `MickAssistantBot`)



#### 5. Copy Token

BotFather จะส่ง **API Token** มาให้ — **สำคัญมาก!**

```
Here is your token:
1234567890:ABCdefGHIjklMNOpqrsTUVwxyz

⚠️ คำเตือน:
- เก็บไว้เป็นความลับ!
- อย่าแชร์ให้ใคร!
- อย่า upload ขึ้น GitHub!
- อย่าโพสต์ในโซเชียล!
```

**ก็อปปี้เก็บไว้** (วางใน Notepad ก่อนก็ได้)

---

### 🔒 ความปลอดภัยของ Token

**Token คืออะไร?**

คิดเหมือน **รหัสผ่าน** ของ Bot คุณ — ใครมี Token = ควบคุม Bot ได้!

**สิ่งที่ต้องทำ:**
- ✅ เก็บในที่ปลอดภัย (password manager)
- ✅ ใช้ environment variable
- ✅ จำกัดสิทธิ์การเข้าถึง

**สิ่งที่ห้ามทำ:**
- ❌ อย่า commit ขึ้น Git/GitHub
- ❌ อย่าแชร์ในแชทสาธารณะ
- ❌ อย่าแปะในโค้ดที่ share
- ❌ อย่าส่งให้คนอื่น

**ถ้า Token รั่วไหล:**
1. ไปที่ BotFather ทันที
2. พิมพ์ `/revoke` เพื่อยกเลิก Token เก่า
3. สร้าง Bot ใหม่
4. อัพเดต Token ใน config

---

### ขั้นตอนที่ 4: ตั้งค่า OpenClaw

ตอนนี้มีทุกอย่างแล้ว — มาเชื่อมต่อกัน!

#### 1. สร้างโฟลเดอร์ทำงาน

```bash
mkdir ~/openclaw-workspace
cd ~/openclaw-workspace
```

#### 2. สร้างไฟล์ config

```bash
openclaw init
```

คำสั่งนี้จะสร้างไฟล์ config ให้โดยอัตโนมัติ

#### 3. ติดตั้ง Gateway Daemon

หลังติดตั้งเสร็จ ให้ติดตั้ง Gateway ให้รันอัตโนมัติ:

```bash
openclaw onboard --install-daemon
```

คำสั่งนี้จะ:
- สร้าง workspace ที่ `~/.openclaw/workspace`
- ติดตั้ง Gateway daemon (launchd/systemd)
- เปิด onboarding wizard

#### 4. แก้ไข config

เปิดไฟล์ `~/.openclaw/openclaw.json` แล้วเพิ่ม:

```json
{
  "telegram": {
    "botToken": "YOUR_BOT_TOKEN_HERE"
  }
}
```

**หรือใช้ Onboarding:**

```bash
openclaw onboard
```

Onboarding จะพาตั้งค่าทีละขั้นตอน!

⚠️ **คำเตือน:** อย่าแชร์ API Token ของคุณ!



#### 5. เริ่มใช้งาน

```bash
openclaw gateway status  # เช็คสถานะ
openclaw doctor          # เช็คปัญหา
```

ถ้า Gateway ยังไม่รัน:

```bash
openclaw gateway start
```

ถ้าขึ้นแบบนี้ = **สำเร็จ!** 🎉

```
✅ Gateway running
✅ Telegram connected
✅ Ready to chat!
```

---

### ขั้นตอนที่ 5: เริ่มแชท!

1. **เปิด Telegram**
2. **ค้นหา Bot** ที่เราสร้าง (เช่น `MickAssistantBot`)
3. **กด Start**
4. **พิมพ์:** "สวัสดี" หรือ "ช่วยแนะนำตัวหน่อย"



**ถ้า Bot ตอบ = เสร็จสมบูรณ์!** 🎉

---

## 🎯 แนะนำ 6 Providers + LLMs

### Provider คืออะไร?

คิดง่ายๆ คือ **"บริษัทที่ให้ใช้ AI"** ครับ

**OpenClaw** เป็นแค่ตัวกลาง — ต้องเชื่อมต่อกับ **AI จริงๆ** จาก provider

**เปรียบเทียบ:**
- **OpenClaw** = โทรศัพท์
- **Provider** = เครือข่าย (AIS, True, DTAC)
- **LLM** = คนคุยสาย另一端

---

### ทำไมต้องมี Provider?

เพราะ OpenClaw **ไม่สร้าง AI เอง** — แต่เชื่อมต่อกับ AI ที่มีอยู่แล้ว

**ข้อดี:**
- ✅ เลือกได้ว่าจะใช้ AI ตัวไหน
- ✅ จ่ายเฉพาะที่ใช้
- ✅ เปลี่ยนได้ตลอด

---

### 1. Bailian (Alibaba Cloud) 🇨🇳 — คุ้มค่าสุด! 💰

**LLM:** Qwen 3, Qwen 2.5 (72B), Qwen-Max

**ราคา:** ✅ **ฟรี 1,000,000 tokens/เดือน** (Qwen 2.5) [^1]  
**Qwen 3:** 💰 $0.0005-0.002 / 1K tokens [^1]  
**(ประมาณ 500-1,000 บทความ/เดือน)**

**จุดเด่น:**
- 🇹🇭 ภาษาไทยดีเยี่ยม
- 📄 Context 256K tokens
- 💰 คุ้มค่าสุดสำหรับใช้งานหนัก

**เหมาะสำหรับ:** ใช้งานทั่วไป, บล็อก, แชท, ใช้งานหนัก

**วิธีใช้:**
1. สมัคร: https://bailian.console.aliyun.com/
2. สร้าง API Key
3. ใส่ใน config OpenClaw

**ตัวอย่าง config (สมมติ):**

```yaml
providers:
  bailian:
    apiKey: "sk-xxxxxxxxxxxxxxxxxxxxxxxx"  # ← ใส่ Key ของคุณ
    # ⚠️ อย่าใช้ Key ตัวอย่างนี้!
```

**💰 ความคุ้มค่า:**  
ถ้าใช้ GPT-4o กับงานเดียวกัน → เสียเงิน ~$10-30/เดือน  
แต่ Qwen 2.5 → **ฟรี!** (ประหยัด ~300-1,000 บาท/เดือน)



---

### 2. Groq 🇺🇸 — เร็วสุด! ⚡

**LLM:** Llama 3.1 (405B), Llama 3.3 (70B), Mixtral 8x22B

**ราคา:** ✅ ฟรี (~100 requests/day) [^2]  
**Paid:** $0.05-$0.79 / 1M tokens [^2]

**จุดเด่น:**
- ⚡ เร็วที่สุด (500+ tokens/วินาที)
- 🆓 ฟรี tier เพียงพอสำหรับทดสอบ
- 🔓 Open-source models

**เหมาะสำหรับ:** ทดลอง, prototype, ใช้งานที่ต้องการความเร็ว

**วิธีใช้:**
1. สมัคร: https://console.groq.com/
2. สร้าง API Key
3. ใส่ใน config

⚠️ **สำคัญ:** อย่าแชร์ API Key ของคุณ!

**ข้อจำกัด:** ฟรีจำกัด/วัน (แต่พอใช้สำหรับทดสอบ)



---

### 3. Google 🇺🇸 — ใช้งานทั่วไป 🎯

**LLM:** Gemini 2.5 Pro, Gemini 2.0 Flash

**ราคา:** ✅ ฟรี 60 requests/นาที (Gemini 2.0 Flash) [^3]  
**Gemini 3 Pro:** 💰 $1.25/$10 / 1M tokens [^3]

**จุดเด่น:**
- 📚 Context 1M+ tokens (Gemini 3 Pro)
- 🔗 ผสานกับ Google services
- 🇹🇭 รองรับภาษาไทยดี

**เหมาะสำหรับ:** ทดลอง, ใช้งานทั่วไป

**วิธีใช้:**
1. สมัคร: https://aistudio.google.com/
2. สร้าง API Key
3. ใส่ใน config

🔒 **ความปลอดภัย:** เก็บ Key เป็นความลับ!



---

### 4. OpenAI 🇺🇸 — คุณภาพสูงสุด 👑

**LLM:** GPT-4.1, GPT-4o, o3-mini

**ราคา:** ❌ $0.002-0.015 / 1K tokens [^4]  
**GPT-4.1:** $2/$8 / 1M tokens [^4]  
**GPT-4o-mini:** $0.15/$0.60 / 1M tokens (ถูกสุด!) [^4]

**จุดเด่น:**
- 🧠 ฉลาดที่สุด
- 🛠️ ทำงานหลากหลาย
- 📚 เอกสารครบ

**เหมาะสำหรับ:** งานที่ต้องการความแม่นยำสูง, งานสำคัญ

**วิธีใช้:**
1. สมัคร: https://platform.openai.com/
2. เติมเงิน ($5 ขั้นต่ำ)
3. สร้าง API Key
4. ใส่ใน config

⚠️ **คำเตือน:** API Key OpenAI มีมูลค่า — ระวังการรั่วไหล!

**ราคาตัวอย่าง:**
- บทความ 1,000 คำ → ~$0.03-0.05 (~1-2 บาท)
- คุ้มค่าสำหรับงานสำคัญ!



---

### 5. Anthropic 🇺🇸 — เขียนบทความ ✍️

**LLM:** Claude Sonnet 4.6, Claude Opus 4.6

**ราคา:**
- **Claude Sonnet 4.6:** $3/$15 / 1M tokens (คุ้มค่าสุด!) [^5]
- **Claude Opus 4.6:** $15/$75 / 1M tokens (คุณภาพสูงสุด) [^5]

**จุดเด่น:**
- 📝 เขียนบทความธรรมชาติ
- 🧩 Tool calling ดีที่สุด
- 🔒 ปลอดภัย

**เหมาะสำหรับ:** เขียนคอนเทนต์, สรุปเอกสารยาว

**วิธีใช้:**
1. สมัคร: https://console.anthropic.com/
2. สร้าง API Key
3. ใส่ใน config

🔒 **สำคัญ:** อย่า commit API Key ขึ้น Git!

**ข้อดี:** ถูกกว่า GPT-4 แต่เขียนบทความดีกว่า!



---

### 6. Ollama 🏠 — Local/ส่วนตัว 🔒

**LLM:** Llama 3.1 (70B), Mistral Large, Gemma 2

**ราคา:** ✅ ฟรี 100%

**จุดเด่น:**
- 💻 **รันบนเครื่องตัวเอง**
- 🔒 **ไม่ต้องส่งข้อมูลออก**
- ∞ **ไม่จำกัด usage**

**เหมาะสำหรับ:** ข้อมูลลับ, ใช้งานหนัก, ส่วนตัว

**วิธีติดตั้ง:**

```bash
# 1. ติดตั้ง Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 2. ดาวน์โหลดโมเดล
ollama run llama3

# 3. เชื่อมต่อ OpenClaw
# เพิ่มใน config:
ollama:
  enabled: true
  model: llama3
```



**ข้อจำกัด:** ต้องมี RAM 8GB+ และ CPU แรงหน่อย

**จุดเด่น:**
- 💻 รันบนเครื่องตัวเอง
- 🔒 ไม่ต้องส่งข้อมูลออก
- ∞ ไม่จำกัด usage
- 💰 ฟรี 100%

---

## 📊 ตารางสรุป

| # | Provider | LLM | ราคา (ต่อ 1M tokens) | เหมาะกับ |
|---|----------|-----|---------------------|----------|
| 1 | **Bailian** 🇨🇳 | Qwen 2.5 | ✅ ฟรี 1M tokens/เดือน | **คุ้มค่าสุด** |
| 2 | **Groq** 🇺🇸 | Llama 3.3 | ✅ ฟรี (~100/day) | เร็วสุด ⚡ |
| 3 | **Google** 🇺🇸 | Gemini 3 Flash | $0.075/$0.30 | เร็ว/ประหยัด |
| 4 | **Google** 🇺🇸 | Gemini 3 Pro | $1.25/$10 | วิเคราะห์เอกสาร 📚 |
| 5 | **OpenAI** 🇺🇸 | GPT-4o-mini | $0.15/$0.60 | ถูกสุด 💰 |
| 6 | **OpenAI** 🇺🇸 | GPT-4.1 | $2/$8 | งานคุณภาพ |
| 7 | **Anthropic** 🇺🇸 | Claude Sonnet 4.6 | $3/$15 | **แนะนำ!** ⭐ |
| 8 | **Anthropic** 🇺🇸 | Claude Opus 4.6 | $15/$75 | คุณภาพสูงสุด 👑 |
| 9 | **Ollama** 🏠 | Llama 3.3 70B | ✅ ฟรี 100% | ส่วนตัว/Local 🔒 |

---

## 💡 คำแนะนำการเลือก

### 🎯 สำหรับมือใหม่:

```
🎯 เริ่มที่: Bailian Qwen 2.5 (ฟรี 1M tokens)
💰 งบจำกัด: GPT-4o-mini ($0.15/1M)
⚡ ต้องการความเร็ว: Groq (500+ tokens/วินาที)
⭐ คุ้มค่าสุด: Claude Sonnet 4.6 ($3/1M)
```

### 💼 สำหรับใช้งานจริง:

```
📝 เขียนบทความ: Claude Sonnet 4.6 ($3/$15)
💻 เขียนโค้ด: Claude Opus 4.6 ($15/$75)
📚 วิเคราะห์เอกสาร: Gemini 3 Pro ($1.25/$10)
🔒 ข้อมูลลับ: Ollama (Local, ฟรี)
⚡ งานเร็ว: Gemini 3 Flash ($0.075/$0.30)
```

### 💰 สำหรับประหยัด:

```
✅ ฟรี 100%: Ollama (Local)
✅ ฟรี quota: Bailian (1M tokens/เดือน)
✅ ถูกสุด: GPT-4o-mini ($0.15/$0.60)
✅ คุ้มค่า: Claude Sonnet 4.6 ($3/$15)
✅ เร็ว/ถูก: Gemini 3 Flash ($0.075/$0.30)
```

---

## 💰 เปรียบเทียบราคา (2026)

### ถูกสุด → แพงสุด:

| อันดับ | Model | ราคา Input/Output | ต่อเดือน* |
|--------|-------|------------------|-----------|
| 🥇 | **Ollama (Local)** | ฟรี | ฟรี |
| 🥈 | **Bailian Qwen 2.5** | ฟรี 1M tokens | ฟรี |
| 🥉 | **GPT-4o-mini** | $0.15/$0.60 | ~$3-10 |
| 4 | **Gemini 3 Flash** | $0.075/$0.30 | ~$5-15 |
| 5 | **Claude Sonnet 4.6** | $3/$15 | ~$30-100 |
| 6 | **Gemini 3 Pro** | $1.25/$10 | ~$50-150 |
| 7 | **Claude Opus 4.6** | $15/$75 | ~$150-500 |

\* ประมาณการสำหรับใช้งานทั่วไป (10-50 บทความ/เดือน)

### สรุป:

```
💰 งบจำกัด:
   → Bailian Qwen 2.5 (ฟรี 1M tokens)
   → GPT-4o-mini ($0.15/1M)

⭐ คุ้มค่าสุด:
   → Claude Sonnet 4.6 ($3/$15)

👑 คุณภาพสูงสุด:
   → Claude Opus 4.6 ($15/$75)

🔒 ส่วนตัว:
   → Ollama (Local, ฟรี)
```

---

## 🧪 ทดสอบใช้งาน

### เช็คการติดตั้ง:

```bash
openclaw --version      # เช็ค CLI
openclaw doctor         # เช็คปัญหา
openclaw gateway status # เช็ค Gateway
```

### คำสั่งแรกที่ควรลอง:

```
"สวัสดี"
"ช่วยแนะนำตัวหน่อย"
"มีอะไรทำได้บ้าง"
```

### คำสั่งที่ใช้บ่อย:

```
"ค้นหาข้อมูลเรื่อง..."
"เขียนบทความเกี่ยวกับ..."
"ช่วยสรุปเอกสารนี้..."
"เตือนฉันเรื่อง... เวลา..."
"หาไฟล์ชื่อ..."
```

---

## 🔒 ความปลอดภัย — สิ่งที่ต้องรู้

### API Keys และ Tokens

**สิ่งที่ต้องจำ:**

> 🚨 **API Keys และ Tokens คือรหัสผ่าน!**
>
> - อย่าแชร์ให้ใคร
> - อย่า upload ขึ้น GitHub
> - อย่าโพสต์ในโซเชียล
> - อย่าส่งในแชทสาธารณะ

**วิธีเก็บที่ปลอดภัย:**

1. **ใช้ Environment Variables** (แนะนำ):
```bash
export OPENCLAW_TELEGRAM_TOKEN="your-token-here"
export BAILIAN_API_KEY="your-key-here"
```

2. **ใช้ Password Manager**:
- 1Password
- Bitwarden (ฟรี)
- KeePass

3. **ไฟล์แยกต่างหาก** (ไม่ commit):
```yaml
# config-secret.yaml (อย่า commit!)
telegram:
  botToken: "your-token"
```

**ถ้า Key รั่วไหล:**

1. ยกเลิก Key ทันที (revoke)
2. สร้าง Key ใหม่
3. อัพเดต config
4. ตรวจสอบการใช้งานผิดปกติ

### ตัวอย่างการใช้งานจริง:

```
คุณ: "มิก ช่วยค้นหาข้อมูลเรื่อง AI ล่าสุดให้หน่อย"
มิก: [web_search]
มิก: "เจอข่าวล่าสุดเมื่อวานนี้: OpenAI เปิดตัว GPT-5..."

คุณ: "มิก เขียนบทความเรื่อง AI สำหรับมือใหม่"
มิก: [เขียนบทความ]
มิก: "เขียนเสร็จครับ! ความยาว 1,500 คำ อยากแก้ตรงไหนบอกได้เลย"

คุณ: "มิก เตือนฉันประชุมพรุ่งนี้ 10 โมง"
มิก: [สร้าง reminder]
มิก: "ตั้งเตือนแล้วครับ! จะเตือนพรุ่งนี้ 09:30"
```

---

## ❓ Troubleshooting

### ปัญหา: Bot ไม่ตอบ

**วิธีแก้:**
1. เช็ค Token ถูกต้องไหม
2. เช็ค Gateway รันอยู่ไหม: `openclaw gateway status`
3. Restart: `openclaw gateway restart`

### ปัญหา: ติดตั้ง Node.js ไม่ได้

**วิธีแก้:**
1. ใช้ installer script (แนะนำ)
2. ดาวน์โหลดจาก https://nodejs.org/
3. ใช้ Node 24 (แนะนำ) หรือ 22.14+

### ปัญหา: `openclaw` not found

**วิธีแก้:**
```bash
# เช็ค Node ติดตั้งไหม
node -v

# เช็ค global packages
npm prefix -g

# เช็ค PATH
echo "$PATH"

# ถ้า $(npm prefix -g)/bin ไม่มีใน PATH
export PATH="$(npm prefix -g)/bin:$PATH"
```

เพิ่มใน `~/.zshrc` หรือ `~/.bashrc`:

```bash
export PATH="$(npm prefix -g)/bin:$PATH"
```

### ปัญหา: sharp build errors (npm)

**วิธีแก้:**
```bash
SHARP_IGNORE_GLOBAL_LIBVIPS=1 npm install -g openclaw@latest
```

---

## 🎉 สรุป

### สิ่งที่ทำเสร็จวันนี้:

1. ✅ รู้ว่า OpenClaw คืออะไร
2. ✅ ติดตั้ง Node.js
3. ✅ ติดตั้ง OpenClaw
4. ✅ สร้าง Telegram Bot
5. ✅ ตั้งค่า config
6. ✅ รู้จัก 6 Providers + LLMs

### ขั้นตอนต่อไป:

1. **เลือก Provider** → แนะนำ Bailian (ฟรี)
2. **สมัคร + สร้าง API Key**
3. **ใส่ใน config**
4. **เริ่มใช้งาน!**

---

## 🚀 พร้อมเริ่มต้นหรือยัง?

### ลองติดตั้งดูครับ!

#### 1. ติดตั้ง OpenClaw (วิธีแนะนำ):

**macOS / Linux / WSL2:**
```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

**Windows (PowerShell):**
```powershell
iwr -useb https://openclaw.ai/install.ps1 | iex
```

#### 2. ติดตั้ง Gateway Daemon:

```bash
openclaw onboard --install-daemon
```

#### 3. สร้าง Bot:

@BotFather บน Telegram

#### 4. เลือก Provider:

แนะนำ Bailian (ฟรี 1M tokens) หรือ Claude Sonnet 4.6 (คุ้มค่า)

#### 5. เริ่มคุย:

```
"มิก ช่วยแนะนำตัวหน่อย"
```

---

### 📚 เรียนรู้เพิ่มเติม:

| แหล่ง | ลิงก์ |
|------|-------|
| **Documentation** | https://docs.openclaw.ai |
| **Installation Guide** | https://docs.openclaw.ai/install |
| **Discord Community** | https://discord.gg/clawd |
| **GitHub** | https://github.com/openclaw/openclaw |
| **Skill Hub** | https://clawhub.ai |
| **Bailian Console** | https://bailian.console.aliyun.com/ |
| **Groq Console** | https://console.groq.com/ |

---

## 💬 มีคำถาม?

ถ้าติดตรงไหน หรืออยากได้ความช่วยเหลือ:

- **ถาม Mick** ได้เลย (ถ้าติดตั้งแล้ว)
- **เข้า Discord Community**
- **อ่าน Documentation**

---

**สุดท้ายนี้...**

เทคโนโลยีมีไว้เพื่อทำให้ชีวิตง่ายขึ้น ไม่ใช่ทำให้ซับซ้อนขึ้น

**OpenClaw** ไม่ใช่แค่ tool — แต่เป็น **ผู้ช่วยส่วนตัว** ที่ช่วยคุณทำงานซ้ำๆ เพื่อให้คุณมีเวลาไปทำสิ่งที่สำคัญจริงๆ

แล้วคุณล่ะ? พร้อมหรือยังที่จะมี AI Assistant ส่วนตัว? 🚀

---

_บทความโดย เหน่ง (Nueng)_  
_Community Development Officer (นักวิชาการพัฒนาชุมชน)_  
_Community Development Department, Ministry of Interior (กรมการพัฒนาชุมชน กระทรวงมหาดไทย)_

_อัพเดทล่าสุด: 2026-04-06_

---

## 📚 อ้างอิง

[^1]: **Bailian (Alibaba Cloud)** — [阿里云百炼模型价格](https://help.aliyun.com/zh/model-studio/model-pricing), [Qwen API Pricing 2026](https://pricepertoken.com/pricing-page/provider/qwen)

[^2]: **Groq** — [Groq Pricing](https://groq.com/pricing), [Groq API Pricing 2026](https://apicents.com/provider/groq), [Groq Free Tier Limits](https://www.grizzlypeaksoftware.com/articles/p/groq-api-free-tier-limits-in-2026-what-you-actually-get-uwysd6mb)

[^3]: **Google** — [Google AI Studio Pricing](https://aistudio.google.com/pricing), [Gemini Models 2026](https://haimaker.ai/blog/gemini-3-flash-preview-openclaw)

[^4]: **OpenAI** — [OpenAI API Pricing](https://openai.com/api/pricing/), [GPT-4.1 Pricing 2026](https://langcopilot.com/llm-pricing/openai/gpt-4.1), [Best Models for OpenClaw](https://haimaker.ai/blog/best-models-for-clawdbot/)

[^5]: **Anthropic** — [Anthropic Console](https://console.anthropic.com/), [Best Models for OpenClaw 2026](https://haimaker.ai/blog/best-models-for-clawdbot/)

[^6]: **Ollama** — [Ollama Official Site](https://ollama.com/), [Local Models Guide](https://haimaker.ai/blog/best-local-models-for-openclaw)

**หมายเหตุ:** ราคาอาจมีการเปลี่ยนแปลง — ตรวจสอบกับผู้ให้บริการก่อนใช้งานจริง
