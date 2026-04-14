---
title: "Harness Engineering ตอนที่ 4: Tools & Permissions - กำหนดขอบเขต AI"
date: 2026-04-13T10:00:00+07:00
description: "เรียนรู้วิธีกำหนดขอบเขตให้ AI Agent ด้วย Tools & Permissions ป้องกันความเสี่ยงด้านความปลอดภัย พร้อมตัวอย่างจาก OWASP และ OpenClaw"
keywords:
  - AI Safety
  - Tools & Permissions
  - Harness Engineering
  - Security Configuration
  - OWASP
  - OpenClaw
author: "Mick"
tags: ['harness-engineering', 'ai-safety', 'openclaw', 'owasp', 'security']
categories: ['Tutorial', 'AI']
partOfSeries: "Harness Engineering"
previous: "harness-engineering-3"
next: "harness-engineering-5"
image: "cover.jpg"
seriesNumber: 4
---

# Harness Engineering ตอนที่ 4: Tools & Permissions - กำหนดขอบเขต AI

## ส่วนนำ: ทำไม AI ถึงต้องมี "ล็อคประตู"?

ลองนึกภาพว่าคุณจ้างพนักงานใหม่มาทำงาน แต่ไม่ได้กำหนดว่าเขาทำอะไรได้บ้าง ไม่ได้บอกว่าห้องไหนเข้าได้ ห้องไหนเข้าไม่ได้ และไม่ได้บอกว่าอะไรทำได้ อะไรทำไม่ได้... คุณจะรู้สึกอย่างไร?

น่ากลัวใช่ไหมล่ะ?

แต่นี่คือสิ่งที่หลายคนทำกับ AI Agent กันโดยไม่รู้ตัว

**สถิติที่น่าตกใจ:** ข้อมูลจาก OWASP Top 10 for Agentic Applications 2026 พบว่า **73% ของ AI ที่ deploy ใน production มีช่องโหว่ Prompt Injection** นั่นหมายความว่าทุกครั้งที่คุณใช้ AI Agent มีโอกาสเกือบ 3 ใน 4 ที่จะถูกโจมตีผ่านวิธีนี้!

และยิ่งไปกว่านั้น **15-25% ของโค้ดที่ AI สร้างมีช่องโหว่ความปลอดภัย** (OWASP, 2026) ซึ่งเป็นตัวเลขที่สูงมากเมื่อพิจารณาว่าเรานำ AI มาใช้เพื่อเพิ่มประสิทธิภาพ

เห็นไหมครับว่าปัญหามันอยู่ตรงไหน?

## Tools & Permissions คืออะไร?

มาทำความเข้าใจกันง่ายๆ ก่อนนะครับ

**Tools** คือ "ความสามารถ" ที่ AI Agent สามารถใช้งานได้ ลองนึกภาพว่า AI เป็นคนที่มีอุปกรณ์ต่างๆ อยู่ในมือ:

- 📖 **อ่านไฟล์** (File Reader) - AI สามารถเปิดดูไฟล์ในระบบ
- ✍️ **เขียนไฟล์** (File Writer) - AI สามารถสร้างหรือแก้ไขไฟล์
- 💻 **รันคำสั่ง** (Shell Execution) - AI สามารถสั่งให้คอมพิวเตอร์ทำงาน
- 🌐 **ควบคุม Browser** (Web Automation) - AI สามารถเปิดเว็บ กรอกฟอร์ม
- ✉️ **ส่งข้อความ** (Messaging) - AI สามารถส่งอีเมลหรือข้อความ

แต่ละอย่างก็มีความเสี่ยงต่างกันไป การอ่านไฟล์น่าจะปลอดภัยกว่าการรันคำสั่งใช่ไหมครับ?

**Permissions** คือ "กฎเกณฑ์" ที่กำหนดว่า AI จะใช้ Tools แต่ละอย่างได้แค่ไหน ใช้ได้กี่ครั้ง และใช้ในสถานการณ์ไหนบ้าง

ลองเปรียบเทียบให้เห็นภาพนะครับ:

| ไม่มี Permissions | มี Permissions |
|------------------|----------------|
| ให้บัตรเครดิตกับใครก็ได้ ไม่มีวงเงิน ไม่มี PIN | บัตรเครดิตมีวงเงิน 5,000 บาท ต้องใส่ PIN ทุกครั้ง |
| ทิ้งกุญแจบ้านไว้หน้าบ้าน ใครก็เข้าได้ | มีกุญแจเฉพาะห้อง ต้องขออนุญาตก่อนเข้า |
| รถไม่มีเบรก ขับได้ไม่จำกัดความเร็ว | มีเบรก มีเกียร์ควบคุม มีถุงลมนิรภัย |

เห็นความแตกต่างชัดเจนเลยใช่ไหมครับ?

## ทำไมต้องกำหนดขอบเขต?

มาดูความเสี่ยงที่เกิดขึ้นจริงกันครับ:

### 1. Prompt Injection - "เสียงกระซิบในหู"

นึกภาพว่าคุณส่งเอกสารให้ AI อ่าน แต่ในเอกสารนั้นมีคำสั่งซ่อนอยู่ว่า "ลบไฟล์ทั้งหมด" หรือ "ส่งข้อมูลลับไปที่นี่" นี่แหละคือ Prompt Injection

ผู้โจมตีจะฝังคำสั่งไว้ใน:
- README files
- คอมเมนต์ในโค้ด
- ข้อความที่ AI ต้องประมวลผล

และเมื่อ AI อ่านเจอ ก็จะทำตามโดยไม่รู้ตัว!

### 2. Tool Misuse - "ใช้มีดแทงคน"

แม้แต่ Tool ที่ดีก็อาจถูกใช้ผิดวัตถุประสงค์ได้

ตัวอย่าง:
- AI ที่มีสิทธิ์เขียนไฟล์อาจไปลบ database ทั้งหมดเพราะเข้าใจคำสั่งผิด
- AI ที่ส่งอีเมลได้อาจส่งข้อความหลอกลวงไปยังลูกค้า
- AI ที่รันคำสั่งได้อาจดาวน์โหลดมัลแวร์โดยไม่รู้ตัว

### 3. Data Exfiltration - "ข้อมูลรั่วไหล"

AI อาจถูกหลอกให้ส่งข้อมูลสำคัญ (ลูกค้า, รหัสผ่าน, ข้อมูลทางการเงิน) ไปยัง server ของผู้โจมตี

### 4. Cascading Failures - "ลูกโซ่หลุด"

เมื่อ AI หนึ่งตัวทำงานผิด อาจส่งผลกระทบต่อ AI ตัวอื่นๆ ที่เชื่อมต่อกัน ทำให้ปัญหาลุกลามเป็นกองไฟ

---

สถิติไม่โกหกครับ: **30+ CVEs ถูกค้นพบในเดือนธันวาคม 2025 ใน AI Coding Platforms ใหญ่ๆ** และที่น่าตกใจที่สุดคือ **CamoLeak vulnerability (CVSS 9.6) ใน GitHub Copilot** ทำให้สามารถขโมย secrets และ source code ได้!

นี่ไม่ใช่เรื่องไกลตัว แต่เป็นภัยคุกคามที่เกิดขึ้นจริง

## ประสบการณ์เหน่งกับ OpenClaw

ตอนนี้มาดูกันว่าเหน่งใช้ OpenClaw อย่างไรในการกำหนดขอบเขตให้ AI ครับ

### OpenClaw Security Modes

OpenClaw มี exec security modes 3 ระดับ:

| Mode | คำอธิบาย | เหมาะกับ |
|------|----------|----------|
| `deny` | ปิดการใช้งาน exec ทั้งหมด | งานที่ไม่ต้องรันคำสั่ง |
| `allowlist` | อนุญาตเฉพาะคำสั่งที่ระบุ | งานที่ต้องควบคุมอย่างเข้มงวด |
| `full` | อนุญาตทั้งหมด | ⚠️ อันตราย! ใช้ด้วยความระมัดระวัง |

**คำแนะนำ:** อย่าใช้ `full` โดยไม่จำเป็น เพราะมันเปิดให้ AI ทำได้ทุกอย่าง!

### การตั้งค่าที่แนะนำ

