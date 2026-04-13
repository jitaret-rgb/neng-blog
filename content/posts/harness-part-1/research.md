# Harness Engineering Research - Part 1: ทำไม AI ต้องมี Harness?

## สรุปข้อมูลสำคัญ (Key Findings)

### 1. วิวัฒนาการ 3 ยุคของ AI Development
- **Prompt Engineering (2022-2024):** "What should I say?" - เชื่อว่าคุณภาพคำสั่งเป็นตัวกำหนดความสำเร็จ
- **Context Engineering (2025):** "What information should I provide?" - รู้ว่าข้อมูลใน context window สำคัญกว่า prompt
- **Harness Engineering (2026):** "What system should I build?" - ออกแบบระบบทั้งหมดที่จัดการ context

### 2. Harness คืออะไร?
Harness คือระบบซอฟต์แวร์ที่กำกับการทำงานของ AI Agent ไม่ใช่ตัว agent เอง แต่เป็นระบบที่จัดการ:
- Tools และการเชื่อมต่อ API
- Memory (working, session, long-term)
- Retries และ error handling
- Human approvals
- Context engineering
- Sub-agents orchestration

### 3. ทำไมต้องมี Harness?
- **Context Anxiety:** Agent มีแนวโน้มหยุดทำงานก่อนถึง context limit ทำให้งานไม่เสร็จ
- **Self-Evaluation Problem:** Agent มักประเมินผลงานตัวเองว่าดีเกินไป (overconfident)
- **Long-running Tasks:** งานที่ใช้เวลานานต้องการการจัดการ context และ state อย่างเป็นระบบ
- **Safety & Control:** ต้องมี guardrails เพื่อป้องกันการกระทำที่อาจก่อให้เกิดอันตราย

### 4. สถาปัตยกรรม 3-Agent ของ Anthropic
- **Planner:** วางแผนและแบ่งงานเป็นชิ้นเล็กๆ
- **Generator:** สร้างผลลัพธ์ตามแผน
- **Evaluator:** ประเมินคุณภาพและให้ feedback

### 5. สถิติสำคัญจาก OpenAI Experiment
- สร้างผลิตภัณฑ์จาก repo ว่าง → 1 ล้านบรรทัดใน 5 เดือน
- 1,500+ Pull Requests โดยทีม 3 คน → 3.5 PRs/คน/วัน
- เร็วกว่าเขียนเอง ~10 เท่า
- **หลักการสำคัญ:** "Humans steer. Agents execute."

### 6. 6 Core Components ของ Harness
1. **Tool Interface** - เชื่อมต่อ APIs, databases, code execution
2. **Memory Management** - จัดการ context หลายระดับ
3. **Context Curation** - เลือกข้อมูลที่ใส่ใน context window
4. **Workflow Orchestration** - แนะนำ agent ผ่าน task sequences
5. **Feedback Loops** - Validation, verification, safety filters
6. **Recovery Mechanisms** - จัดการเมื่อ agent ทำงานผิดพลาด

### 7. Guardrails สำคัญอย่างไร?
- **Prompt-Level:** คำสั่งใน system prompt เช่น "Never give medical advice"
- **Model-Level:** Toxicity filters, PII redaction, jailbreak detection
- **Action-Level:** Workflow boundaries เช่น "Can read but cannot send emails"

### 8. การเปรียบเทียบกับ OS
ตาม analogy ของ Philipp Schmid:
- Model = Raw processing capability (CPU)
- Context Window = Limited working memory (RAM)
- Harness = Operating System (จัดการ context, initialization, drivers)
- Agent = Application ที่รันบนระบบ

### 9. ปัญหาที่ Harness แก้ไข
- **Coherence Loss:** Agent สูญเสียความสามารถเมื่อ context เต็ม
- **Context Anxiety:** Agent หยุดทำงานก่อนถึง limit
- **Hallucination:** สร้างข้อมูลที่ไม่มีอยู่จริง
- **Tool Misuse:** ใช้เครื่องมือผิดวิธี

