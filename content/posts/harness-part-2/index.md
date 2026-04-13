+++
title = 'Harness Engineering ตอนที่ 2: Prompt คือ Control Plane (ไม่ใช่ Input Box)'
date = 2026-04-13T10:00:00+07:00
draft = false
tags = ['harness-engineering', 'prompt-engineering', 'ai', 'claude-code', 'codex']
categories = ['Tutorial', 'AI']
image = 'cover.jpg'
description = 'ในตอนที่ 2 เราจะมาคุยเรื่อง Prompt อย่างลึกซึ้ง — ว่ามันคือ Control Plane ไม่ใช่ Input Box และ design มันยังไงให้ควบคุม AI ได้ดี'
+++

# Harness Engineering ตอนที่ 2: Prompt คือ Control Plane (ไม่ใช่ Input Box)

**คำโปรย:** "Prompt กำหนดวิธีพูด, Harness กำหนดวิธีทำงาน" — เรียนรู้ว่าทำไม Prompt Engineering ถึงถึงจุดอิ่มตัว และ Harness Engineering คือคำตอบ

---

## 🎣 ส่วนนำ: ทำไม Prompt ถึงสำคัญกว่าที่คิด?

ลองนึกภาพว่าคุณมีรถยนต์คันหนึ่ง

**แบบที่ 1:** คุณบอก "ขับไปถึงที่หมาย" — รถจะพาคุณไปได้ แต่ถ้ามีเด็กวิ่งตัดหน้า? รถอาจจะเบรกไม่ทัน

**แบบที่ 2:** คุณบอก "ขับไปที่หมาย แต่ต้องระวังเด็กข้างทาง ขับช้ากว่า 50 กม./ชม. ห้ามแซง และต้องหยุดเติมน้ำมันทุก 200 กม." — ผลลัพธ์จะต่างกันมาก

Prompt ก็เหมือนกัน

หลายคนมอง Prompt เป็นแค่ "กล่องใส่ข้อความ" ที่พิมพ์ๆ แล้วกดส่ง แต่ถ้ามองในมุมของ **Harness Engineering** — Prompt คือ **Control Plane** ที่ควบคุมพฤติกรรมของ AI ไม่ใช่แค่ input ที่ใส่เข้าไป

และนี่คือจุดที่หลายคนเข้าใจผิด

---

## 🤔 Prompt คืออะไร?

### มุมมองเดิม vs มุมมองใหม่

**มุมมองเดิม (Input Box):**
> "Prompt คือ ข้อความที่ใส่เข้าไปในกล่อง chat เพื่อบอก AI ให้ทำอะไรสักอย่าง"

**มุมมองใหม่ (Control Plane):**
> "Prompt คือ interface สำหรับควบคุมพฤติกรรมของ AI — เหมือนพวงมาลัยที่ควบคุมทิศทาง ไม่ใช่แค่เชื้อเพลิงที่ใส่เข้าไป"

### ทำไมต้องแยกให้ชัด?

เพราะถ้ามอง Prompt เป็นแค่ Input Box → คุณจะโฟกัสที่ "จะพิมพ์อะไรดี"
แต่ถ้ามอง Prompt เป็น Control Plane → คุณจะโฟกัสที่ "จะ design ระบบอย่างไรให้ AI ทำงานถูกต้อง"

นี่คือความแตกต่างระหว่าง **Prompt Engineering** (ปรับแต่งข้อความ) กับ **Harness Engineering** (ออกแบบระบบควบคุม)

---

### 📊 ตัวอย่างเปรียบเทียบ: Input Box vs Control Plane

| สถานการณ์ | แบบ Input Box (เดิม) | แบบ Control Plane (ใหม่) |
|------------|----------------------|---------------------------|
| **ระบบเคลมประกัน** | "ตรวจสอบคำขอเคลมประกัน" | กำหนด workflow: ตรวจสอบเงื่อนไข → คำนวณค่าชดเชย → ตรวจสอบเอกสาร → ส่งข้อมูลให้คนอนุมัติ |
| **เขียนโค้ด** | "เขียน Python function" | "เขียน Python + เขียน test ด้วย + ห้าม commit ถ้า test fail" |
| **วิเคราะห์ข้อมูล** | "วิเคราะห์ข้อมูลนี้" | กำหนด: ใช้สถิติอะไร → รูปแบบการแสดงผล → ข้อจำกัดของข้อมูล |
| **Customer Support** | "ตอบลูกค้า" | กำหนด: โทนเสียง → SLA → Escalation path → Satisfaction survey |
| **Content Creation** | "เขียนบทความ" | กำหนด: Tone of voice → SEO keywords → Word count → Fact-checking process |

