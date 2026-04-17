---
title: "เริ่มต้นติดตั้งและใช้งาน Hermes Agent: ผู้ช่วย AI บนเครื่องของคุณ"
date: 2026-04-17T10:00:00+07:00
lastmod: 2026-04-18T10:00:00+07:00
description: "คู่มือติดตั้งและใช้งาน Hermes Agent จากศูนย์ ตั้งค่า AI Provider เชื่อมต่อ Telegram และสั่งงานผู้ช่วย AI บนเครื่องตัวเอง"
author: "เหน่ง (Nueng)"
tags: ['hermes', 'ai-agent', 'tutorial', 'open-source']
categories: ['AI', 'Tutorial']
image: "cover.jpg"
draft: false
---

# เริ่มต้นติดตั้งและใช้งาน Hermes Agent: ผู้ช่วย AI บนเครื่องของคุณ

ถ้าคุณเคยใช้ ChatGPT หรือ Claude ผ่านเว็บไซต์ แล้วรู้สึกว่ามันเป็น "ของเล่น" ที่ไม่ได้เชื่อมต่อกับงานจริง

ผมก็เคยเจอ และพบว่า Hermes Agent คือคำตอบที่ดีกว่า เพราะมันไม่ใช่แค่ chatbot ธรรมดา แต่เป็น **ผู้ช่วย AI แบบ CLI** ที่ทำงานบนเครื่องคุณเอง สามารถรันคำสั่งใน terminal อ่านไฟล์ เขียนโค้ด ค้นหาข้อมูลบนเว็บ และเชื่อมต่อกับ Telegram หรือ Discord ได้ — ทั้งหมดนี้เป็น open-source จาก Nous Research

วิธีติดตั้งและใช้งาน Hermes มี 6 ขั้นตอนหลัก

ก่อนเริ่ม ต้องมีเครื่องที่ติดตั้ง Python 3.11+, uv, และ Git ไว้แล้ว
บทความนี้จะพาคุณทำทีละขั้นตอน ตั้งแต่ติดตั้ง ตั้งค่า provider เชื่อมต่อ Telegram และใช้คำสั่งที่ใช้บ่อย

พร้อมแล้วไปเริ่มกันเลยครับ!

---

## สารบัญ