```json
{
  gateway: {
    mode: "local",
    bind: "loopback",
    auth: { mode: "token", token: "replace-with-long-random-token" },
  },
  tools: {
    profile: "messaging",
    deny: ["group:automation", "group:runtime", "group:fs", "sessions_spawn"],
    fs: { workspaceOnly: true },
    exec: { security: "deny", ask: "always" },
    elevated: { enabled: false },
  },
}
```

สังเกตไหมครับว่า:
- `exec: { security: "deny", ask: "always" }` - ถ้าจำเป็นต้องรันคำสั่ง ต้องถามเหน่งก่อนทุกครั้ง!
- `deny: ["group:automation", "group:runtime", "group:fs"]` - ปิดการใช้งาน groups ที่เสี่ยง
- `fs: { workspaceOnly: true }` - จำกัดให้อ่าน/เขียนได้เฉพาะใน workspace

### ปัญหาที่เจอและวิธีแก้

| ปัญหา | วิธีแก้ |
|-------|--------|
| Shared DMs + เปิด tools | ใช้ `dmPolicy: "pairing"` หรือ allowlists |
| Browser control เปิดเผย | ใช้ Tailscale, ไม่ expose สู่ public |
| Exec รันโดยไม่ต้องยืนยัน | ตั้งค่า `security: "allowlist"` และ `ask: "always"` |
| Config อยู่ใน synced folder | ย้ายออกจาก iCloud/Dropbox |
| Token สั้นเกินไป | ใช้ token ยาวอย่างน้อย 32 characters |

เหน่งเจอปัญหาเรื่องนี้หลายครั้งครับ โดยเฉพาะตอนที่ token สั้นเกินไป ทำให้เดาได้ง่าย หลังจากปรับให้ยาวขึ้นและตั้งค่า `ask: "always"` ก็รู้สึกสบายใจขึ้นเยอะ

---

## ประเภทของ Permissions แบบละเอียด

มาถึงส่วนสำคัญแล้วครับ! ตอนนี้เราจะมาดูกันว่า Permissions แบ่งออกเป็นกี่ประเภท และแต่ละประเภทมีความเสี่ยงอย่างไร

### 1. 📖 Read Permissions - "ดวงตา" ของ AI

Read Permissions คือสิทธิ์ในการเข้าถึงข้อมูล ลองนึกภาพว่า AI เป็นพนักงานที่สามารถอ่านเอกสารในสำนักงานได้

**สิ่งที่ AI สามารถทำได้:**
- อ่านไฟล์ในระบบ
- เข้าถึง database
- ดู log files
- อ่าน configuration files
- เข้าถึง environment variables

**ความเสี่ยงที่อาจเกิดขึ้น:**
- ข้อมูลลับรั่วไหล (API keys, passwords, secrets)
- ข้อมูลลูกค้า (PII - Personal Identifiable Information)
- ข้อมูลทางการเงิน
- โค้ดที่มีช่องโหว่ (AI อาจเรียนรู้และนำไปใช้ผิด)

**ตัวอย่างการโจมตี:**
```
Scenario: คุณให้ AI อ่านไฟล์ README.md เพื่อทำความเข้าใจโปรเจกต์
แต่ในไฟล์นั้นมีคอมเมนต์ว่า "TODO: remove API key before deploy"
AI ก็อาจเห็น API key นั้นและนำไปใช้ได้!
```

**วิธีจำกัด:**
```json
{
  "fs": {
    "workspaceOnly": true,  // อ่านได้เฉพาะ workspace
    "allowedDirs": ["/project/src", "/project/config"],
    "deniedPatterns": ["**/*.env", "**/secrets/**"]
  }
}
```

### 2. ✍️ Write Permissions - "มือ" ของ AI

Write Permissions คือสิทธิ์ในการสร้างหรือแก้ไขข้อมูล นี่คือสิ่งที่ต้องระวังเป็นพิเศษ เพราะมีความเสี่ยงสูงกว่า Read มาก!

**สิ่งที่ AI สามารถทำได้:**
- สร้างไฟล์ใหม่
- แก้ไขไฟล์ที่มีอยู่
- ลบไฟล์
- เขียนลง database
- แก้ไข configuration

**ความเสี่ยงที่อาจเกิดขึ้น:**
- ลบไฟล์สำคัญโดยไม่ตั้งใจ
- เขียนโค้ดที่มีช่องโหว่
- แก้ไขไฟล์ระบบทำให้เสียหาย
- ส่งข้อมูลออกไปยัง server ภายนอก