เห็นไหม? Control Plane ไม่ได้แค่ "บอกว่าทำอะไร" แต่ "บอกว่าทำอย่างไร ด้วยเงื่อนไขอะไร"

---

## 🏗️ Prompt Layering: 3 ระดับของการควบคุม

ไม่ใช่ทุก Prompt อยู่ในระดับเดียวกัน การแบ่งชั้นของ Prompt ช่วยให้เราออกแบบระบบที่ซับซ้อนได้ดีขึ้น

### ตารางเปรียบเทียบ 3 ระดับ

| ระดับ | ชื่อ | หน้าที่ | ตัวอย่าง | ความถี่ในการเปลี่ยน |
|-------|------|----------|----------|---------------------|
| **1. Orchestration** | ระดับจัดการงาน | กำหนดว่า "ต้องทำอะไรบ้าง เรียงลำดับอย่างไร" | Agent workflow, task decomposition | นานๆ ครั้ง |
| **2. Runtime** | ระดับขณะทำงาน | กำหนด "บริบท ข้อจำกัด เงื่อนไข" ขณะ AI ทำงาน | Context, constraints, validation rules | ปรับตามงาน |
| **3. Model Interface** | ระดับติดต่อโมเดล | กำหนด "รูปแบบการสื่อสารกับโมเดล" | Instructions, format, output structure | บ่อย (ปรับ prompt ทุกครั้ง) |

### อธิบายแบบง่ายๆ

- **Orchestration** = ผู้จัดการโปรเจกต์ ที่บอกว่า "เรามี 5 ขั้นตอน ขั้น 1 ทำ A ขั้น 2 ทำ B..."
- **Runtime** = หัวหน้างาน ที่บอกว่า "ตอนทำขั้นนี้ อย่าลืมเรื่องความปลอดภัยด้วย"
- **Model Interface** = เลขาที่ ที่บอกว่า "เขียนรายงานในรูปแบบนี้..."

ทั้ง 3 ระดับทำงานร่วมกัน เหมือนโครงสร้างองค์กร — แต่ละชั้นมีหน้าที่ต่างกัน

### ตัวอย่างโค้ด: Prompt Layering ในทางปฏิบัติ

```python
# Layer 1: Orchestration (Foundation)
SYSTEM_PROMPT = """
You are a senior Python developer working on a FastAPI project.
You always write type-safe, well-documented code.
You follow TDD: write tests before implementation.
"""

# Layer 2: Runtime (Context)
CONTEXT_PROMPT = """
Current project structure:
- /app/main.py - FastAPI entry point
- /app/models/ - Pydantic models
- /app/routers/ - API endpoints
- /tests/ - Pytest test files

Current task: Implement user authentication
"""

# Layer 3: Model Interface (Task)
TASK_PROMPT = """
Write a function to authenticate user by JWT token.

Requirements:
- Use Pydantic for validation
- Return HTTPException on failure
- Include unit tests
- Follow existing code style
"""

# Combine all layers
full_prompt = f"{SYSTEM_PROMPT}\n\n{CONTEXT_PROMPT}\n\n{TASK_PROMPT}"
print(full_prompt)
```

---

## 📈 สถิติที่น่าสนใจ

ข้อมูลจากงานวิจัยชี้ว่า:

| วิธี | ผลตอบแทน |
|------|---------|
| **Prompt Engineering แบบเดิม** | ปรับปรุงได้ **<3%** |
| **Harness-level changes (รวม Prompt Layering)** | ปรับปรุงได้ **28-47%** |

นั่นหมายความว่า การเปลี่ยนแปลงที่ระดับ "ระบบ" (Harness) มีผลมากกว่าการเปลี่ยนแปลงที่ระดับ "ข้อความ" (Prompt) ถึง **10 เท่า!**

และนี่คือเหตุผลที่เราต้องมอง Prompt เป็น Control Plane ไม่ใช่แค่ Input Box

---

