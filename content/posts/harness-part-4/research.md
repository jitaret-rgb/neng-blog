# Research: Harness Engineering ตอนที่ 4 - Tools & Permissions

> วันที่: 2026-04-13
> หัวข้อ: Tools & Permissions - กำหนดขอบเขต AI

---

## 1. Tools & Permissions คืออะไร

**Tools** คือความสามารถที่ AI Agent สามารถใช้งานได้ เช่น:
- อ่าน/เขียนไฟล์ (File System)
- รันคำสั่งใน Terminal (Shell Execution)
- เข้าถึง Browser (Web Automation)
- ส่งข้อความ/อีเมล (Messaging)
- เรียกใช้ API ภายนอก

**Permissions** คือการกำหนดขอบเขตว่า Agent สามารถใช้ Tool ใดได้บ้าง และใช้ได้แค่ไหน

---

## 2. ทำไมต้องกำหนดขอบเขต AI

### ความเสี่ยงหลัก 10 ประการ (OWASP Top 10 for Agentic Applications 2026)

| Risk ID | ชื่อ | ความรุนแรง |
|---------|------|-----------|
| ASI01 | Agent Goal Hijack | Critical |
| ASI02 | Tool Misuse & Exploitation | Critical |
| ASI03 | Identity & Privilege Abuse | Critical |
| ASI04 | Supply Chain Vulnerabilities | High |
| ASI05 | Unexpected Code Execution | Critical |
| ASI06 | Memory & Context Poisoning | High |
| ASI07 | Insecure Inter-Agent Communication | High |
| ASI08 | Cascading Failures | Medium |
| ASI09 | Human-Agent Trust Exploitation | Medium |
| ASI10 | Rogue Agents | High |

### สถิติสำคัญ
- **73%** ของ AI ที่ deploy ใน production มีช่องโหว่ Prompt Injection
- **15-25%** ของโค้ดที่ AI สร้างมีช่องโหว่ความปลอดภัย
- **30+ CVEs** ถูกค้นพบในเดือนธันวาคม 2025 ใน AI Coding Platforms ใหญ่ๆ
- **CamoLeak vulnerability** (CVSS 9.6) ใน GitHub Copilot ทำให้สามารถขโมย secrets และ source code ได้

### ความเสี่ยงที่เกิดขึ้นจริง
1. **Data Exfiltration** - AI ส่งข้อมูลสำคัญไปยัง server ของ attacker
2. **Prompt Injection** - ผู้โจมตีซ่อนคำสั่งในเอกสาร/README ให้ AI ทำตาม
3. **Tool Misuse** - AI ใช้ tool ผิดวัตถุประสงค์ เช่น ลบ database ทั้งหมด
4. **Memory Poisoning** - ข้อมูลที่ถูก inject เข้าไปใน memory ทำให้ AI พฤติกรรมผิดปกติในอนาคต

---

## 3. ประเภทของ Permissions

### 3.1 ตามลักษณะการทำงาน (Action Types)

| Permission Type | คำอธิบาย | ตัวอย่าง |
|-----------------|----------|---------|
| **Read** | อ่านข้อมูลเท่านั้น | อ่านไฟล์, ดูข้อมูล |
| **Write** | เขียน/แก้ไขข้อมูล | เขียนไฟล์, อัพเดท database |
| **Execute** | รันคำสั่ง/โค้ด | รัน shell command, execute code |
| **Delete** | ลบข้อมูล | ลบไฟล์, ลบ record |
| **Network** | เข้าถึง network | เรียก API, เปิด URL |

### 3.2 ตามขอบเขต (Scope)

| Scope | คำอธิบาย |
|-------|----------|
| **Workspace Only** | จำกัดให้ทำงานใน workspace ที่กำหนด |
| **Specific Paths** | อนุญาตเฉพาะ path ที่ระบุ เช่น `/app/reports/*` |
| **Allowed Domains** | อนุญาตเฉพาะ domain ที่กำหนด เช่น `api.github.com` |
| **Read-Only Mode** | อนุญาตแค่อ่านอย่างเดียว |
| **Sandboxed** | รันใน sandbox/container ที่แยกออกจากระบบหลัก |

### 3.3 ตามระดับความเสี่ยง (Risk Levels)

