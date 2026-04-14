---
title: "Harness Engineering ตอนที่ 5: Multi-Agent System - มีเพื่อนตรวจสอบ"
date: 2026-04-14T10:00:00+07:00
description: "เรียนรู้วิธีออกแบบระบบ Multi-Agent ที่ปลอดภัยและมีประสิทธิภาพ พร้อมตัวอย่างจาก OpenClaw, CoPaw และ Hermes Agent"
keywords:
  - Multi-Agent System
  - Harness Engineering
  - AI Agent
  - Subagents
  - OpenClaw
  - CoPaw
  - Hermes Agent
author: "เหน่ง (Nueng)"
tags: ['harness-engineering', 'multi-agent', 'openclaw', 'copaw', 'hermes-agent']
categories: ['Tutorial', 'AI']
partOfSeries: "Harness Engineering"
previous: "harness-engineering-4"
next: "harness-engineering-6"
image: "cover.jpg"
seriesNumber: 5
---

# Harness Engineering ตอนที่ 5: Multi-Agent System - มีเพื่อนตรวจสอบ

## ส่วนนำ: ทำไม AI ต้องมี "เพื่อน"?

ลองนึกภาพว่าคุณกำลังสร้างบ้านหลังหนึ่ง คุณจะจ้างช่างคนเดียวให้ทำทุกอย่าง — ตั้งเสา เดินสายไฟ ติดกระเบื้อง ทาสี — หรือจ้างทีมช่างที่แต่ละคนเชี่ยวชาญเฉพาะทาง?

คำตอบชัดเจนอยู่แล้วใช่ไหมครับ?

**ทีมช่างที่เชี่ยวชาญเฉพาะทางทำงานเร็วกว่า ดีกว่า และมีโอกาสผิดพลาดน้อยกว่า**

นี่แหละคือเหตุผลที่ **Multi-Agent System** กำลังเป็นที่นิยมในโลก AI แต่คำถามคือ — ถ้าให้ AI หลายตัวทำงานพร้อมกัน เราจะควบคุมพวกมันอย่างไรให้ไม่ชนกัน ไม่ทำงานซ้ำซ้อน และไม่ทำให้ระบบพังทั้งหมด?

ในตอนที่ 4 เราได้เรียนรู้ว่า **Tools & Permissions** คือ "ล็อคประตู" ที่กำหนดขอบเขตให้ AI ตัวเดียว ในตอนที่ 5 นี้ เราจะมาดูกันว่า เมื่อมี AI หลายตัวทำงานร่วมกัน เราต้องมี **"กฎบ้าน"** อะไรบ้าง

## Multi-Agent System คืออะไร?

### คำจำกัดความ

**Multi-Agent System (MAS)** คือระบบที่มี AI Agent หลายตัวทำงานร่วมกันเพื่อบรรลุเป้าหมายเดียวกัน แต่ละตัวอาจมีบทบาท ความรู้ และ Tools ที่แตกต่างกัน

ลองเปรียบเทียบให้เห็นภาพ:

| ระบบ | ลักษณะ | ตัวอย่าง |
|-------|--------|----------|
| **Single Agent** | AI ตัวเดียวทำทุกอย่าง | ChatGPT, Claude |
| **Multi-Agent** | AI หลายตัวทำงานร่วมกัน | OpenClaw Sub-agents, CoPaw, Hermes Agent |
| **Swarm** | AI จำนวนมากทำงานแบบกระจาย | AutoGen, CrewAI |

### ทำไมต้องใช้หลาย Agent?

**1. ความเชี่ยวชาญเฉพาะทาง (Specialization)**
- Writer Agent เขียนบทความได้ดี
- Researcher Agent หาข้อมูลได้เร็ว
- Reviewer Agent ตรวจสอบความถูกต้องได้ละเอียด

**2. ทำงานขนานได้ (Parallelization)**
- ส่งงานไปให้ 3 Agent ทำพร้อมกัน
- ลดเวลาจาก 30 นาที เหลือ 10 นาที

**3. ตรวจสอบและถ่วงดุล (Checks & Balances)**
- Agent ตัวหนึ่งสร้าง → Agent อีกตัวตรวจ
- ลดความผิดพลาดที่เกิดจาก bias ของ Agent เดียว