## 📄 AGENTS.md: แผนที่ ไม่ใช่ Prompt ยาวๆ

อีกตัวอย่างที่ดีคือไฟล์ **AGENTS.md** ในโปรเจกต์ต่างๆ

หลายคนเขียน prompt ยาวเต็มไฟล์ แต่ AGENTS.md ที่ดีควรเป็น **แผนที่** — บอกว่า:

- Agent นี้ทำอะไร
- ต้อง interact กับอะไรบ้าง
- มีข้อจำกัดอะไร

ไม่ใช่ "script ที่ต้องอ่านทุกบรรทัด"

### ตัวอย่าง: AGENTS.md ที่ดี

```markdown
# Agent Role: Backend Developer

## Responsibilities
- Implement API endpoints
- Write unit tests
- Update documentation

## Constraints
- Must use type hints
- Must achieve 90% test coverage
- Cannot modify database schema without approval

## Workflow
1. Read task from TASKS.md
2. Implement code
3. Run tests
4. Submit for review
```

นี่คือหลักการของ **Prompt Layering** — แบ่งให้ชัด ไม่ยัดทุกอย่างไว้ที่เดียว

---

## 🔍 จากทฤษฎีสู่ Reality Check: Claude Code vs Codex

ตอนนี้เราเข้าใจหลักการแล้ว มาดูตัวอย่างจริงกัน

### Claude Code vs OpenAI Codex

| ด้าน | Claude Code | OpenAI Codex |
|------|-------------|--------------|
| **แนวทาง** | Proactive Planner | Shell-first Surgeon |
| **Workflow** | สแกน repo ก่อนแล้ว plan | เริ่มจาก lean context |
| **Memory** | ใช้ CLAUDE.md เป็น long-term memory | ใช้ AGENTS.md เป็น map |
| **Context Window** | 1M tokens | 200K tokens |
| **Token Usage** | ใช้มากกว่า 3.2-4.2 เท่า | ใช้น้อยกว่า แต่ thorough น้อยกว่า |
| **Agent Teams** | Coordinated agents | Cloud sandbox per task |
| **Isolation** | Git worktree per agent | Cloud sandbox |

### ตัวอย่าง: Token Usage ต่างกันอย่างไร?

```
งาน: Implement user authentication

Claude Code:
- Scan repo: 50K tokens
- Read CLAUDE.md: 10K tokens
- Plan: 5K tokens
- Implement: 30K tokens
- Test: 20K tokens
- Total: ~115K tokens

Codex:
- Read AGENTS.md: 5K tokens
- Implement: 20K tokens
- Test: 10K tokens
- Total: ~35K tokens

Ratio: Claude Code ใช้ token มากกว่า ~3.3 เท่า
```

**คำถาม:** แล้วควรเลือกอันไหน?

**คำตอบ:** ขึ้นอยู่กับงาน
- **Claude Code** — เหมาะกับงานที่ซับซ้อน ต้องการ thorough plan
- **Codex** — เหมาะกับงานเร็วๆ ไม่ซับซ้อนมาก

---

## 🛡️ Guardrails 3 ระดับ

Prompt ที่ดีต้องมี Guardrails — เหมือนรั้วที่ป้องกันไม่ให้ AI ทำผิด

### ตาราง: Guardrails 3 ระดับ

| ระดับ | ประเภท | ตัวอย่าง |
|-------|--------|---------|
| **Input** | Content filtering, Schema validation, Rate limiting | ห้าม prompt injection, ต้องเป็น JSON, จำกัด 10 requests/min |
| **Output** | Format validation, Factual grounding, Safety classifiers | ต้องมี type hints, ต้องอ้างอิงแหล่งที่มา, ห้าม generate harmful content |
| **Execution** | Tool call approval, Resource limits, Deadlock detection | ต้องขออนุญาตก่อน rm -rf, จำกัด CPU 50%, ตรวจจับ infinite loop |

### ตัวอย่างโค้ด: Guardrails ในทางปฏิบัติ