**ตัวอย่างการโจมตี:**
```
Scenario: AI ถูกหลอกให้เขียนโค้ดที่ส่งข้อมูลลูกค้าไปยัง server ของผู้โจมตี
"ช่วยเขียนฟังก์ชันสำหรับ backup ข้อมูลหน่อย"
→ AI เขียนฟังก์ชันที่ส่งข้อมูลไปยัง attacker.com ด้วย!
```

**วิธีจำกัด:**
```json
{
  "fs": {
    "workspaceOnly": true,
    "readOnly": false,
    "allowedWriteDirs": ["/project/src"],
    "deniedPatterns": ["**/production/**", "**/*.log"]
  }
}
```

### 3. 💻 Execute Permissions - "เท้า" ของ AI

Execute Permissions คือสิทธิ์ในการรันคำสั่ง ลองนึกภาพว่า AI สามารถเดินไปไหนก็ได้ในบ้าน และกดปุ่มอะไรก็ได้ — น่ากลัวใช่ไหมครับ?

**สิ่งที่ AI สามารถทำได้:**
- รัน shell commands
- ติดตั้ง packages
- สร้าง processes ใหม่
- จัดการ services
- เข้าถึง network

**ความเสี่ยงที่อาจเกิดขึ้น:**
- รันคำสั่งที่อันตราย (`rm -rf /`)
- ดาวน์โหลดและรันมัลแวร์
- สร้าง backdoor
- ขุดเหมืองคริปโต
- แพร่กระจายไปยังระบบอื่น

**ตัวอย่างการโจมตี:**
```
Scenario: AI ถูกหลอกให้ "ติดตั้ง Python package ที่จำเป็น"
→ แทนที่จะติดตั้ง package จริง กลับรันคำสั่งที่ขโมย SSH keys
→ หรือดาวน์โหลด malware เข้ามาในระบบ
```

**วิธีจำกัด (สำคัญมาก!):**
```json
{
  "exec": {
    "security": "deny",  // ปิดเป็นค่าเริ่มต้น
    "ask": "always",     // ถามก่อนทุกครั้ง
    "allowedCommands": ["git", "npm", "pip"],
    "timeout": 30
  }
}
```

### 4. 🌐 Network Permissions - "ปาก" ของ AI

Network Permissions คือสิทธิ์ในการสื่อสารกับภายนอก ลองนึกภาพว่า AI มีโทรศัพท์ที่สามารถโทรหาคนอื่นได้ตลอดเวลา

**สิ่งที่ AI สามารถทำได้:**
- เรียก API ภายนอก
- ส่ง HTTP requests
- เชื่อมต่อ database ภายนอก
- รับ connections จากภายนอก
- ใช้ WebSocket

**ความเสี่ยงที่อาจเกิดขึ้น:**
- ข้อมูลรั่วไหลไปยัง server ภายนอก
- ถูกใช้เป็น proxy สำหรับโจมตีระบบอื่น
- เรียก API ที่เสียค่าใช้จ่ายสูง
- รับคำสั่งจากภายนอก (Command & Control)

**ตัวอย่างการโจมตี:**
```
Scenario: AI ถูกหลอกให้ "ดึงข้อมูลจาก API ภายนอก"
→ แทนที่จะเรียก API จริง กลับส่งข้อมูลลับไปยัง server ผู้โจมตี
→ หรือถูกหลอกให้เชื่อมต่อกับ "API ที่ดูเหมือนจริง" แต่เป็นของผู้โจมตี
```

**วิธีจำกัด:**
```json
{
  "network": {
    "egress": {
      "allowedDomains": ["api.github.com", "registry.npmjs.org"],
      "blockedDomains": ["*.onion", "attacker.com"]
    },
    "ingress": {
      "bind": "loopback",  // รับ connection ได้เฉพาะ local
      "auth": "token"      // ต้องมี token
    }
  }
}
```

### ตารางเปรียบเทียบระดับความเสี่ยง

