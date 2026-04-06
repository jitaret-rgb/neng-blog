+++
title = 'OpenClaw v2026.4.5: อัพเดทใหญ่! เพิ่ม Video, Music Generation + 10+ ฟีเจอร์ใหม่'
date = 2026-04-06T23:00:00+07:00
draft = false
tags = ['openclaw', 'release', 'update', 'ai', 'video-generation', 'music-generation']
categories = ['News', 'OpenClaw', 'AI']
image = 'cover.jpg'
description = 'สรุปฟีเจอร์ใหม่ OpenClaw v2026.4.5: Video Generation, Music Generation, ComfyUI, 12+ Providers ใหม่ และอื่นๆ อีกมากมาย'
+++

# 🚀 OpenClaw v2026.4.5: อัพเดทใหญ่!

**เผยแพร่:** 6 เมษายน 2569 (2026-04-06)  
**เวอร์ชั่น:** v2026.4.5  
**GitHub:** https://github.com/openclaw/openclaw/releases/tag/v2026.4.5

---

## 🎉 **ฟีเจอร์ใหม่ที่น่าสนใจ:**

### **1. 🎬 Video Generation**

**新增:** Agent สามารถสร้างวิดีโอได้แล้ว!

**วิธีใช้:**
```python
# Agent สามารถใช้ tool: video_generate
# สร้างวิดีโอผ่าน configured providers
# ส่งคืนวิดีโอใน reply โดยตรง
```

**Providers ที่รองรับ:**
- ComfyUI (local + cloud)
- และอื่นๆ

---

### **2. 🎵 Music Generation**

**新增:** Agent สามารถสร้างเพลง/เสียงได้แล้ว!

**วิธีใช้:**
```python
# Agent สามารถใช้ tool: music_generate
# รองรับ Google Lyria, MiniMax
# Async task tracking
# Follow-up delivery
```

**Providers:**
- Google Lyria
- MiniMax
- ComfyUI (workflow-backed)

---

### **3. 🎨 ComfyUI Integration**

**新增:** Bundled Comfy workflow media plugin!

**ฟีเจอร์:**
- Image generation
- Video generation
- Music generation (workflow-backed)
- Prompt injection
- Optional reference-image upload
- Live tests
- Output download

---

### **4. 🌐 Providers ใหม่ (6+ ตัว)**

| Provider | ประเภท | ฟีเจอร์ |
|----------|--------|---------|
| **Qwen** | Chat | ✅ รองรับแล้ว |
| **Fireworks AI** | Chat | ✅ รองรับแล้ว |
| **StepFun** | Chat | ✅ รองรับแล้ว |
| **MiniMax TTS** | Speech | ✅ รองรับแล้ว |
| **Ollama Web Search** | Search | ✅ รองรับแล้ว |
| **MiniMax Search** | Search | ✅ รองรับแล้ว |

---

### **5. 🛏️ Amazon Bedrock Updates**

**新增:**
- Bundled Mantle support
- Inference-profile discovery
- Automatic request-region injection

**Models ที่รองรับ:**
- Claude
- GPT-OSS
- Qwen
- Kimi
- GLM
- และอื่นๆ

---

### **6. 🌍 Control UI Multilingual**

**เพิ่ม 12 ภาษา:**

| ภาษา | สถานะ |
|------|-------|
| 🇨🇳 จีนตัวย่อ | ✅ แล้ว |
| 🇹🇼 จีนตัวเต็ม | ✅ แล้ว |
| 🇧🇷 โปรตุเกส (บราซิล) | ✅ แล้ว |
| 🇩🇪 เยอรมัน | ✅ แล้ว |
| 🇪🇸 สเปน | ✅ แล้ว |
| 🇯🇵 ญี่ปุ่น | ✅ แล้ว |
| 🇰🇷 เกาหลี | ✅ แล้ว |
| 🇫🇷 ฝรั่งเศส | ✅ แล้ว |
| 🇹🇷 ตุรกี | ✅ แล้ว |
| 🇮🇩 อินโดนีเซีย | ✅ แล้ว |
| 🇵🇱 โปแลนด์ | ✅ แล้ว |
| 🇺🇦 ยูเครน | ✅ แล้ว |

**ภาษาไทย:** ⏳ รออัพเดทในเวอร์ชั่นหน้า!

---

### **7. 🔧 Plugins Improvements**

**新增:**
- Plugin-config TUI prompts
- Guided onboarding/setup flows
- `openclaw plugins install --force`

**วิธีใช้:**
```bash
# ติดตั้ง plugin แทนที่อันเก่าโดยไม่ต้องใช้ flag อันตราย
openclaw plugins install --force <plugin-name>
```

---

### **8. 🎯 ClawHub Integration**

**新增:** Search, detail, and install flows ใน Skills panel!

**วิธีใช้:**
1. เปิด Control UI
2. ไปที่ Skills panel
3. ค้นหา skills จาก ClawHub
4. ติดตั้งได้โดยตรง