```python
class Guardrails:
    def validate_input(self, prompt: str) -> bool:
        # Input guardrails
        if len(prompt) > 10000:
            raise ValueError("Prompt too long")
        if "rm -rf" in prompt:
            raise ValueError("Dangerous command detected")
        return True
    
    def validate_output(self, code: str) -> bool:
        # Output guardrails
        if not self.has_type_hints(code):
            raise ValueError("Missing type hints")
        if not self.has_docstrings(code):
            raise ValueError("Missing docstrings")
        return True
    
    def validate_execution(self, tool_call: dict) -> bool:
        # Execution guardrails
        if tool_call['name'] == 'file_write':
            if not tool_call['path'].startswith('/safe/'):
                raise ValueError("Unsafe path")
        return True
```

---

## 🧠 Memory Systems 5 ประเภท

AI จำเป็นต้องมี Memory — แต่ไม่ใช่แค่ "จำได้ทุกเรื่อง" แต่ต้องจำอย่างมีระบบ

### ตาราง: Memory Systems 5 ประเภท

| ประเภท | หน้าที่ | ตัวอย่าง |
|--------|--------|---------|
| **System Memory** | ระบบพื้นฐาน | Rules, constraints, guardrails |
| **Session Memory** | ระหว่าง session | Conversation history, current task |
| **Project Memory** | โปรเจกต์ปัจจุบัน | CLAUDE.md, AGENTS.md, progress.md |
| **User Memory** | ความชอบผู้ใช้ | Coding style, preferences, patterns |
| **World Memory** | ความรู้ทั่วไป | Documentation, APIs, best practices |

### ตัวอย่าง: การใช้งาน Memory ในทางปฏิบัติ

```markdown
# CLAUDE.md (Project Memory)

## Project Overview
- Name: FastAPI Auth System
- Version: 1.0.0
- Python: 3.11+

## Coding Standards
- Type hints: Required
- Test coverage: 90%+
- Documentation: Google style

## Current Progress
- [x] User model
- [x] Authentication endpoint
- [ ] Authorization middleware
- [ ] Unit tests
```

---

## 🔄 Retry Logic 5 ระดับ

เมื่อ AI ทำผิด — จะทำอย่างไร?

### ตาราง: Retry Logic 5 ระดับ

| ระดับ | ประเภท | เมื่อไหร่ใช้ |
|-------|--------|-------------|
| **1. Simple Retry** | ลองใหม่เหมือนเดิม | Error ชั่วคราว (network timeout) |
| **2. Reformulated Retry** | ลองใหม่โดยปรับ prompt | Model เข้าใจผิด |
| **3. Model Fallback** | เปลี่ยนโมเดล | โมเดลปัจจุบันทำไม่ได้ |
| **4. Decomposition Retry** | แยกงานย่อย | งานซับซ้อนเกินไป |
| **5. Human Escalation** | ให้คนทำ | AI ทำไม่ได้จริงๆ |

### ตัวอย่างโค้ด: Retry Logic ในทางปฏิบัติ

```python
class RetryLogic:
    def execute_with_retry(self, task: str, max_retries: int = 5):
        for attempt in range(max_retries):
            try:
                # Level 1: Simple Retry
                result = self.model.execute(task)
                return result
            except TemporaryError:
                continue
            except MisunderstandingError:
                # Level 2: Reformulated Retry
                task = self.reformulate(task)
            except ModelCapabilityError:
                # Level 3: Model Fallback
                self.model = self.get_fallback_model()
            except ComplexityError:
                # Level 4: Decomposition Retry
                subtasks = self.decompose(task)
                results = [self.execute_with_retry(t) for t in subtasks]
                return self.combine(results)
        
        # Level 5: Human Escalation
        self.escalate_to_human(task)
```

---

## 👥 Sub-agent Isolation

เมื่อมีหลาย Agent — จะแยกกันอย่างไร?

### ตาราง: Codex vs Claude

| ด้าน | Codex | Claude |
|------|-------|--------|
| **Isolation** | Cloud sandbox per task | Git worktree per agent |
| **Communication** | ผ่าน API | อ่าน shared files ได้ |
| **State** | Stateless per task | Stateful across session |
| **Resource** | แยกชัดเจน | Shared แต่มี limits |

---

## 📝 สรุปตอนที่ 2

### สิ่งที่ได้เรียนรู้:

✅ **Prompt คือ Control Plane** — ไม่ใช่ Input Box แต่เป็น interface ควบคุมพฤติกรรม

✅ **Prompt Layering 3 ระดับ** — Orchestration, Runtime, Model Interface

