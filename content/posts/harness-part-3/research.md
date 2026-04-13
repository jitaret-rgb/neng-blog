# Research: Harness Engineering ตอนที่ 3 - Query Loop

> วันที่: 2026-04-13
> หัวข้อ: Query Loop - หัวใจของระบบ Agent

---

## 1. สรุปข้อมูลสำคัญ (10-15 ข้อ)

### 1.1 Query Loop คืออะไร

จาก Harness Books Book 1 บทที่ 3:

1. **Query Loop ไม่ใช่แค่การ "ถาม-ตอบ"** - แต่เป็น "การทำงานแบบต่อเนื่องที่มีสถานะ" (continuous execution with state)
2. **หัวใจของระบบ Agent** - อยู่ที่ `queryLoop()` ใน Claude Code (src/query.ts:241) ไม่ใช่แค่ `query()` (src/query.ts:219)
3. **State Management** - Query Loop รักษาสถานะข้ามรอบ: messages, toolUseContext, autoCompactTracking, turnCount, transition
4. **Lifecycle Management** - ระบบ Agent แท้จริงต้องรู้ว่า "หลังจากรอบนี้ รอบต่อไปจะทำอย่างไร"
5. **Pre-processing สำคัญกว่า Model Call** - Claude Code ทำ context governance ก่อนเรียก model: memory prefetch, skill discovery, history snip, microcompact, context collapse

### 1.2 Query Loop vs Prompt ปกติ

6. **Prompt Engineering** = ตั้งค่าครั้งเดียว หวังผลดี
7. **Query Loop** = ระบบที่ปรับตัวได้ตลอดการทำงาน จัดการ error, recovery, interrupt
8. **ความแตกต่างหลัก**: Prompt เป็นข้อความนิ่ง Query Loop เป็นกระบวนการไดนามิกที่มี feedback loop

### 1.3 Claude Code vs Codex (จาก Harness Books Book 2 บทที่ 3)

9. **Claude Code**: ให้ความสำคัญกับ Runtime Heartbeat - Query Loop เป็นศูนย์กลาง จัดการปัญหาเฉพาะหน้าได้ดี ("field firefighter")
10. **Codex**: ให้ความสำคัญกับ Persisted Session Substrate - มีโครงสร้าง Thread, Rollout, State ชัดเจน ("dispatch center with archives")
11. **Claude Code**: สถานะอยู่ใน Query Loop (src/query.ts)
12. **Codex**: สถานะกระจายใน codex_thread, thread_manager, rollout, state_db_bridge, message_history

### 1.4 Best Practices สำหรับ Query Loop

13. **Circuit Breaker** - ป้องกัน tool ที่พังทำให้เกิด infinite loop เผาทรัพยากร
14. **Retry-Classify** - ไม่ retry แบบ blind แต่ classify error ก่อน: RateLimit → backoff, Validation → repair, Auth → fail-fast
15. **Budget Governors** - กำหนด limit: maxTokens, maxToolCalls, maxCost, maxDuration

---

## 2. แหล่งอ้างอิง

### หนังสือหลัก (Harness Books)
- **Book 1 บทที่ 3**: https://github.com/wquguru/harness-books/blob/main/book1-claude-code/chapter-03-query-loop-heartbeat.md
- **Book 2 บทที่ 3**: https://github.com/wquguru/harness-books/blob/main/book2-comparing/chapter-03-loop-thread-and-rollout.md
- **เว็บไซต์ Harness Books**: https://harness-books.agentway.dev/

### บทความสำคัญ
- **Martin Fowler - Harness Engineering**: https://martinfowler.com/articles/harness-engineering.html
- **OpenAI - Harness Engineering**: https://openai.com/index/harness-engineering/
- **Victor Dibia - Agent Execution Loop**: https://newsletter.victordibia.com/p/the-agent-execution-loop-how-to-build

### Best Practices & Patterns
- **7 Patterns for Production Agents**: https://dev.to/pockit_tools/7-patterns-that-stop-your-ai-agent-from-going-rogue-in-production-5hb1
- **Common AI Agent Mistakes**: https://www.wildnetedge.com/blogs/common-ai-agent-development-mistakes-and-how-to-avoid-them

### OpenClaw Documentation
- **Sub-Agents**: https://docs.openclaw.ai/tools/subagents

---

## 3. สถิติสำคัญ