> [!tip] คำแนะนำ
> อย่าใช้ Multi-Agent เพราะ "ดูเท่" ใช้เมื่องานซับซ้อนจริงๆ และสามารถแบ่งหน้าที่ได้ชัดเจน

## โครงสร้าง Multi-Agent ที่พบบ่อย

### 1. Hierarchical Pattern - ลูกน้องมีหัวหน้า

โครงสร้างแบบลำดับชั้น มี Agent หลักคอยสั่งการ Agent รอง:

```
┌─────────────────┐
│  Manager Agent  │  ← ตัดสินใจ ประสานงาน รวมผล
└────────┬────────┘
         │
    ┌────┴────┬────────┐
    ▼         ▼        ▼
┌───────┐ ┌───────┐ ┌───────┐
│Writer │ │Research│ │Review │  ← ทำงานเฉพาะทาง
│Agent  │ │Agent  │ │Agent  │
└───────┘ └───────┘ └───────┘
```

**ข้อดี:** ควบคุมง่าย ไม่ชนกัน
**ข้อเสีย:** เป็นคอขวดถ้า Manager ช้า

### 2. Peer-to-Peer Pattern - เพื่อนร่วมงาน

Agent ทุกตัวเท่าเทียมกัน คุยกันโดยตรง:

```
    ┌───────┐
    │Agent A│ ←──→ Agent B
    └───┬───┘       ↑↓
        ↑↓       ┌───────┐
    ┌───────┐ ←──┤Agent C│
    │Agent D│    └───────┘
    └───────┘
```

**ข้อดี:** ยืดหยุ่น ไม่พึ่งตัวกลาง
**ข้อเสีย:** ซับซ้อน ติดตามยาก

### 3. Pipeline Pattern - สายพาน

งานไหลจาก Agent หนึ่งไปอีกตัว ตามลำดับ:

```
Research → Draft → Review → Publish
Agent      Agent   Agent    Agent
```

**ข้อดี:** ชัดเจน ตรวจสอบง่าย
**ข้อเสีย:** ถ้าตัวหนึ่งพัง ทั้งสายพานหยุด

### 4. Subagent Pattern - Agent ข้างใน Agent

Agent หลัก spawn Agent ย่อยออกมาทำงานชั่วคราว:

```
Main Agent
    └── Subagent 1 (จัดการ Task A)
    └── Subagent 2 (จัดการ Task B)
    └── Subagent 3 (จัดการ Task C)
```

**ข้อดี:** ประหยัด context แยกงานได้ชัด
**ข้อเสีย:** ต้องจัดการ lifecycle ของ subagent ให้ดี

## แพลตฟอร์มที่ใช้ Multi-Agent จริง

### OpenClaw: Sub-agent Pattern

OpenClaw ใช้รูปแบบ **Main Agent → Specialist Agents**:

```bash
# ใน OpenClaw มี Specialist Agents หลายตัว:
- writer     : เขียนเนื้อหา
- researcher : หาข้อมูล
- reviewer   : ตรวจสอบ
- coder      : เขียนโค้ด
```

**วิธีทำงาน:**
1. Main Agent วิเคราะห์คำขอจากผู้ใช้
2. เลือก Specialist Agent ที่เหมาะสม
3. รอผลลัพธ์กลับมา
4. ส่งต่อให้ Reviewer Agent (ถ้าจำเป็น)
5. สรุปผลตอบผู้ใช้

**การตั้งค่า Harness ใน OpenClaw:**
```json
{
  "agents": {
    "manager": {
      "role": "router",
      "allowed_agents": ["writer", "researcher", "reviewer"]
    },
    "writer": {
      "role": "content_creation",
      "tools": ["file:write", "web:search"],
      "sandbox": true
    },
    "reviewer": {
      "role": "quality_check",
      "tools": ["file:read"],
      "read_only": true
    }
  }
}
```

### CoPaw: AgentScope Framework

CoPaw สร้างบน **AgentScope** ซึ่งออกแบบมาสำหรับ Multi-Agent โดยเฉพาะ:

```python
# ตัวอย่าง AgentScope
import agentscope

@agentscope.agents.agent
class PlannerAgent:
    def reply(self, x):
        return self.model(x)

@agentscope.agents.agent
class ExecutorAgent:
    def reply(self, x):
        return self.execute(x)

# รันแบบ Pipeline
planner = PlannerAgent()
executor = ExecutorAgent()
result = executor(planner(task))
```

**จุดเด่นของ CoPaw:**
- รองรับหลาย channels พร้อมกัน (Telegram, Discord, DingTalk, Feishu)
- Agent แต่ละตัวมี memory ร่วมผ่าน vector database
- มี gateway คอยจัดการ routing อัตโนมัติ

### Hermes Agent: Isolated Subagents

Hermes Agent ใช้ **spawn isolated subagents** สำหรับ parallel workstreams:

```bash
# ใน Hermes สามารถ spawn subagent ได้
hermes agent spawn --task "research topic A" &
hermes agent spawn --task "research topic B" &
hermes agent spawn --task "research topic C" &
```

**จุดเด่น:**
- แต่ละ subagent มี context แยกกัน
- ใช้ `execute_code` เพื่อ collapse multi-step pipelines
- รองรับ MCP servers สำหรับต่อขยาย tools

## ความเสี่ยงของ Multi-Agent System

เมื่อมี AI หลายตัวทำงานร่วมกัน ความเสี่ยงไม่ได้เพิ่มแค่ทวีคูล — มันอาจเพิ่มแบบ **เอ็กซ์โพเนนเชียล**!

### 1. Coordination Failure - "ชนกัน"

Agent A สั่งให้ลบไฟล์ ขณะที่ Agent B กำลังอ่านไฟล์นั้นอยู่

**ผลลัพธ์:** ระบบ crash

### 2. Goal Drift - "เป้าหมายเบี่ยง"

Agent ตัวหนึ่งตีความเป้าหมายผิด แล้ว Agent ตัวอื่นๆ ก็ทำตามไปด้วย

**ผลลัพธ์:** งานเพี้ยนไปหมด

### 3. Echo Chamber - "ห้องสะท้อนเสียง"

Agent หลายตัวมี bias เหมือนกัน ตรวจสอบกันเองแต่ไม่เห็นข้อบกพร่อง

**ผลลัพธ์:** ความผิดพลาดผ่านการตรวจสอบ

### 4. Resource Contention - "แย่งกันใช้"

Agent หลายตัวพยายามเขียนไฟล์เดียวกันพร้อมกัน

**ผลลัพธ์:** ข้อมูลเสียหาย

### 5. Cascading Failures - "ลูกโซ่หลุด" (อีกครั้ง)

Agent ตัวหนึ่งผิดพลาด → ส่งข้อมูลผิดไปให้อีกตัว → ลามไปทั้งระบบ

**ผลลัพธ์:** ความเสียหายรุนแรง

## Best Practices สำหรับ Multi-Agent Harness

### 1. 🎯 Clear Role Definition - กำหนดบทบาทให้ชัด

ทุก Agent ต้องรู้ว่าตัวเองทำอะไร ไม่ทำอะไร และไม่ยุ่งเรื่องของ Agent อื่น

**ตัวอย่าง Role ที่ชัดเจน:**
```markdown
## Planner Agent
- หน้าที่: วางแผนและแบ่งงาน
- ทำได้: สร้าง checklist, เลือก agent ที่เหมาะสม
- ห้ามทำ: รันโค้ด, เขียนเนื้อหาโดยตรง

## Writer Agent
- หน้าที่: สร้างเนื้อหาตามแผน
- ทำได้: เขียนไฟล์, ค้นหาข้อมูล
- ห้ามทำ: ตัดสินใจเองว่าจะเขียนอะไร

## Reviewer Agent
- หน้าที่: ตรวจสอบคุณภาพ
- ทำได้: อ่านไฟล์, ให้ feedback
- ห้ามทำ: แก้ไขไฟล์โดยตรง
```

### 2. 🗣️ Standardized Communication - ภาษากลาง