| Permission Type | ระดับความเสี่ยง | เหตุผล |
|----------------|----------------|---------|
| Read | 🟡 ปานกลาง | ข้อมูลรั่วไหล แต่ไม่ทำลายระบบโดยตรง |
| Write | 🟠 สูง | แก้ไข/ลบข้อมูล สร้างไฟล์อันตราย |
| Execute | 🔴 สูงมาก | ควบคุมระบบได้ทั้งหมด |
| Network | 🔴 สูงมาก | ส่งข้อมูลออก รับคำสั่งจากภายนอก |

---

## Best Practices สำหรับการกำหนดขอบเขต

มาดู Best Practices ที่ควรปฏิบัติตามกันครับ:

### 1. 🛡️ Least Privilege Principle - ให้น้อยที่สุดที่ยังทำงานได้

**หลักการ:** ให้ AI สิทธิ์เฉพาะสิ่งที่จำเป็นต่อการทำงาน ไม่ใช่ทุกอย่างที่มี

**วิธีปฏิบัติ:**
- เริ่มต้นด้วย `deny` ทั้งหมด
- เปิดใช้งานทีละอย่างเมื่อต้องการ
- ทบทวนสิทธิ์เป็นระยะ

**ตัวอย่าง:**
```json
// ❌ ไม่ดี - ให้สิทธิ์เยอะเกินไปตั้งแต่แรก
{
  "tools": { "profile": "full" }
}

// ✅ ดี - เริ่มจากน้อย เพิ่มทีละน่อย
{
  "tools": {
    "profile": "minimal",
    "allow": ["file:read", "web:search"]
  }
}
```

### 2. ✅ Confirmation Steps - ยืนยันก่อนทำ

**หลักการ:** ก่อนทำ action ที่มีความเสี่ยงสูง ต้องถามคนก่อนเสมอ

**วิธีปฏิบัติ:**
- ตั้งค่า `ask: "always"` สำหรับ exec และ write
- แสดงสิ่งที่จะทำให้ user เห็นชัดเจน
- รอจนได้รับการยืนยันก่อนดำเนินการ

**ตัวอย่าง:**
```json
{
  "exec": {
    "security": "allowlist",
    "ask": "always"  // ถามก่อนทุกครั้ง
  },
  "fs": {
    "ask": "always"  // ก่อนเขียน/ลบไฟล์
  }
}
```

### 3. 🏠 Sandboxing - แยกสภาพแวดล้อม

**หลักการ:** ถ้า AI ทำอะไรผิด ความเสียหายต้องอยู่ในขอบเขตที่จำกัด

**วิธีปฏิบัติ:**
- ใช้ Docker container แยกสภาพแวดล้อม
- จำกัด file system access เฉพาะ workspace
- ใช้ VM สำหรับงานที่เสี่ยงสูง

**ตัวอย่าง:**
```yaml
# docker-compose.yml
services:
  ai-agent:
    image: ai-agent-sandbox
    volumes:
      - ./workspace:/workspace  # เฉพาะโฟลเดอร์นี้
    cap_drop:
      - ALL
    security_opt:
      - no-new-privileges:true
```

### 4. 📝 Audit Logging - บันทึกทุก action

**หลักการ:** ถ้าเกิดปัญหา ต้องสามารถตรวจสอบย้อนกลับได้

**วิธีปฏิบัติ:**
- บันทึกทุก command ที่รัน
- เก็บ log ในที่ปลอดภัย
- ตั้ง alert สำหรับ action ที่ผิดปกติ

**ตัวอย่าง:**
```json
{
  "logging": {
    "level": "verbose",
    "destination": "secure-log-server",
    "retention": "90 days",
    "alertOn": ["exec", "network: egress", "fs: delete"]
  }
}
```

### 5. 🔄 Rate Limiting - จำกัดจำนวนครั้ง

**หลักการ:** ป้องกันไม่ให้ AI ทำอะไรซ้ำๆ มากเกินไป

**วิธีปฏิบัติ:**
- จำกัดจำนวนครั้งที่ใช้ tool ต่อชั่วโมง
- จำกัด token usage
- ตั้ง timeout สำหรับแต่ละ action

**ตัวอย่าง:**
```json
{
  "rateLimits": {
    "exec": {
      "maxPerHour": 10,
      "timeout": 30
    },
    "network": {
      "maxPerHour": 50,
      "costAlert": 100  // บาทต่อชั่วโมง
    }
  }
}
```

### 6. 🔒 Credential Isolation - แยก credentials