| สถิติ | แหล่งที่มา |
|-------|-----------|
| OpenAI สร้างโค้ด 1 ล้านบรรทัดใน 5 เดือน ด้วย Codex | OpenAI Harness Engineering |
| 1,500+ PRs จากทีม 3 คน → เฉลี่ย 3.5 PRs/คน/วัน | OpenAI Harness Engineering |
| 69% ของการตัดสินใจ AI Agent ยังต้องมี human verify | MindStudio |
| Agent ที่มี Harness ถูกต้อง vs ไม่มี: 100% vs 50% | Medium - Harness Engineering |
| Token budget ที่แนะนำ: Production 20,000 tokens/session | DEV Community |
| Cost limit แนะนำ: Production $0.50/session | DEV Community |
| Timeout แนะนำ: Production 2 นาที | DEV Community |

---

## 4. ข้อมูลที่ต้องมีในบทความ

### ส่วนที่ 1: อธิบาย Query Loop
- [ ] นิยาม Query Loop และทำไมไม่ใช่แค่ "ถาม-ตอบ"
- [ ] สถานะ (State) ที่ Query Loop ต้องจัดการ
- [ ] ความแตกต่างระหว่าง Query Loop กับ Prompt ธรรมดา

### ส่วนที่ 2: สถาปัตยกรรม Query Loop
- [ ] Claude Code approach: Runtime-centric
- [ ] Codex approach: State-centric
- [ ] เปรียบเทียบข้อดีข้อเสีย

### ส่วนที่ 3: OpenClaw + Query Loop
- [ ] วิธี OpenClaw จัดการ Query Loop ผ่าน sessions_spawn
- [ ] Sub-agent pattern ใน OpenClaw
- [ ] การส่งต่องาน (delegation) แบบ push-based

### ส่วนที่ 4: Best Practices
- [ ] Circuit Breaker pattern
- [ ] Retry-Classification
- [ ] Budget Governors
- [ ] Output Guardrails
- [ ] Kill Switch

### ส่วนที่ 5: ข้อผิดพลาดที่พบบ่อย
- [ ] God Agent (ทำทุกอย่างใน agent เดียว)
- [ ] ไม่มีการจัดการ state ระยะยาว
- [ ] ไม่มี guardrails
- [ ] Infinite loop ไม่มี budget limit
- [ ] ไม่มี error recovery strategy

---

## 5. ตัวอย่างจริงที่เข้าใจง่าย

### ตัวอย่าง 1: ร้านอาหาร (Analogy)
```
Prompt Engineering = เมนูอาหารที่เขียนไว้
Query Loop = พนักงานเสิร์ฟที่:
- รับ order (input)
- เช็คว่าอาหารหมดไหม (tool call)
- ถ้าหมด แนะนำอย่างอื่น (recovery)
- ถ้าลูกค้าเปลี่ยนใจกลางทาง (interrupt) จัดการได้
- จำว่าเคยสั่งอะไรไปแล้ว (state)
```

### ตัวอย่าง 2: OpenClaw Sub-agent Pattern (จากเอกสารจริง)
```
Main Agent (เหน่ง) ต้องการ Research
→ sessions_spawn() ส่งงานให้ Researcher Agent
→ Researcher Agent ทำงานแยก session
→ เมื่อเสร็จ ประกาศผลกลับมาอัตโนมัติ (push-based)
→ Main Agent รับผลและสรุปให้เหน่ง

ข้อดี: ไม่ต้องรอ (non-blocking) ทำงานอื่นได้
ข้อดี: แยก context ไม่ปะปนกัน
ข้อดี: ควบคุม cost ได้ (เลือก model ถูกๆ ให้ sub-agent)
```

### ตัวอย่าง 3: Claude Code Query Loop Flow
```
1. Pre-processing:
   - Prefetch memory
   - Skill discovery
   - History snip (ตัดข้อความเก่าที่ไม่จำเป็น)
   - Microcompact (บีบอัด context)

2. Model Call (Streaming):
   - รับ output เป็น event stream ไม่ใช่คำตอบสำเร็จรูป
   - ถ้ามี tool_use → ไป execute tool
   - ถ้าข้อความยาวเกิน → trigger compact

3. Post-processing:
   - บันทึกผล
   - ตรวจสอบว่าต้องทำต่อไหม (follow-up)
   - จัดการ interrupt ถ้ามี
```