- [Hermes คืออะไร](#hermes-คืออะไร)
- [สิ่งที่ต้องเตรียมก่อนติดตั้ง](#สิ่งที่ต้องเตรียมก่อนติดตั้ง)
- [วิธีติดตั้ง Hermes](#วิธีติดตั้ง-hermes)
- [ตั้งค่าครั้งแรก](#ตั้งค่าครั้งแรก)
- [เชื่อมต่อกับ AI Provider](#เชื่อมต่อกับ-ai-provider)
- [เชื่อมต่อ Telegram](#เชื่อมต่อ-telegram)
- [คำสั่งที่ใช้บ่อย](#คำสั่งที่ใช้บ่อย)
- [ทำไมต้องใช้ Hermes](#ทำไมต้องใช้-hermes)
- [บทสรุป](#บทสรุป)

---

## Hermes คืออะไร

Hermes Agent เป็นโปรแกรมผู้ช่วย AI ที่รันผ่าน command line บนเครื่องคอมพิวเตอร์ของคุณเอง ต่างจาก ChatGPT ที่ต้องพิมพ์คำสั่งทีละขั้นตอน Hermes สามารถ:

- รันคำสั่ง terminal แทนคุณ
- อ่านและแก้ไขไฟล์ในเครื่อง
- ค้นหาข้อมูลบนอินเทอร์เน็ต
- เขียนโค้ด Python หรือสคริปต์อื่นๆ
- เชื่อมต่อกับ Telegram, Discord, WhatsApp
- ตั้งเวลาทำงานอัตโนมัติ (cron jobs)
- เรียนรู้และจดจำข้อมูลระหว่างเซสชั่น

ที่สำคัญคือ **คุณควบคุม model เองได้** ไม่ว่าจะเป็น OpenRouter, Kimi, Bailian (Qwen), OpenAI หรือแม้แต่โมเดลที่รันบนเครื่องตัวเองผ่าน llama.cpp

---

## สิ่งที่ต้องเตรียมก่อนติดตั้ง

ก่อนติดตั้ง Hermes ตรวจสอบให้แน่ใจว่าเครื่องของคุณมีสิ่งต่อไปนี้:

### ระบบปฏิบัติการ
- Linux (แนะนำ Ubuntu 22.04+)
- macOS (Intel หรือ Apple Silicon)
- Windows ใช้ได้ผ่าน WSL2

### ซอฟต์แวร์ที่จำเป็น
- **Python 3.11+** — Hermes เขียนด้วย Python
- **uv** — package manager ที่เร็วกว่า pip
- **Git** — สำหรับ clone repository

ตรวจสอบเวอร์ชัน Python ได้ด้วยคำสั่ง:
```bash
python3 --version
```

ถ้ายังไม่มี `uv` ติดตั้งได้ด้วยคำสั่ง:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

---

## วิธีติดตั้ง Hermes

มี 2 วิธีหลักในการติดตั้ง Hermes: ติดตั้งผ่านสคริปต์ (ง่ายที่สุด) หรือติดตั้งด้วยตนเอง (สำหรับผู้ที่ต้องการปรับแต่ง)

### วิธีที่ 1: ติดตั้งผ่านสคริปต์ (แนะนำ)

เปิด terminal และรันคำสั่งนี้:

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

สคริปต์จะทำให้ทั้งหมดต่อไปนี้โดยอัตโนมัติ:
1. โคลน repository ของ Hermes
2. ติดตั้ง `uv` ถ้ายังไม่มี
3. สร้าง virtual environment
4. ติดตั้ง dependencies ทั้งหมด
5. ลงคำสั่ง `hermes` ให้ใช้ได้ทั่วระบบ

### วิธีที่ 2: ติดตั้งด้วยตนเอง

ถ้าคุณต้องการควบคุมทุกขั้นตอน ทำตามนี้:

```bash
# 1. โคลน repository
git clone https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# 2. สร้าง virtual environment ด้วย uv
uv venv
source .venv/bin/activate

# 3. ติดตั้ง dependencies
uv pip install -e ".[all]"

# 4. ลงคำสั่ง hermes
uv pip install -e .
```

หลังติดตั้งเสร็จ ลองตรวจสอบด้วยคำสั่ง:
```bash
hermes --version
```

ถ้าแสดงเวอร์ชันออกมา แสดงว่าติดตั้งสำเร็จแล้ว

---

## ตั้งค่าครั้งแรก

หลังติดตั้งเสร็จ Hermes จะสร้างไฟล์ตั้งค่าที่ `~/.hermes/config.yaml` คุณสามารถแก้ไขไฟล์นี้โดยตรง หรือใช้คำสั่ง CLI ก็ได้

### คำสั่งตั้งค่าพื้นฐาน

```bash
# ตั้งค่า AI Provider
hermes config set model.default gpt-4o
hermes config set model.provider openrouter

# ตั้งค่า API Key
hermes config set OPENROUTER_API_KEY "your-key-here"

# ตั้งค่าบุคลิก
hermes config set display.personality helpful

# ตั้งค่าจำนวน turn สูงสุด
hermes config set agent.max_turns 100
```

### เปิดใช้งาน toolsets ทั้งหมด

```bash
hermes tools --set all
```

นี่จะเปิดใช้งานเครื่องมือทั้งหมดของ Hermes รวมถึง terminal, file operations, web search, browser automation, vision, cron jobs และอื่นๆ

---

## เชื่อมต่อกับ AI Provider

Hermes รองรับหลาย provider มาก ต่อไปนี้เป็นตัวอย่างการตั้งค่ายอดนิยม:

### OpenRouter (แนะนำสำหรับผู้เริ่มต้น)
OpenRouter เป็น aggregator ที่ให้คุณใช้งานหลายโมเดลได้จากจุดเดียว สมัครง่าย และมีโมเดลฟรีให้ใช้โดยไม่ต้องมีบัตรเครดิต

```yaml
model:
  default: anthropic/claude-sonnet-4
  provider: openrouter
```

**โมเดลฟรีบน OpenRouter (ไม่ต้องเติมเงิน)**
OpenRouter มีโมเดลฟรีให้ใช้กว่า 20 ตัว จำกัดที่ 20 requests/นาที และ 200 requests/วัน แนะนำสำหรับผู้เริ่มต้นที่อยากลองใช้งานไม่เสียค่าใช้จ่าย:

| โมเดล | จุดเด่น | Context |
|--------|---------|---------|
| `qwen/qwen3-coder:free` | เขียนโค้ดแม่น แจกฟรี | 262K |
| `google/gemma-3-27b-it:free` | อเนกประสงค์ รองรับรูปภาพ | 131K |
| `meta-llama/llama-3.3-70b-instruct:free` | แชททั่วไป ใช้งานลื่น | 66K |
| `google/gemma-4-26b-a4b-it:free` | Context ยาวถึง 1 ล้าน token | 1M |
| `openrouter/free` | สุ่มโมเดลฟรีอัตโนมัติ (ไม่ต้องเลือก) | 200K |

ตัวอย่างการตั้งค่าใช้โมเดลฟรี:
```yaml
model:
  default: qwen/qwen3-coder:free
  provider: openrouter
```

> 💡 **Tip:** โมเดลฟรีเหมาะกับการทดลองใช้งาน ถ้าใช้จริงจังแนะนำเติม Credits เพื่อความเสถียร

### Kimi (ฟรีสำหรับ coding)
Kimi K2.5 เป็นโมเดลที่เน้นการเขียนโค้ดและทำงานเทคนิค

```yaml
model:
  default: kimi-k2.5
  provider: kimi-coding
```

### Bailian / Qwen (แบบจ่ายรายเดือน)
สำหรับผู้ที่มีบัญชี Alibaba Cloud Bailian (DashScope) — ปัจจุบันเป็น **บริการแบบสมัครสมาชิกรายเดือน** ไม่ฟรีแล้ว แต่คุ้มค่าสำหรับงานเขียนโค้ดและภาษาไทย

```yaml
custom_providers:
  - name: bailian
    base_url: https://coding-intl.dashscope.aliyuncs.com/v1
    api_key: sk-xxx
```

### รันโมเดลบนเครื่องตัวเอง (Local Models)
ถ้ามีการ์ดจอหรือต้องการความเป็นส่วนตัวสูงสุด สามารถรันโมเดลบนเครื่องตัวเองผ่าน **Ollama** ได้ Hermes จะตรวจจับโมเดลที่ดาวน์โหลดผ่าน Ollama อัตโนมัติ

**ขั้นตอน:**
1. ติดตั้ง Ollama: [ollama.com](https://ollama.com)
2. ดาวน์โหลดโมเดล เช่น:
   ```bash
   ollama pull gemma4        # ~16 GB VRAM
   ollama pull qwen3.5       # ~11 GB VRAM
   ```
3. ตั้งค่า Hermes ให้ชี้ไปที่ Ollama:
   ```yaml
   custom_providers:
     - name: ollama
       base_url: http://127.0.0.1:11434/v1
       api_key: ""  # ไม่ต้องใส่
   ```
4. Hermes จะ auto-detect โมเดลที่มีให้เลือกใช้ทันที

> 💡 **ข้อดีของ Local:** ไม่ต้องกังวลเรื่องค่าใช้จ่ายรายเดือน ไม่ส่งข้อมูลออกจากเครื่อง และไม่มี rate limit  
> **ข้อควรระวัง:** ต้องใช้เครื่องที่มีสเปคสูงพอสมควร (RAM/VRAM มากๆ) ถึงจะรันโมเดลใหญ่ได้ลื่น

ต่อไปเราจะมาดูวิธีเชื่อมต่อ Hermes เข้ากับ Telegram เพื่อให้คุณสามารถคุยกับ AI ผู้ช่วยได้จากโทรศัพท์มือถือ

---

## เชื่อมต่อ Telegram

ฟีเจอร์ที่ผมชอบมากที่สุดของ Hermes คือ คุณสามารถคุยกับ AI ผู้ช่วยผ่าน Telegram ได้ ไม่ว่าคุณจะอยู่หน้าคอมหรือนอกบ้าน

### ขั้นตอนการเชื่อมต่อ

1. สร้าง Bot ใน Telegram ผ่าน @BotFather
2. ได้รับ API Token
3. รันคำสั่งตั้งค่าใน Hermes:

```bash
hermes config set telegram.bot_token "YOUR_BOT_TOKEN"
hermes gateway setup telegram
```

### ข้อดีสำคัญ WhatsApp

Hermes รองรับ WhatsApp ด้วย แต่ต้องเชื่อมต่อผ่านโทรศัพท์จริงๆ เพื่อให้ QR Code แสดงได้อย่างถูกต้อง

```bash
hermes whatsapp
```

---

## คำสั่งที่ใช้บ่อย

นี่คือคำสั่งพื้นฐานที่ผมใช้ทุกวัน:

### คำสั่งทั่วไป

```bash
# เริ่มสนทนากับ Hermes
hermes

# สั่งงานให้ Hermes ทำ
hermes do "อะไรก็ได้"

# สั่งงานแบบไม่ต้องยืนยัน
hermes do --no-confirm "อะไรก็ได้"

# สร้าง skill ใหม่
hermes skill create "ชื่อ skill"
```

### การจัดการกับไฟล์

```bash
# อ่านไฟล์
hermes file read /path/to/file

# แก้ไขไฟล์
hermes file patch /path/to/file "old text" "new text"

# ค้นหาในไฟล์
hermes search "pattern" /path/to/dir
```

### การค้นหาข้อมูล

```bash
# ค้นหาบนเว็บ
hermes web search "หัวข้อ"

# ดึงข้อมูลจาก URL
hermes web extract https://example.com
```

### การจัดการ cron jobs

```bash
# สร้าง cron job
hermes cron create --name "morning-check" --schedule "0 9 * * *" --prompt "ตรวจสอบราคาทองวันนี้"

# ดูรายการ cron jobs
hermes cron list

# ลบ cron job
hermes cron remove <job_id>
```

### การใช้ browser automation

```bash
# เปิดหน้าเว็บ
hermes browser goto https://example.com

# ดึงข้อมูลปัจจุบัน
hermes browser snapshot
```

---

## ทำไมต้องใช้ Hermes?

หลังใช้งาน Hermes มาหลายเดือน ผมพบว่ามันช่วยลดเวลาทำงานได้มาก เช่น:

- อ่านและวิเคราะห์เอกสารยาวๆ โดยไม่ต้องไล่หัวข้อเอง
- สร้างบทความบน Hugo blog พร้อม build และ deploy
- เขียนโค้ด Python และ debug ครั้งแรก
- ค้นหาข้อมูลทางวิชาการ และสรุปง่ายๆ
- ตั้งเวลาทำงานอัตโนมัติ เช่น แจ้งเตือนราคาทองทุกเช้า

ข้อดีของ Hermes คือ **ทุกอย่างทำบนเครื่องคุณเอง** และมี **หน่วยความจำทำงานที่ดี** หมายความว่า คุณสามารถควบคุมงาน ไฟล์ และการเชื่อมต่อได้หมด โดยไม่ต้องอัปโหลดข้อมูลให้เว็บไซต์ทุกครั้ง

---

## บทสรุป

สรุปแล้ว วิธีติดตั้งและใช้งาน Hermes Agent มีขั้นตอนคือ:

1. เตรียมเครื่องด้วย Python 3.11+, uv และ Git
2. ติดตั้ง Hermes ผ่านสคริปต์หรือด้วยตนเอง
3. ตั้งค่า AI Provider และเปิดใช้งาน toolsets
4. เชื่อมต่อ Telegram (หรือ WhatsApp) สำหรับการใช้งานบนมือถือ
5. ใช้คำสั่งพื้นฐาน เช่น `hermes do`, `hermes file`, `hermes web`
6. ตั้งเวลาทำงานอัตโนมัติด้วย cron jobs

ลองนำไปใช้ดูครับ ถ้าติดปัญหาตรงไหน คอมเมนต์ถามได้เลยครับ!

---

## 📚 อ้างอิง

### แหล่งหลัก:
**Hermes Agent โดย Nous Research**
- GitHub: https://github.com/NousResearch/hermes-agent
- เอกสารระบบ: https://hermes-agent.nousresearch.com/docs/

### แหล่งเสริม:
1. Reddit - Complete Hermes Agent Setup Guide: https://www.reddit.com/r/hermesagent/comments/1rt5syt/complete_hermes_agent_setup_guide/
2. nxcode.io - Hermes Agent Tutorial 2026: https://www.nxcode.io/resources/news/hermes-agent-tutorial-install-setup-first-agent-2026
3. YouTube - Full Hermes Setup Tutorial: https://www.youtube.com/watch?v=uycgV-eulGE
4. GitHub - Hermes Optimization Guide: https://github.com/OnlyTerp/hermes-optimization-guide
5. Model Context Protocol: https://modelcontextprotocol.io/
6. Alibaba Cloud Model Studio: https://www.alibabacloud.com/help/en/model-studio/models
7. OpenRouter - AI Model Aggregator: https://openrouter.ai/
8. Kimi AI (Moonshot): https://kimi.com/
9. uv - Python Package Manager: https://docs.astral.sh/uv/
10. Telegram Bot API: https://core.telegram.org/bots/api