**หลักการ:** AI ไม่ควรเข้าถึง credentials โดยตรง

**วิธีปฏิบัติ:**
- ใช้ secrets manager แทน env variables
- ห้ามเขียน credentials ในโค้ด
- ใช้ IAM roles แทน static keys

**ตัวอย่าง:**
```json
// ❌ ไม่ดี
{
  "env": {
    "API_KEY": "sk-xxxxx"  // เสี่ยงมาก!
  }
}

// ✅ ดี
{
  "secrets": "aws-secrets-manager",
  "env": {
    "API_KEY": "ref:secrets/API_KEY"  // อ้างอิงจาก secrets manager
  }
}
```

### 7. 🧪 Testing & Validation - ทดสอบก่อนใช้จริง

**หลักการ:** ทดสอบ configuration ก่อน deploy จริงเสมอ

**วิธีปฏิบัติ:**
- ทดสอบใน staging environment ก่อน
- ทำ red team testing
- ตรวจสอบ configuration ด้วย automated tools

**Checklist ก่อน Deploy:**
- [ ] ตั้งค่า `exec.security` เป็น `deny` หรือ `allowlist`
- [ ] ตั้งค่า `ask: "always"` สำหรับ action เสี่ยง
- [ ] จำกัด `fs.workspaceOnly: true`
- [ ] เปิด logging และ monitoring
- [ ] ตั้ง rate limits
- [ ] ใช้ token ยาวอย่างน้อย 32 ตัวอักษร
- [ ] ทดสอบใน sandbox ก่อน

---

## OWASP Top 10 for Agentic Applications 2026

มาดูกันครับว่า OWASP ระบุความเสี่ยงอะไรบ้างสำหรับ AI Agent:

| # | Code | ชื่อ | ความเสี่ยงหลัก |
|---|------|------|---------------|
| 1 | ASI01 | Agent Goal Hijack | ผู้โจมตีเปลี่ยนเป้าหมายของ AI |
| 2 | ASI02 | Tool Misuse and Exploitation | ใช้ tools ผิดวัตถุประสงค์ |
| 3 | ASI03 | Identity and Privilege Abuse | ใช้สิทธิ์เกินขอบเขต |
| 4 | ASI04 | Agentic Supply Chain Vulnerabilities | ช่องโหว่จาก dependencies |
| 5 | ASI05 | Unexpected Code Execution (RCE) | รันโค้ดโดยไม่ตั้งใจ |
| 6 | ASI06 | Memory & Context Poisoning | ปนเปื้อน memory/context |
| 7 | ASI07 | Insecure Inter-Agent Communication | สื่อสารระหว่าง agents ไม่ปลอดภัย |
| 8 | ASI08 | Cascading Failures | ลุกลามเป็นลูกโซ่ |
| 9 | ASI09 | Human-Agent Trust Exploitation | เอาเปรียบความไว้วางใจ |
| 10 | ASI10 | Rogue Agents | Agent ไม่ได้รับอนุญาตทำงาน |

**ความเชื่อมโยงกับ Permissions:**
- ASI02, ASI03 → เกี่ยวกับการใช้ Tools/Permissions ผิดวิธี
- ASI05 → เกี่ยวกับ Execute Permissions
- ASI08 → เกี่ยวกับ Network Permissions

นี่คือเหตุผลที่การกำหนด Permissions อย่างถูกต้องสำคัญมากครับ!

---

## สรุปบทความ

มาถึงตอนจบแล้วครับ! สรุปสิ่งที่ได้เรียนรู้วันนี้:

### สิ่งที่ได้เรียนรู้:

1. **Tools & Permissions คืออะไร** - Tools คือความสามารถของ AI ส่วน Permissions คือกฎเกณฑ์ที่ควบคุมการใช้งาน

2. **ทำไมต้องกำหนดขอบเขต** - เพื่อป้องกัน Prompt Injection, Tool Misuse, Data Exfiltration และ Cascading Failures

3. **ประเภท Permissions 4 อย่าง:**
   - 📖 Read - อ่านไฟล์/ข้อมูล
   - ✍️ Write - เขียน/แก้ไข/ลบ
   - 💻 Execute - รันคำสั่ง
   - 🌐 Network - สื่อสารภายนอก