---

### **9. 📱 iOS Exec Approvals**

**新增:** Generic APNs approval notifications

**ฟีเจอร์:**
- Open in-app exec approval modal
- Fetch command details after authenticated reconnect
- Clear stale notification state

---

### **10. 💬 Matrix Exec Approvals**

**新增:** Matrix-native exec approval prompts

**ฟีเจอร์:**
- Account-scoped approvers
- Channel-or-DM delivery
- Room-thread aware resolution handling

---

### **11. 📊 Context Visibility**

**新增:** Configurable contextVisibility per channel

**Options:**
- `all` - ทั้งหมด
- `allowlist` - เฉพาะ allowlist
- `allowlist_quote` - allowlist + quote

**ประโยชน์:**
- กรอง context ตาม sender
- ไม่ส่งทุกอย่างที่ได้รับ
- ควบคุม privacy ได้ดีขึ้น

---

### **12. ⚙️ Request Overrides**

**新增:** Shared model and media request transport overrides

**รองรับ:**
- OpenAI-compatible
- Anthropic-compatible
- Google-compatible
- และอื่นๆ

**Controls:**
- Headers
- Auth
- Proxy
- TLS

---

## ⚠️ **Breaking Changes:**

### **Config Changes:**

**ลบ Legacy aliases:**

| เดิม | ใหม่ |
|------|------|
| `talk.voiceId` | ใช้ canonical path |
| `talk.apiKey` | ใช้ canonical path |
| `agents.*.sandbox.perSession` | ใช้ `enabled` |
| `browser.ssrfPolicy.allowPrivateNetwork` | ใช้ canonical path |
| `hooks.internal.handlers` | ใช้ canonical path |

**Migration:**
```bash
# ใช้ openclaw doctor --fix
openclaw doctor --fix
```

---

## 📊 **สรุปอัพเดท:**

| หมวดหมู่ | จำนวน | หมายเหตุ |
|---------|-------|---------|
| **Tools ใหม่** | 2 | Video, Music generation |
| **Providers ใหม่** | 6+ | Qwen, Fireworks, StepFun, etc. |
| **Languages** | 12 | Control UI multilingual |
| **Integrations** | 3 | ComfyUI, ClawHub, Bedrock |
| **Breaking Changes** | 1 | Config aliases |

---

## 🚀 **วิธีอัพเดท:**

### **วิธีที่ 1: npm**

```bash
npm install -g openclaw@latest
```

### **วิธีที่ 2: pnpm**

```bash
pnpm add -g openclaw@latest
```

### **วิธีที่ 3: จาก Source**

```bash
cd openclaw
git pull
pnpm install && pnpm build
```

---

## ✅ **หลังอัพเดท:**

```bash
# 1. เช็คเวอร์ชั่น
openclaw --version

# 2. รัน doctor
openclaw doctor

# 3. แก้ config (ถ้ามี breaking changes)
openclaw doctor --fix

# 4. Restart gateway
openclaw gateway restart
```

---

## 🎯 **ฟีเจอร์ที่มิกแนะนำ:**

### **สำหรับนักพัฒนาชุมชน:**

1. **Video Generation** - สร้างวิดีโอประชาสัมพันธ์
2. **Music Generation** - สร้างเพลงประกอบคอนเทนต์
3. **Multilingual UI** - แสดงผลหลายภาษา
4. **Context Visibility** - ควบคุม privacy

---

## 📈 **สถิติเวอร์ชั่น:**

| เวอร์ชั่น | วันที่ | ฟีเจอร์หลัก |
|---------|--------|-----------|
| v2026.4.5 | 6 เม.ย. 2569 | Video, Music, 12+ ฟีเจอร์ |
| v2026.4.4 | (ก่อนหน้า) | - |
| v2026.4.3 | (ก่อนหน้า) | - |

---

## 🔗 **ลิงก์ที่เป็นประโยชน์:**

| แหล่ง | ลิงก์ |
|------|-------|
| **Release Notes** | https://github.com/openclaw/openclaw/releases/tag/v2026.4.5 |
| **GitHub Repo** | https://github.com/openclaw/openclaw |
| **Documentation** | https://docs.openclaw.ai |
| **Discord** | https://discord.gg/clawd |

---

## 💬 **แสดงความคิดเห็น:**

เหน่งคิดว่าฟีเจอร์ไหนน่าสนใจที่สุด?

1. 🎬 Video Generation
2. 🎵 Music Generation
3. 🌍 Multilingual UI
4. 🔧 ComfyUI Integration
5. อื่นๆ

---

**อัพเดทเลย!** 🚀

```bash
npm install -g openclaw@latest
```

---

_อัพเดทโดย: Mick_  
_อ้างอิง: OpenClaw v2026.4.5 Release Notes_  
_6 เมษายน 2569_