```python
class RiskLevel(Enum):
    LOW = "low"        # Read operations, safe queries
    MEDIUM = "medium"  # Write operations, API calls
    HIGH = "high"      # Financial, deletion, external comms
    CRITICAL = "critical"  # Irreversible, security-sensitive
```

---

## 4. Best Practices

### 4.1 หลักการ Least Privilege (ให้สิทธิ์น้อยที่สุด)
- ให้ Agent มีสิทธิ์แค่ที่จำเป็นเท่านั้น
- แยก Tool ตามความเชื่อมั่น (trust level)
- ใช้ scoped API keys แทน credentials หลัก

### 4.2 Confirmation Steps (การยืนยันก่อนทำ)
- ต้องมีการยืนยันจากผู้ใช้ก่อนทำ action ที่มีความเสี่ยงสูง
- แสดง preview ว่าจะทำอะไรก่อน execute
- ตัวอย่าง action ที่ต้องยืนยัน: ส่ง email, ลบไฟล์, โอนเงิน, deploy ไป production

### 4.3 Sandboxing (การแยกสภาพแวดล้อม)
- รัน Agent ใน Docker container ที่แยกออกจาก host
- จำกัด network access
- จำกัด resource (CPU, memory)
- ลบ sandbox ทิ้งเมื่อเสร็จงาน

### 4.4 Audit Logging (การบันทึกทุก action)
- บันทึกทุก prompt ที่ส่งไปยัง AI
- บันทึกทุก tool call และผลลัพธ์
- บันทึกการแก้ไขไฟล์
- เชื่อมต่อกับ SIEM (Security Information and Event Management)

### 4.5 Input/Output Validation
- ตรวจสอบ input ก่อนส่งไปยัง AI
- ใช้ delimiters แยกระหว่าง instructions และ data
- กรอง sensitive data (PII, API keys) ออกจาก output

---

## 5. Claude Code vs Codex

### เปรียบเทียบหลัก

| ด้าน | Claude Code | Codex |
|------|-------------|-------|
| **จุดแข็งหลัก** | Agent orchestration, autonomous execution | Codebase understanding, refactoring |
| **Context Awareness** | โฟกัสที่ file ที่ระบุ | อ่านและเข้าใจทั้ง codebase |
| **ความเร็ว** | ปกติ | เร็วกว่า (ใช้ custom chip) |
| **Agent Teams** | รองรับ Multi-agent | จำกัด |
| **Autonomous Work** | ทำงานอัตโนมัติได้นาน | เหมาะกับงานสั้นๆ |
| **Memory Persistence** | มีระบบ memory/skills | จำกัด |
| **Terminal UX** | ดี | ดีกว่า (syntax highlighting, diffs) |

### เมื่อไหร่ใช้อะไร

**ใช้ Claude Code เมื่อ:**
- ต้องการ Agent ทำงานอัตโนมัติเป็นเวลานาน (night shifts)
- ต้องการ Agent Teams ทำงานขนานกัน
- ต้องการ orchestration มากกว่าแค่ coding
- ต้องการ memory และ skills ที่คงทนข้าม session

**ใช้ Codex เมื่อ:**
- Refactor หรือปรับปรุง codebase ที่มีอยู่
- ต้องการเข้าใจความสัมพันธ์ระหว่างหลายไฟล์
- ความเร็วสำคั
- ต้องการ UX ที่ดีที่สุดใน terminal

**ใช้ทั้งคู่:**
- สร้างและรัน Agent systems ด้วย Claude Code
- พา Codex มาทำ deep review เมื่อ codebase ต้องการ refactoring
- Deploy และ operate ด้วย Claude Code

---

## 6. ตัวอย่าง Tools & Permissions ในทางปฏิบัติ

### ตัวอย่าง 1: File Access Restriction
```json
{
  "name": "file_reader",
  "description": "Read files from the reports directory",
  "allowed_paths": ["/app/reports/*"],
  "allowed_operations": ["read"],
  "blocked_patterns": ["*.env", "*.key", "*.pem", "*secret*"]
}
```

### ตัวอย่าง 2: Email Sending with Confirmation
```python
SENSITIVE_TOOLS = ["send_email", "execute_code", "database_write", "file_delete"]

def require_confirmation(func):
    @wraps(func)
    async def wrapper(tool_name, params, context):
        if tool_name in SENSITIVE_TOOLS:
            if not context.get("user_confirmed"):
                return {
                    "status": "pending_confirmation",
                    "message": f"Action '{tool_name}' requires user approval",
                    "params": sanitize_for_display(params)
                }
        return await func(tool_name, params, context)
    return wrapper
```