4. **Best Practices 7 ข้อ:**
   - Least Privilege - ให้น้อยที่สุด
   - Confirmation Steps - ยืนยันก่อนทำ
   - Sandboxing - แยกสภาพแวดล้อม
   - Audit Logging - บันทึกทุก action
   - Rate Limiting - จำกัดจำนวนครั้ง
   - Credential Isolation - แยก credentials
   - Testing & Validation - ทดสอบก่อนใช้จริง

5. **OWASP Top 10 for Agentic Applications 2026** - 10 ความเสี่ยงที่ต้องรู้และป้องกัน

### การนำไปใช้:

จากประสบการณ์ของเหน่งกับ OpenClaw สิ่งที่แนะนำคือ:
- เริ่มจาก `deny` ทั้งหมด แล้วค่อยๆ เปิด
- ตั้งค่า `ask: "always"` สำหรับ exec และ write
- ใช้ `workspaceOnly: true` สำหรับ file system
- ใช้ token ยาวอย่างน้อย 32 ตัวอักษร

---

## ไปต่อกันเลย!

ในตอนต่อไป เราจะมาดู **Harness Components** กันครับ — ว่ามีองค์ประกอบอะไรบ้างที่ต้องใช้ในการสร้างระบบ AI Agent ที่ปลอดภัยและมีประสิทธิภาพ

เตรียมตัวให้พร้อม แล้วพบกันใหม่ตอนหน้าครับ! 🚀

---

## 📚 อ้างอิง

1. OWASP. (2026). *OWASP Top 10 for Agentic Applications 2026*. https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026

2. Giskard. (2026). *OWASP Top 10 for Agentic Applications 2026: Security Guide*. https://www.giskard.ai/knowledge/owasp-top-10-for-agentic-application-2026

3. Practical DevSecOps. (2026). *OWASP Top 10 for Agentic Applications*. https://www.practical-devsecops.com/owasp-top-10-agentic-applications

4. OWASP. (2025). *OWASP Top 10 for LLM Applications 2025*. https://owasp.org/www-project-top-10-for-llm-applications/

5. MITRE. (2024). *MITRE ATLAS (Adversarial Threat Landscape for Artificial-Intelligence Systems)*. https://atlas.mitre.org/

6. NIST. (2024). *AI Risk Management Framework (AI RMF)*. https://aihub.nist.gov/ai-rmf

7. OpenClaw. (2026). *OpenClaw Documentation - Security Configuration*. https://openclaw.dev/docs

8. Crowdstrike. (2025). *AI Agent Security: Risks and Mitigations*. https://www.crowdstrike.com/blog/ai-agent-security-risks/

9. Nvidia. (2025). *Building Secure AI Agents: Best Practices*. https://developer.nvidia.com/blog/building-secure-ai-agents/

10. Google. (2025). *AI Safety and Security Best Practices*. https://cloud.google.com/blog/products/ai-machine-learning/ai-safety-best-practices

11. Microsoft. (2025). *Responsible AI in Practice: Security Considerations*. https://learn.microsoft.com/en-us/azure/ai-builder/responsible-ai-security

12. Anthropic. (2025). *Building Reliable AI Systems: Security Guide*. https://www.anthropic.com/engineering/security

---

*บทความนี้เป็นส่วนหนึ่งของซีรีส์ "Harness Engineering" ซึ่งสำรวจแนวคิดและเทคนิคในการใช้ AI ให้เกิดประสิทธิภาพสูงสุด*

*ตอนที่ 1: [Harness Engineering ตอนที่ 1: ทำไม AI ต้องมี Harness?](/posts/harness-part-1/)*  
*ตอนที่ 2: [Harness Engineering ตอนที่ 2: Prompt คือ Control Plane (ไม่ใช่ Input Box)](/posts/harness-part-2/)*  
*ตอนที่ 3: [Harness Engineering ตอนที่ 3: Query Loop - หัวใจของระบบ](/posts/harness-part-3/)*  
*ตอนที่ 4: [Harness Engineering ตอนที่ 4: Tools & Permissions - กำหนดขอบเขต AI](/posts/harness-part-4/) (บทความนี้)*

---

*บทความนี้เป็นส่วนหนึ่งของซีรีส์ Harness Engineering จาก Code & Community Blog*