✅ **สถิติ** — Harness-level changes ได้ 28-47% improvement (vs <3% จาก prompt engineering)

✅ **Claude Code vs Codex** — 2 แนวคิดต่างกัน (Proactive Planner vs Shell-first Surgeon)

✅ **Guardrails 3 ระดับ** — Input, Output, Execution

✅ **Memory Systems 5 ประเภท** — System, Session, Project, User, World

✅ **Retry Logic 5 ระดับ** — Simple → Reformulated → Fallback → Decomposition → Human

✅ **Sub-agent Isolation** — Cloud Sandbox vs Git Worktree

---

## 💡 บทเรียนจากประสบการณ์เหน่ง

### ช่วงแรก: ใช้ AI โดยไม่มี Harness

```
❌ ใส่ prompt สั้นๆ แล้วดูว่าได้อะไร
❌ "ช่วยเขียน Python script หน่อย"
❌ "สรุปข้อความนี้ให้หน่อย"
```

**ผลลัพธ์:** ได้มาบ้าง ไม่ได้บ้าง AI บางทีเขียนโค้ดผิด ต้องมานั่งแก้ไขเองเยอะ

### ปัจจุบัน: ใช้ Qwen (Alibaba) พร้อม Flow

```
✅ กำหนด Orchestration → "งานนี้ต้องทำอะไรบ้าง"
✅ กำหนด Runtime → "มีเงื่อนไขอะไรต้องระวัง"
✅ กำหนด Model Interface → "output ต้องออกมาในรูปแบบไหน"
```

**ผลลัพธ์:** **พอใจ 90%** — AI ให้สิ่งที่ต้องการมากขึ้น แก้ไขน้อยลง

> "Flow แล้ว" = มีขั้นตอนชัดเจน ไม่ใช่แค่ "ถามๆๆ ไปเรื่อย"

### การเดินทาง: ไม่มี Harness → มี Flow → มี Guardrails

```
Stage 1: ไม่มี Harness
- ใช้ AI ตามใจ
- ผลลัพธ์ไม่แน่นอน
- เสียเวลาแก้ไขเยอะ

Stage 2: มี Flow
- มีขั้นตอนชัดเจน
- ผลลัพธ์ดีขึ้น
- เสียเวลาน้อยลง

Stage 3: มี Guardrails
- มีระบบป้องกัน
- ผลลัพธ์น่าเชื่อถือ
- เสียเวลาน้อยมาก
```

---

## 🔄 ตอนต่อไป: Harness Components — ระบบอวัยวะของ AI

ตอนนี้เราเข้าใจแล้วว่า:

- ✅ Prompt คือ Control Plane
- ✅ Prompt Layering มี 3 ระดับ
- ✅ Guardrails, Memory, Retry Logic สำคัญอย่างไร

**แล้ว Harness Components คืออะไร?**

Harness มี "อวัยวะ" หลายอย่างที่ทำงานร่วมกัน:

- **Control Plane** — Prompt ที่เราเพิ่งคุยกัน
- **Query Loop** — หัวใจที่สูบฉีดงาน
- **Tools & Permissions** — มือที่ทำงาน
- **Memory & Context** — สมองที่จำ
- **Recovery Paths** — ระบบภูมิคุ้มกัน

ในตอนต่อไป เราจะมาเจาะลึกแต่ละ "อวัยวะ" ว่าทำงานอย่างไร และทำไมต้องมี

ติดตามตอนต่อไปได้เลย 🚀

---

## 📚 อ้างอิง

### แหล่งหลัก:

**Harness Books 2 เล่ม โดย wquguru**
- Book 1: [Claude Code Harness](https://github.com/wquguru/harness-books/blob/main/book1-claude-code/index.md)
- Book 2: [Claude Code vs Codex](https://github.com/wquguru/harness-books/blob/main/book2-comparing/index.md)
- Online Version: [harness-books.agentway.dev](https://harness-books.agentway.dev/book1-claude-code/)

### แหล่งเสริม:

1. Stanford HAI - Prompt Engineering Limitations (2025)
2. Morph LLM - [Codex vs Claude Code Benchmarks](https://www.morphllm.com/comparisons/codex-vs-claude-code)
3. Anthropic - Constitutional AI
4. Google - Chain of Thought Prompting
5. OpenAI - Templatized Prompt Engineering