### 10. การยอมรับในอุตสาหกรรม
- OpenAI และ Anthropic ใช้คำว่า "Harness" อย่างเป็นทางการ
- Martin Fowler เขียนบทความเกี่ยวกับ Harness Engineering
- arXiv paper ที่ formalize แนวคิดนี้
- ไม่ใช่แค่ buzzword แต่เป็น architectural layer ที่ขาดหายไป

### 11. ความแตกต่างระหว่าง SDK/Framework/Scaffolding vs Harness
- **SDKs/Frameworks:** ตอบคำถาม "How do you build an AI Agent?"
- **Harness:** ตอบคำถาม "How does the agent run?"
- Harness อยู่ layer ที่สูงกว่า ไม่ใช่ replacement แต่เป็น layer ที่เพิ่มเข้ามา

### 12. Context Reset vs Compaction
- **Compaction:** สรุป context เดิมให้สั้นลง → agent เดิมทำงานต่อ
- **Context Reset:** ล้าง context ทั้งหมด เริ่ม agent ใหม่พร้อม handoff artifact
- Reset ดีกว่าสำหรับ long-running tasks แต่มี overhead สูงกว่า

### 13. Repository as System of Record
- OpenAI ทำให้ repository knowledge เป็นแหล่งข้อมูลหลัก
- Agent อ่าน AGENTS.md, skills, documentation จาก repo
- ไม่ต้อง copy-paste context เข้า CLI

### 14. Agent Legibility
- เป้าหมายคือทำให้ agent เข้าใจสภาพแวดล้อมได้
- ข้อมูลต้องถูก encode เป็น markdown ใน codebase
- ทำให้ agent ทำงานได้อย่าง reliable

### 15. อนาคตของ Software Engineering
- งานหลักของ engineer เปลี่ยนจาก "เขียน code" เป็น "ออกแบบสภาพแวดล้อม"
- สร้าง feedback loops ที่ agent ทำงานได้อย่าง reliable
- Engineering rigor ไม่ได้หายไป แต่ย้ายไปอยู่ที่ระดับ abstraction สูงขึ้น

---

## แหล่งอ้างอิง (References)

### บทความหลัก
1. **OpenAI - Harness Engineering** (Feb 2026)
   - https://openai.com/index/harness-engineering/
   - ทดลองสร้างผลิตภัณฑ์ด้วย 0 บรรทัด code ที่เขียนเอง

2. **Anthropic - Harness Design for Long-Running Apps** (2026)
   - https://www.anthropic.com/engineering/harness-design-long-running-apps
   - 3-agent architecture: Planner, Generator, Evaluator

3. **Anthropic - Effective Harnesses for Long-Running Agents**
   - https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
   - Context resets และ context anxiety

4. **Cobus Greyling - The Rise of AI Harness Engineering**
   - https://cobusgreyling.substack.com/p/the-rise-of-ai-harness-engineering
   - อธิบายว่า harness คือ OS สำหรับ agent

5. **Bits & Bytes - From Prompts to Harnesses**
   - https://bits-bytes-nn.github.io/insights/agentic-ai/2026/04/05/evolution-of-ai-agentic-patterns-en.html
   - วิวัฒนาการ 3 ยุคของ AI development

6. **arXiv - Natural-Language Agent Harnesses**
   - https://arxiv.org/abs/2603.05344
   - รายงานทางวิชาการที่ formalize harness engineering

7. **Martin Fowler - Harness Engineering**
   - https://martinfowler.com/articles/exploring-gen-ai/harness-engineering.html
   - ผู้เชี่ยวชาญด้าน software architecture

### ข้อมูลเพิ่มเติม
8. **Anthropic - Effective Context Engineering** (Sep 2025)
   - https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents

9. **InfoQ - Anthropic Three-Agent Harness**
   - https://www.infoq.com/news/2026/04/anthropic-three-agent-harness-ai/

10. **Parallel.ai - What is an Agent Harness**
    - https://parallel.ai/articles/what-is-an-agent-harness

---

## สถิติสำคัญ (Key Statistics)