### ตัวอย่าง 4: เปรียบเทียบ Claude Code vs Codex
```
สถานการณ์: Agent ทำงาน 6 ชั่วโมงแล้วพังตอนท้าย

Claude Code:
- Query Loop จัดการ recovery ทันที
- Reactive compact ลด context
- ลองใหม่จากจุดที่พัง
- ข้อเสีย: ถ้าปิดโปรแกรม สูญเสีย state

Codex:
- Thread มี ID ติดตามได้
- Rollout บันทึกทุก event
- State อยู่ใน database
- สามารถ resume จากจุดที่ค้างได้
- ข้อเสีย: ซับซ้อนกว่า ต้องมี infrastructure
```

---

## 6. ประสบการณ์ OpenClaw (จาก Context)

### 6.1 การใช้ Query Loop กับ OpenClaw
- OpenClaw ใช้ `sessions_spawn` เป็น core mechanism สำหรับ sub-agents
- แต่ละ sub-agent มี session แยก: `agent:<id>:subagent:<uuid>`
- ผลลัพธ์ส่งกลับแบบ push-based (announce) ไม่ใช่ polling
- รองรับ nested sub-agents (max depth 5, แนะนำ depth 2)

### 6.2 ปัญหาที่พบและวิธีแก้

| ปัญหา | วิธีแก้ |
|-------|---------|
| Sub-agent ไม่ spawn | ตรวจสอบ tool exposure - sessions_spawn ต้อง expose ให้ agent |
| ไม่รู้ว่า sub-agent เสร็จยัง | ใช้ push-based completion ไม่ต้อง poll เอง |
| Cost สูง | ตั้งค่า model ถูกกว่าให้ sub-agent ผ่าน `agents.defaults.subagents.model` |
| Context ปะปน | แยก session ชัดเจน sub-agent ไม่เห็น SOUL.md/IDENTITY.md |
| Infinite spawn | จำกัดด้วย `maxSpawnDepth` และ `maxChildrenPerAgent` |

### 6.3 ข้อดีของ OpenClaw Query Loop
- ไม่ต้อง poll รอ - push-based completion
- ควบคุม cost ได้ (เลือก model ต่างกันระหว่าง main/sub)
- แยก context/security ชัดเจน
- รองรับ thread-bound sessions (Discord)

---

## 7. คำศัพท์สำคัญ (Thai-English)

| ไทย | อังกฤษ | ความหมาย |
|-----|--------|---------|
| ลูปการสืบค้น | Query Loop | กระบวนการทำงานต่อเนื่องของ Agent |
| สถานะ | State | ข้อมูลที่ Agent จำได้ระหว่างรอบ |
| การกู้คืน | Recovery | การแก้ไขเมื่อเกิดข้อผิดพลาด |
| การตัดกระแส | Circuit Breaker | หยุดทำงานเมื่อ tool พัง เพื่อป้องกัน loop |
| การจัดงบ | Budget Governor | จำกัด token/cost/time |
| การทำงานแบบสตรีม | Streaming | รับผลลัพธ์ทีละส่วน ไม่รอทั้งหมด |
| การบีบอัด | Compact | ลดขนาด context ที่ส่งให้ model |
| เอเจนต์ย่อย | Sub-agent | Agent ที่ถูก spawn จาก agent หลัก |
| การส่งต่องาน | Delegation | ให้ sub-agent ทำงานแทน |
| การผูกเธรด | Thread Binding | ผูก session กับ channel thread |
| การตรวจสอบผลลัพธ์ | Verification | ตรวจสอบว่า Agent ทำถูกต้อง |
| การหยุดฉุกเฉิน | Kill Switch | หยุด Agent ทันทีในกรณีฉุกเฉิน |

---

## 8. โครงสร้างบทความที่แนะนำ

```
1. บทนำ: ทำไม Query Loop สำคัญ
2. Query Loop คืออะไร (อธิบายแบบง่าย)
3. ความแตกต่างระหว่าง Prompt vs Query Loop
4. สถาปัตยกรรม Query Loop ใน Claude Code vs Codex
5. Query Loop ใน OpenClaw (ประสบการณ์จริง)
6. Best Practices: 7 Patterns สำหรับ Production
7. ข้อผิดพลาดที่พบบ่อยและวิธีแก้
8. สรุป
```

---

*Research นี้จัดทำโดย Researcher Agent สำหรับบทความ Harness Engineering ตอนที่ 3*