Agent ทุกตัวต้องสื่อสารด้วยรูปแบบเดียวกัน

**ตัวอย่าง Message Format:**
```json
{
  "from": "writer_agent",
  "to": "reviewer_agent",
  "task_id": "article-2026-001",
  "type": "deliverable",
  "content": "...",
  "status": "ready_for_review"
}
```

### 3. 📝 Shared State Management - บอร์ดกลาง

Agent ทุกตัวต้องเห็นสถานะงานเดียวกัน

**เครื่องมือที่ใช้:**
- **Shared Memory**: vector database หรือ knowledge graph
- **Task Board**: บอร์ดที่แสดงสถานะแต่ละ task
- **Version Control**: เก็บทุกการเปลี่ยนแปลงแบบมี history

```json
{
  "task_board": {
    "task_001": {
      "status": "in_progress",
      "owner": "writer_agent",
      "dependencies": ["research_001"],
      "last_updated": "2026-04-14T10:00:00Z"
    }
  }
}
```

### 4. 🔒 Isolation Boundaries - กำแพงกั้น

แต่ละ Agent ต้องทำงานในขอบเขตของตัวเอง

**วิธีทำ:**
- **Sandbox ต่อ Agent**: แยก file system ให้แต่ละ agent
- **Tool Restrictions**: agent ตัวหนึ่งใช้ได้ไม่ใช่ว่าอีกตัวใช้ได้
- **Network Segmentation**: จำกัด egress/ingress ต่อ agent

```yaml
# Docker Compose สำหรับ Multi-Agent
services:
  writer:
    image: ai-agent
    volumes:
      - ./workspace/writer:/workspace
    network_mode: none  # ไม่มี internet
  
  researcher:
    image: ai-agent
    volumes:
      - ./workspace/research:/workspace
    networks:
      - limited-net
```

### 5. 🧪 Validation Gate - ด่านตรวจ

ก่อนส่งผลลัพธ์ออกไป ต้องผ่านการตรวจสอบ

**Checklist ก่อน Deliver:**
- [ ] ผลลัพธ์ตรงตาม format ที่กำหนด
- [ ] ไม่มีข้อมูลลับรั่วไหล
- [ ] ไม่มีคำสั่งอันตราย
- [ ] มีการอ้างอิงที่ถูกต้อง
- [ ] ผ่านการตรวจสอบจาก Reviewer Agent

### 6. ⏱️ Timeout & Circuit Breaker - ป้องกันแฮงค์

ถ้า Agent ตัวหนึ่งทำงานนานเกินไป ต้องมีกลไกหยุด

```json
{
  "orchestration": {
    "timeout_per_agent": 300,
    "max_retries": 3,
    "circuit_breaker": {
      "failure_threshold": 5,
      "recovery_time": 60
    }
  }
}
```

### 7. 👤 Human-in-the-Loop - คนตรวจสอบจุดสำคัญ

อย่าปล่อยให้ Multi-Agent ทำงานโดยไม่มีคนดูเลย

**จุดที่ควรมีคนตรวจ:**
- ก่อน deploy ผลลัพธ์สุดท้าย
- เมื่อ Agent ตัวหนึ่ง reject ผลงานของอีกตัว
- เมื่อมีการร้องขอ permissions ที่สูงขึ้น

## ตารางเปรียบเทียบแพลตฟอร์ม

| ฟีเจอร์ | OpenClaw | CoPaw | Hermes Agent |
|---------|----------|-------|--------------|
| **Pattern** | Sub-agents | AgentScope | Isolated Subagents |
| **Parallel** | จำกัด | เต็มรูปแบบ | Spawn ได้ไม่จำกัด |
| **Memory** | Shared vector DB | Shared memory | Cross-session recall |
| **Channels** | 8+ | 10+ | 15+ |
| **Sandbox** | มี | มี | มี |
| **MCP** | ไม่มี | ไม่มี | รองรับ |
| **Voice** | ไม่มี | มี | มี |

## สรุปบทความ

มาถึงตอนจบแล้วครับ! สรุปสิ่งที่ได้เรียนรู้วันนี้:

### สิ่งที่ได้เรียนรู้:

1. **Multi-Agent System คืออะไร** — ระบบที่มี AI หลายตัวทำงานร่วมกัน แต่ละตัวมีบทบาทเฉพาะทาง

2. **โครงสร้างหลัก 4 แบบ:**
   - Hierarchical — มีหัวหน้าคอยสั่งการ
   - Peer-to-Peer — เท่าเทียมกัน
   - Pipeline — งานไหลตามลำดับ
   - Subagent — Agent ข้างใน Agent

3. **แพลตฟอร์มจริง:**
   - **OpenClaw** — Main Agent → Specialist Agents
   - **CoPaw** — AgentScope framework, multi-channel
   - **Hermes Agent** — Spawn isolated subagents, MCP support

4. **ความเสี่ยงหลัก:**
   - Coordination Failure, Goal Drift, Echo Chamber
   - Resource Contention, Cascading Failures

5. **Best Practices 7 ข้อ:**
   - Clear Role Definition
   - Standardized Communication
   - Shared State Management
   - Isolation Boundaries
   - Validation Gate
   - Timeout & Circuit Breaker
   - Human-in-the-Loop

### การนำไปใช้:

จากประสบการณ์ของเหน่ง:
- เริ่มจาก **Single Agent** ก่อน ค่อยๆ เพิ่มเมื่องานซับซ้อนขึ้น
- กำหนด **role ให้ชัดเจน** ก่อน deploy
- ใช้ **sandbox แยก** สำหรับแต่ละ agent
- มี **validation gate** ก่อนส่งผลลัพธ์ออกไป

---

*บทความนี้เป็นส่วนหนึ่งของซีรีส์ "Harness Engineering" ซึ่งสำรวจแนวคิดและเทคนิคในการใช้ AI ให้เกิดประสิทธิภาพสูงสุด*

*ตอนที่ 1: [Harness Engineering ตอนที่ 1: ทำไม AI ต้องมี Harness?](/posts/harness-part-1/)*  
*ตอนที่ 2: [Harness Engineering ตอนที่ 2: Prompt คือ Control Plane (ไม่ใช่ Input Box)](/posts/harness-part-2/)*  
*ตอนที่ 3: [Harness Engineering ตอนที่ 3: Query Loop - หัวใจของระบบ](/posts/harness-part-3/)*  
*ตอนที่ 4: [Harness Engineering ตอนที่ 4: Tools & Permissions - กำหนดขอบเขต AI](/posts/harness-part-4/)*  
*ตอนที่ 5: [Harness Engineering ตอนที่ 5: Multi-Agent System - มีเพื่อนตรวจสอบ](/posts/harness-part-5/) (บทความนี้)*

---

*บทความนี้เป็นส่วนหนึ่งของซีรีส์ Harness Engineering จาก Code & Community Blog*

---

## 📚 อ้างอิง

1. OWASP. (2026). *OWASP Top 10 for Agentic Applications 2026*. https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026

2. AgentScope Team. (2026). *AgentScope Documentation — Multi-Agent Programming*. https://agentscope.readthedocs.io/

3. Nous Research. (2026). *Hermes Agent Documentation*. https://hermes-agent.nousresearch.com/docs

4. OpenClaw. (2026). *OpenClaw Documentation — Sub-agent Pattern*. https://docs.openclaw.ai/

5. Anthropic. (2025). *Building Effective Multi-Agent Systems*. https://www.anthropic.com/engineering/multi-agent

6. Microsoft Research. (2025). *AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation*. https://arxiv.org/abs/2308.08155

7. Google DeepMind. (2025). *Multi-Agent Reinforcement Learning: Fundamentals and Recent Advances*. https://deepmind.google/discover/blog/

8. Chip Huyen. (2025). *AI Engineering* (O'Reilly). บทที่ 9: Multi-Agent Systems and Orchestration.

9. Martin Fowler. (2025). *Patterns for Distributed Systems*. https://martinfowler.com/articles/patterns-of-distributed-systems.html

10. Amazon Web Services. (2025). *Best Practices for Multi-Agent AI Architectures*. https://aws.amazon.com/blogs/machine-learning/