| สถิติ | ค่า | แหล่งที่มา |
|-------|-----|-----------|
| จำนวนบรรทัด code ที่สร้าง | ~1 ล้านบรรทัด | OpenAI Experiment |
| เวลาที่ใช้ | 5 เดือน | OpenAI Experiment |
| PRs ที่ merge | 1,500+ | OpenAI Experiment |
| ทีม engineer | 3 → 7 คน | OpenAI Experiment |
| Throughput | 3.5 PRs/คน/วัน | OpenAI Experiment |
| ความเร็วเทียบกับเขียนเอง | ~10x faster | OpenAI Experiment |
| ผู้ใช้ภายใน | หลายร้อยคน | OpenAI Experiment |
| GitHub Copilot users (2024) | 20 ล้านคน | GitHub |
| Copilot paid subscribers | 4.7 ล้านคน | GitHub |
| Fortune 100 adoption | 90% | GitHub |

---

## ข้อมูลที่ต้องมีในบทความ

### ส่วนที่ 1: Hook & Problem
- เปรียบเทียบ AI Agent กับม้าที่มีพลังแต่ต้องการควบคุม
- ปัญหา: Agent ที่ไม่มี harness = อันตราย

### ส่วนที่ 2: วิวัฒนาการ 3 ยุค
- Prompt → Context → Harness Engineering
- ทำไมแต่ละยุคถึง fail และต้องพัฒนาต่อ

### ส่วนที่ 3: Harness คืออะไร?
- นิยามที่ชัดเจน
- 6 core components
- เปรียบเทียบกับ OS

### ส่วนที่ 4: ตัวอย่างจาก OpenAI
- ทดลองสร้างผลิตภัณฑ์ด้วย agent ล้วน
- สถิติที่น่าสนใจ
- "Humans steer. Agents execute."

### ส่วนที่ 5: สถาปัตยกรรม 3-Agent
- Planner, Generator, Evaluator
- ทำไมต้องแยก evaluator

### ส่วนที่ 6: Guardrails & Safety
- 3 levels ของ guardrails
- ตัวอย่างความผิดพลาดที่เกิดขึ้นได้

### ส่วนที่ 7: สรุป & Preview
- Harness ไม่ใช่ optional แต่เป็น essential
- Preview ตอนต่อไป

---

## ตัวอย่างจริงที่เข้าใจง่าย (Real-World Examples)

### 1. ม้ากับอาน (Horse & Saddle)
** analogy:** AI Model คือม้าที่มีพลังมหาศาล สามารถวิ่งเร็วและแรง แต่ถ้าไม่มีอาน (harness) คนขี่จะตกและได้รับอันตราย

**ในทางเทคนิค:**
- Model (ม้า) = ความสามารถในการประมวลผล
- Harness (อาน) = ระบบควบคุมทิศทางและความปลอดภัย
- Agent (คนขี่) = งานที่ต้องการทำ

### 2. รถยนต์กับระบบขับเคลื่อน
**analogy:** เครื่องยนต์มีพลังแต่ต้องมีระบบส่งกำลัง, เบรก, และพวงมาลัย

**ในทางเทคนิค:**
- เครื่องยนต์ = Model
- ระบบส่งกำลัง + ควบคุม = Harness
- การขับขี่ = Agentic workflow

### 3. นักเรียนกับระบบการศึกษา
**analogy:** นักเรียนมีความสามารถเรียนรู้ แต่ต้องมีหลักสูตร, ครู, การสอบ, และการประเมิน

**ในทางเทคนิค:**
- นักเรียน = Model
- หลักสูตร + ครู + การสอบ = Harness
- การเรียนรู้ = Agentic task

### 4. OpenAI Experiment - สร้างผลิตภัณฑ์จริง
**สถานการณ์:** ทีม 3 คนสร้าง software product จาก repo ว่างเปล่า โดยไม่เขียน code เองสักบรรทัด

**ผลลัพธ์:**
- 1 ล้านบรรทัด code ใน 5 เดือน
- 1,500+ PRs
- ใช้งานจริงโดยพนักงานหลายร้อยคน

**ความลับ:** ทีมไม่ได้บอก agent ว่า "ทำอะไร" แต่สร้างระบบ (harness) ที่ agent ทำงานได้อย่าง reliable

### 5. Claude Code - Frontend Design Skill
**สถานการณ์:** ให้ Claude ออกแบบ UI โดยไม่มี harness