### ตัวอย่าง 3: Docker Sandbox
```bash
# รัน Agent ใน Docker ที่แยกออกจาก host
docker run --rm \
  --network none \
  --memory 512m \
  --cpus 1.0 \
  -v /sandbox:/workspace:rw \
  agent-image
```

---

## 7. ข้อผิดพลาดที่พบบ่อย

### 7.1 ข้อผิดพลาดด้าน Configuration
1. **ใช้ API keys เดียวกัน** สำหรับ dev, staging, production
2. **ปิด guardrails** เพราะ "รบกวน" การทำงาน
3. **ไม่มี audit logging** ทำให้ตรวจสอบไม่ได้เมื่อเกิดปัญหา
4. **ให้สิทธิ์ database superuser** กับ Agent เพราะ "สะดวก"

### 7.2 ข้อผิดพลาดด้าน Security
1. **Over-permissioned tools** - ให้สิทธิ์ wildcard (*) แทนที่จะระบุเฉพาะ
2. **ไม่ validate input** จาก external sources
3. **เก็บ sensitive data ใน agent memory** โดยไม่ encrypt
4. **ไม่มี human-in-the-loop** สำหรับ high-risk actions

---

## 8. ประสบการณ์ OpenClaw

### 8.1 โมเดล Permissions ของ OpenClaw

OpenClaw มี exec security modes 3 ระดับ:
- `deny` - ปิดการใช้งาน exec ทั้งหมด
- `allowlist` - อนุญาตเฉพาะคำสั่งที่ระบุใน allowlist
- `full` - อนุญาตทั้งหมด (default ในบาง setup - อันตราย!)

### 8.2 การตั้งค่า Security ที่แนะนำ

