---
title: "เริ่มต้นติดตั้งและใช้งาน Hermes Agent: ผู้ช่วย AI บนเครื่องของคุณ"
date: 2026-04-17T10:00:00+07:00
lastUpdated: 2026-04-17
description: "คู่มือติดตั้งและใช้งาน Hermes Agent จากศูนย์ ตั้งค่า AI Provider เชื่อมต่อ Telegram และสั่งงานผู้ช่วย AI บนเครื่องตัวเอง"
keywords: [hermes, ai-agent, tutorial, open-source, telegram]
author: "เหน่ง (Nueng)"
tags: ['hermes', 'ai-agent', 'tutorial', 'open-source']
categories: ['AI', 'Tutorial']
image: "cover.jpg"
draft: false
---

# เริ่มต้นติดตั้งและใช้งาน Hermes Agent: ผู้ช่วย AI บนเครื่องของคุณ

ถ้าคุณเคยใช้ ChatGPT หรือ Claude ผ่านเว็บไซต์ แล้วรู้สึกว่ามันเป็น "ของเล่น" ที่ไม่ได้เชื่อมต่อกับงานจริงของคุณ Hermes Agent อาจเป็นคำตอบที่คุณกำลังมองหาอยู่

Hermes ไม่ใช่แค่ chatbot ธรรมดา แต่เป็น **ผู้ช่วย AI แบบ CLI** ที่ทำงานบนเครื่องคุณเอง สามารถรันคำสั่งใน terminal อ่านไฟล์ เขียนโค้ด ค้นหาข้อมูลบนเว็บ และเชื่อมต่อกับ Telegram หรือ Discord ได้ — ทั้งหมดนี้เป็น open-source จาก Nous Research

ในบทความนี้ ผมจะพาคุณติดตั้ง Hermes ตั้งแต่ศูนย์ จนสามารถใช้งานได้จริง

---

## สารบัญ

- [Hermes คืออะไร](#hermes-คืออะไร)
- [สิ่งที่ต้องเตรียมก่อนติดตั้ง](#สิ่งที่ต้องเตรียมก่อนติดตั้ง)
- [วิธีติดตั้ง Hermes](#วิธีติดตั้ง-hermes)
- [ตั้งค่าครั้งแรก](#ตั้งค่าครั้งแรก)
- [เชื่อมต่อกับ AI Provider](#เชื่อมต่อกับ-ai-provider)
- [เชื่อมต่อ Telegram](#เชื่อมต่อ-telegram)
- [คำสั่งที่ใช้บ่อย](#คำสั่งที่ใช้บ่อย)
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

ที่สำคัญคือ **คุณควบคุม model เองได้** ไม่ว่าจะเป็น OpenRouter, Kimi, Bailian (Qwen), OpenAI, หรือแม้แต่โมเดลที่รันบนเครื่องตัวเองผ่าน llama.cpp

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

นี่จะเปิดใช้งานเครื่องมือทั้งหมดของ Hermes รวมถึง terminal, file operations, web search, browser automation, vision, cron jobs, และอื่นๆ

---

## เชื่อมต่อกับ AI Provider

Hermes รองรับหลาย provider มาก ต่อไปนี้เป็นตัวอย่างการตั้งค่ายอดนิยม:

### OpenRouter (แนะนำสำหรับผู้เริ่มต้น)
OpenRouter เป็น aggregator ที่ให้คุณใช้งานหลายโมเดลได้จากจุดเดียว

```yaml
model:
  default: anthropic/claude-sonnet-4
  provider: openrouter
```

### Kimi (ฟรีสำหรับ coding)
Kimi K2.5 เป็นโมเดลที่เน้นการเขียนโค้ดและทำงานเทคนิค

```yaml
model:
  default: kimi-k2.5
  provider: kimi-coding
```

### Bailian / Qwen (ฟรี)
สำหรับผู้ที่มีบัญชี Alibaba Cloud Bailian (DashScope):

```yaml
custom_providers:
  - name: bailian
    base_url: https://coding-intl.dashscope.aliyuncs.com/v1
    api_key: sk-xxx
```

ต่อไปเราจะมาดูวิธีเชื่อมต่อ Hermes เข้ากับ Telegram เพื่อให้คุณสามารถคุยกับ AI ผู้ช่วยได้จากโทรศัพท์มือถือ