**ผลลัพธ์:**
- ออกแบบได้แต่ไม่สม่ำเสมอ
- ขาดเกณฑ์การประเมินที่ชัดเจน

**หลังเพิ่ม Harness:**
- เพิ่ม Evaluator Agent ที่มี criteria ชัดเจน
- ผลลัพธ์สม่ำเสมอขึ้นมาก

### 6. Context Anxiety - อาการกลัว context เต็ม
**สถานการณ์:** Agent กำลังทำงานยาวนาน 2-3 ชั่วโมง

**อาการ:**
- Agent เริ่มรีบทำงานให้เสร็จ
- ข้ามขั้นตอนสำคัญ
- สรุปว่า "เสร็จแล้ว" ทั้งที่ยังไม่เสร็จ

**เหตุผล:** Agent "กลัว" ว่า context จะเต็ม

**วิธีแก้ (Anthropic):** Context Reset - เริ่ม agent ใหม่พร้อม handoff artifact

### 7. AutoGPT - ตัวอย่างที่ไม่มี Harness ที่ดี
**สถานการณ์:** Agent ที่ได้รับความนิยมมากในปี 2023

**ปัญหา:**
- ทำงานไปเรื่อยๆ โดยไม่มีการควบคุม
- ใช้ API ค่าใช้จ่ายสูง
- ผลลัพธ์ไม่ reliable

**สาเหตุ:** ขาด harness ที่มี feedback loops และ guardrails

### 8. Claude Code with Skills - ตัวอย่างที่มี Harness
**สถานการณ์:** ใช้ SKILL.md เป็น harness สำหรับงานเฉพาะ

**ผลลัพธ์:**
- Agent ทำงานได้อย่าง consistent
- สามารถทำงานซ้ำๆ ได้ reliably
- ถ่ายโอนความรู้ระหว่าง projects

---

## คำศัพท์สำคัญ (Key Terminology)

| คำศัพท์ | ความหมาย |
|---------|----------|
| **Harness** | ระบบที่กำกับการทำงานของ AI Agent |
| **Context Window** | หน่วยความจำชั่วคราวที่ model สามารถเข้าถึงได้ |
| **Context Anxiety** | อาการที่ agent รีบจบงานเพราะกลัว context เต็ม |
| **Context Reset** | การล้าง context และเริ่ม agent ใหม่ |
| **Context Compaction** | การสรุป context เดิมให้สั้นลง |
| **Guardrails** | ข้อจำกัดความปลอดภัยสำหรับ agent |
| **Agent Legibility** | ความสามารถของ agent ในการเข้าใจสภาพแวดล้อม |
| **Feedback Loop** | วงจรการประเมินและปรับปรุง |
| **Orchestration** | การประสานงานระหว่าง agents หลายตัว |
| **Handoff Artifact** | ข้อมูลที่ส่งต่อระหว่าง agent sessions |

---

## บันทึกการวิจัย

**วันที่วิจัย:** 2026-04-13
**Researcher:** Mick (AI Agent)
**หัวข้อ:** Harness Engineering - Why AI Needs a Harness

### แหล่งข้อมูลหลักที่ใช้:
1. OpenAI Engineering Blog
2. Anthropic Engineering Blog
3. arXiv papers
4. Substack articles (Cobus Greyling)
5. Technical blogs

### คุณภาพข้อมูล:
- ✅ มีแหล่งที่มาชัดเจน (OpenAI, Anthropic)
- ✅ มี arXiv paper รองรับทางวิชาการ
- ✅ มี Martin Fowler ยืนยันแนวคิด
- ✅ มีตัวเลขและสถิติจากการทดลองจริง

### ความน่าเชื่อถือ:
- **สูงมาก** - มาจากบริษัทที่พัฒนา AI ชั้นนำ
- **มีหลักฐาน** - มีการทดลองและสถิติรองรับ
- **เป็นที่ยอมรับ** - มีผู้เชี่ยวชาญหลายคนเขียนถึง

---

*บันทึกนี้จัดทำขึ้นเพื่อใช้เป็นแหล่งอ้างอิงสำหรับบทความ "Harness Engineering ตอนที่ 1: ทำไม AI ต้องมี Harness?"*