```json5
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

### 8.3 ปัญหาที่พบบ่อยใน OpenClaw

| ปัญหา | วิธีแก้ |
|-------|--------|
| Shared DMs + เปิด tools | ใช้ `dmPolicy: "pairing"` หรือ allowlists |
| Browser control เปิดเผย | ใช้ Tailscale, ไม่ expose สู่ public |
| Exec รันโดยไม่ต้องยืนยัน | ตั้งค่า `security: "allowlist"` และ `ask: "always"` |
| Config อยู่ใน synced folder | ย้ายออกจาก iCloud/Dropbox |
| Token สั้นเกินไป | ใช้ token ยาวอย่างน้อย 32 characters |

---

## 9. แหล่งอ้างอิง

### เอกสารหลัก
1. **OWASP Top 10 for Agentic Applications 2026** - https://owasp.org/www-project-top-10-for-large-language-model-applications/
2. **OWASP AI Agent Security Cheat Sheet** - https://cheatsheetseries.owasp.org/cheatsheets/AI_Agent_Security_Cheat_Sheet.html
3. **OpenClaw Security Documentation** - https://docs.openclaw.ai/gateway/security
4. **Digital Applied - AI Agent Security Best Practices 2025** - https://www.digitalapplied.com/blog/ai-agent-security-best-practices-2025
5. **Coder - Agent Boundaries** - https://coder.com/blog/launch-dec-2025-agent-boundaries

### บทความเปรียบเทียบ
6. **Claude Code vs Codex: Real Usage Comparison** - https://thoughts.jock.pl/p/claude-code-vs-codex-real-comparison-2026
7. **Deep Agents: The Harness Behind Claude Code, Codex, Manus, and OpenClaw** - https://agentnativedev.medium.com/deep-agents-the-harness-behind-claude-code-codex-manus-and-openclaw-bdd94688dfdb

### แนวทางการ implement
8. **Action Restrictions and Permissions: Controlling What Your AI Agent Can Do** - https://mbrenndoerfer.com/writing/action-restrictions-and-permissions-ai-agents
9. **NIST AI Risk Management Framework** - https://www.nist.gov/itl/ai-risk-management-framework
10. **Google Secure AI Framework (SAIF)** - https://safety.google/safety/saif/

---

## 10. สรุปข้อมูลสำคัญสำหรับบทความ (10-15 ข้อ)

1. **Tools & Permissions คือหัวใจของ AI Safety** - ไม่มีการควบคุม = ไม่มีความปลอดภัย

2. **OWASP Top 10 for Agentic Applications** เป็นมาตรฐานแรกสำหรับ AI Agent Security (ธ.ค. 2025)

3. **Prompt Injection ครองอันดับ 1** - 73% ของ AI ใน production มีช่องโหว่นี้

4. **Least Privilege เป็นหลักการสำคัญที่สุด** - ให้สิทธิ์น้อยที่สุดที่ยังทำงานได้

5. **มี 3 ระดับของ Permissions**: Read, Write, Execute - แยกให้ชัดเจน

6. **Confirmation Steps ช่วยป้องกัน** - ต้องยืนยันก่อนทำ action ที่มีความเสี่ยงสูง

7. **Sandboxing เป็นเกราะป้องกัน** - Docker container แยกจาก host เป็นความปลอดภัยขั้นพื้นฐาน

8. **Claude Code vs Codex มีจุดแข็งต่างกัน** - Claude เก่งเรื่อง orchestration, Codex เก่งเรื่อง codebase understanding

9. **OpenClaw มี 3 exec security modes**: deny, allowlist, full - อย่าใช้ full โดยไม่จำเป็น

10. **Audit Logging ไม่ใช่ตัวเลือก** - เป็นสิ่งจำเป็นสำหรับการตรวจสอบและ compliance

11. **15-25% ของโค้ด AI-generated มีช่องโหว่** - ต้องมีการ review เสมอ

12. **AI Agents ต้องถูกมองว่าเป็น "untrusted personnel"** - ไม่ใช่เครื่องมือที่เชื่อถือได้โดยอัตโนมัติ

13. **Multi-agent systems ต้องมี trust boundaries** - แยกสิทธิ์ระหว่าง agents

14. **Human-in-the-loop ยังจำเป็น** - สำหรับ action ที่มีผลกระทบสูง

15. **Security กับ Productivity ไม่ใช่ศัตรูกัน** - ทำได้ทั้งคู่ถ้าออกแบบดี

---

## 11. ตัวอย่างจริงที่เข้าใจง่าย

### ตัวอย่างที่ 1: การ์ดเครดิต (Credit Card Analogy)
- **ไม่มี Permissions** = ให้บัตรเครดิตกับใครก็ได้ ไม่มีวงเงิน ไม่มีรหัส PIN
- **มี Permissions** = บัตรเครดิตมีวงเงิน, ต้องใส่ PIN, มี SMS แจ้งเตือนทุกรายการ

### ตัวอย่างที่ 2: บ้าน (House Analogy)
- **ไม่มี Permissions** = ทิ้งกุญแจบ้านไว้หน้าบ้าน ใครก็เข้าได้
- **มี Permissions** = มีกุญแจเฉพาะห้อง, มีกล้องวงจรปิด, ต้องขออนุญาตก่อนเข้าห้องนอน

### ตัวอย่างที่ 3: รถยนต์ (Car Analogy)
- **ไม่มี Permissions** = รถไม่มีเบรก, ไม่มีเกียร์, ขับได้ไม่จำกัดความเร็ว
- **มี Permissions** = มีเบรก, มีเกียร์ควบคุมความเร็ว, มี GPS ติดตาม, มีถุงลมนิรภัย

---

## 12. Checklist ก่อน Deploy AI Agent

- [ ] กำหนด Permissions ตามหลัก Least Privilege
- [ ] ตั้งค่า Confirmation Steps สำหรับ high-risk actions
- [ ] เปิดใช้งาน Audit Logging
- [ ] ตรวจสอบว่าไม่มี sensitive data ใน prompts
- [ ] ใช้ Sandbox/Container สำหรับ code execution
- [ ] ตรวจสอบ OWASP Top 10 for Agentic Applications
- [ ] ทดสอบ Prompt Injection ก่อน deploy
- [ ] มีแผน Incident Response
- [ ] ตรวจสอบ compliance ตาม regulations (GDPR, HIPAA, etc.)
- [ ] มีการ Review AI-generated code ก่อน merge

---

*บันทึกโดย: Researcher Agent*
*เวลา: 2026-04-13 23:15 GMT+7*