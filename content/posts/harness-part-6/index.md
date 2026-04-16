---
title: "Harness Engineering ตอนที่ 6: Recovery Paths - แผนสำรองเมื่อ AI พัง"
date: 2026-04-14T12:00:00+07:00
lastUpdated: 2026-04-14
description: "เรียนรู้วิธีออกแบบระบบ AI ที่สามารถกู้ตัวเองได้เมื่อเกิดความผิดพลาด ด้วย Retry Logic, Circuit Breaker และ Fallback Strategies"
keywords:
  - Recovery Paths
  - Harness Engineering
  - AI Agent
  - Retry Logic
  - Circuit Breaker
  - Fallback
author: "เหน่ง (Nueng)"
tags: ['harness-engineering', 'recovery-paths', 'retry', 'circuit-breaker', 'fallback']
categories: ['Tutorial', 'AI']
partOfSeries: "Harness Engineering"
previous: "harness-part-5"
next: "harness-part-7"
image: "cover.jpg"
seriesNumber: 6
draft: false
---

---

## บทนำ: ทำไมต้องมี Recovery Paths?

สมมติว่าคุณกำลังสร้าง AI Agent สำหรับระบบ Customer Support ที่ทำงาน 24/7 วันหนึ่ง API ของ LLM ล่ม ระบบก็หยุดทันที ลูกค้าไม่ได้คำตอบ ธุรกิจเสียโอกาส

นี่คือสิ่งที่เกิดขึ้นเมื่อเราไม่มี Recovery Paths

AI Systems มีจุดล้มเหลวหลายจุดมากกว่าซอฟต์แวร์ทั่วไป:

- **Model API failures** — Rate limits, timeouts, outages
- **Tool/Function calling errors** — External API ที่เราเรียกใช้พัง
- **Context window exceeded** — Prompt ยาวเกินไป
- **Invalid output format** — AI สร้าง output ที่ไม่ตรงตาม schema (hallucinations)
- **Dependency failures** — Database, cache, หรือ services อื่นๆ ที่ระบบต้องการ

ถ้าเราออกแบบระบบโดยคิดว่าทุกอย่างจะทำงานได้ตลอดเวลา วันหนึ่งมันจะล้มเหลวในจุดที่เราไม่คาดคิด

**Recovery Paths คืออะไร?**

คือ "แผนสำรอง" ที่เราวางไว้ล่วงหน้า เมื่อระบบหลักทำงานไม่ได้ แผนสำรองจะเข้ามาทำงานแทน ไม่ใช่เพื่อให้ระบบสมบูรณ์แบบ 100% แต่เพื่อให้ระบบ "ยังใช้งานได้" แม้จะลดความสามารถลงบ้าง

จากหลักการ **Graceful Degradation** — ลดความสามารถลงอย่างมีระดับ แทนที่จะล่มสิ้นเลย

```
Full AI Response → Simplified AI Response → Rule-Based Response → Human Handoff
```

บทความนี้จะพาคุณไปรู้จักกับ 4 เรื่องหลัก:

1. ประเภทของ Recovery (Auto vs Manual)
2. Fallback Strategies
3. Retry Logic
4. Circuit Breaker Pattern

---

## ประเภทของ Recovery: Auto vs Manual

### Auto-Recovery (Self-Healing)

ลองนึกภาพ AI Agent ที่สามารถ "รู้ตัว" ว่าตัวเองทำผิด แล้วแก้ไขตัวเองได้ นี่คือ Self-Healing Agent Pattern

**กระบวนการ 4 ขั้นตอน:**

| Stage | Action |
|-------|--------|
| 1. Validation | ตรวจสอบว่า output ตรงตามที่ต้องการ |
| 2. Failure Detection | จำแนกประเภท failure |
| 3. Contextual Recovery | ใช้ recovery strategy ที่เหมาะสม |
| 4. Learning Integration | บันทึกเพื่อปรับปรุงในอนาคต |

**ตัวอย่าง Failure Classification และ Recovery:**

| Failure Type | Recovery Action |
|--------------|-----------------|
| Input corruption | ขอข้อมูลใหม่หรือ clean data |
| Context starvation | ขอข้อมูลเพิ่มเติม |
| Tool failure | Retry หรือใช้ tool ทางเลือก |
| Reasoning collapse | รีเซ็ตไปยัง state ล่าสุดที่ใช้ได้ |
| Output corruption | สร้างใหม่ด้วย parameter ต่างกัน |

Auto-Recovery เหมาะกับ:
- Transient errors (errors ที่เกิดชั่วคราวแล้วหายไป)
- Rate limits
- Timeout ที่เกิดจากภาระงานสูง
- Tool errors ที่มี fallback ชัดเจน

### Manual Recovery

บางครั้งเราต้องให้คนเข้ามาช่วย

**เมื่อไหร่ควรใช้ Manual Recovery:**

- **Critical failures** — ที่ต้องการ human judgment เช่น ข้อมูลผิดพลาดร้ายแรง
- **Security/Compliance issues** — ปัญหาด้านความปลอดภัย
- **First-time failures** — ที่ยังไม่มี pattern ในการแก้ไขอัตโนมัติ
- **Business-critical decisions** — ที่ต้องมีคนตัดสินใจ

**กระบวนการ Manual Recovery:**

1. รับการแจ้งเตือน (alert)
2. วิเคราะห์สาเหตุ (root cause analysis)
3. ตัดสินใจแก้ไข
4. ดำเนินการ recovery
5. บันทึกบทเรียน

### Hybrid Approach — ทางเลือกที่ดีที่สุด

ในความเป็นจริง ระบบส่วนใหญ่ควรใช้ **Hybrid Approach** — ทำบางอย่างอัตโนมัติ บางอย่างให้คนตัดสินใจ

**สิ่งที่ควรทำอัตโนมัติ:**
- Transient error retries
- Fallback ไปยัง secondary models
- Circuit breaker activation
- State recovery จาก checkpoints

**สิ่งที่ควรให้คนตัดสินใจ:**
- Data corruption issues
- Security breaches
- Ethical concerns
- Business-critical decisions

---

## Fallback Strategies

Fallback คือ "เส้นทางสำรอง" เมื่อเส้นทางหลักใช้ไม่ได้ ลองนึกภาพถนนหลักปิด เราก็ต้องมีถนนอ้อมไปถึงจุดหมาย

### ประเภทของ Fallback

**1. Model-Level Fallback:**

```
Primary: GPT-4 → Fallback: GPT-3.5-turbo → Fallback: Local model
```

เวลา GPT-4 ใช้ไม่ได้ ก็ไปใช้ GPT-3.5 ถ้ายังไม่ได้อีก ก็ใช้ local model (อาจจะแย่กว่า แต่ยังใช้งานได้)

**2. Provider-Level Fallback:**

```
OpenAI → Anthropic → Google → Local
```

กรณีที่ provider ใหญ่ล่มพร้อมกันหลายตัว ก็ต้องมีทางเลือก

**3. Capability-Level Fallback:**

```
AI-generated response → Cached response → Rule-based response → Human handoff
```

นี่คือการลดความสามารถลงอย่างมีระดับ (Graceful Degradation)

### Fallback Hierarchy — ทำไมถึงสำคัญ

**ไม่มี Fallback:**
- Uptime: 97-98% (7-14 ชั่วโมง down/month) [^1]
- Recovery: Manual (1-4 ชั่วโมง)

**มี Automatic Fallback:**
- Uptime: 99.9%+ (< 45 นาที down/month) [^2]
- Recovery: Automatic (< 30 วินาที)

ต่างกันมากเลย!

### Fallback Router Pattern

ลองดูตัวอย่างโค้ด:

```python
class FallbackRouter:
    def __init__(self, primary, secondary, circuit_breaker):
        self.primary = primary
        self.secondary = secondary
        self.breaker = circuit_breaker
    
    async def call(self, request: dict) -> dict:
        if self.breaker.allow_request():
            try:
                result = await self.primary.call(request)
                self.breaker.on_success()
                return {"result": result, "provider": "primary"}
            except Exception as e:
                self.breaker.on_failure()
                # Fallback to secondary
                result = await self.secondary.call(request)
                return {"result": result, "provider": "secondary"}
```

**หลักการสำคัญ:**
1. ลอง primary ก่อน
2. ถ้า fail → บอก circuit breaker
3. แล้วไปใช้ secondary
4. ติด tag ว่าใช้ provider ไหน (เพื่อ monitor)

---

## Retry Logic + Circuit Breaker

### Retry Logic

การ retry ดูเหมือนเรื่องง่าย แต่ถ้าทำไม่ดี จะกลายเป็นปัญหาใหญ่

**ปัญหาที่เกิดได้:**
- Retry ทันที → เพิ่มภาระให้ service ที่กำลังมีปัญหาอยู่แล้ว
- Retry ไม่จำกัด → ระบบค้างไปเรื่อยๆ
- Retry เหมือนเดิมทุกครั้ง → ได้ผลลัพธ์เหมือนเดิม

**Tiered Retry Recipe:**

```
Attempt 1: Original prompt, standard timeout
Attempt 2: Prompt + error feedback, reduced temperature
Attempt 3: Simplified prompt, smaller model, tighter constraints
Fallback: Route to human review or degrade gracefully
```

แต่ attempt ที่ต่างกัน ควรใช้ strategy ต่างกันด้วย

**Exponential Backoff with Jitter:**

```python
from tenacity import retry, stop_after_attempt, wait_exponential

@retry(
    stop=stop_after_attempt(3),
    wait=wait_exponential(multiplier=1, min=2, max=10)
)
def call_llm(prompt):
    return llm.generate(prompt)
```

- **Exponential backoff** — รอนานขึ้นเรื่อยๆ ก่อน retry (2, 4, 8 วินาที)
- **Jitter** — สุ่มเวลารอเล็กน้อย เพื่อไม่ให้ทุก request มาในเวลาเดียวกัน
- **Max attempts** — จำกัดจำนวนครั้ง ไม่ให้ retry ตลอดไป

### Circuit Breaker Pattern

Circuit Breaker เหมือนฟิวส์ไฟฟ้า — ถ้ามีกระแสไฟฟ้าลัดวงจรบ่อยๆ ฟิวส์ก็จะตัด เพื่อป้องกันความเสียหาย

**สามสถานะ:**

1. **Closed** — ทำงานปกติ requests ผ่านได้
2. **Open** — บล็อก requests ให้ fail เร็ว ไม่เพิ่มภาระ
3. **Half-Open** — ทดสอบว่าฟื้นตัวหรือยัง ก่อนกลับไป Closed

**Configuration ที่ต้องตั้ง:**

- **Failure threshold** — จำนวน/เปอร์เซ็นต์ failures ก่อนเปิด circuit
- **Timeout period** — รอนานแค่ไหนก่อนเข้า half-open
- **Success threshold** — จำนวน success ที่ต้องการเพื่อปิด circuit
- **Rolling window** — ช่วงเวลาคำนวณ failure rate

**ทำไมต้องมี Circuit Breaker?**

จาก [Portkey.ai](https://portkey.ai/docs) [^3]:

> "Circuit breakers prevent cascading failures by stopping traffic to failing services early. Without them, retries pile up on already degraded services."

สมมติ service A มีปัญหา requests เริ่ม fail → เราก็ retry → ยิ่งเพิ่มภาระให้ service A → fail มากขึ้น → retry มากขึ้น → วงจรนี้เรียกว่า "cascading failure" จนระบบล่มทั้งหมด

**Circuit Breaker ช่วยหยุดวงจรนี้ได้**

---

## Rollback Strategy

นอกจาก Retry, Fallback และ Circuit Breaker แล้ว อีกสิ่งสำคัญที่ต้องมีคือ **Rollback Strategy**

### Checkpointing — จุดบันทึกสถานะ

ลองนึกภาพคุณกำลังทำ workflow ยาว 10 ขั้นตอน มาถึงขั้นตอนที่ 8 แล้วเกิดปัญหา ถ้าไม่มี checkpoint คุณต้องเริ่มต้นใหม่ตั้งแต่ขั้นตอนที่ 1

**Checkpointing ช่วยแก้ปัญหานี้:**

- บันทึก state ทุกขั้นตอน
- สามารถย้อนกลับไปยังจุดใดก็ได้
- ใช้สำหรับ long-running workflows

```python
class CheckpointManager:
    async def save_checkpoint(self, workflow_id: str, state: dict):
        # บันทึก state ปัจจุบัน
        await self.storage.save(f"checkpoint/{workflow_id}", state)
    
    async def rollback_to(self, workflow_id: str, checkpoint_id: str):
        # ย้อนกลับไปยัง checkpoint ที่ระบุ
        state = await self.storage.load(f"checkpoint/{workflow_id}/{checkpoint_id}")
        return state
```

**ตัวอย่างการใช้งานจริง:**

สมมติคุณมี workflow ประมวลผลคำสั่งซื้อ:

1. ตรวจสอบสินค้าคงคลัง ✓ (checkpoint)
2. ตัด stock ✓ (checkpoint)
3. คำนวณราคา ✓ (checkpoint)
4. เรียก Payment API → **FAIL**
5. ถ้าไม่มี checkpoint → ต้องคืน stock เอง, ยกเลิกทุกอย่าง
6. ถ้ามี checkpoint → rollback ไปขั้นตอนที่ 3 ระบบจัดการให้อัตโนมัติ

### Idempotent Operations — ปลอดภัยต่อการ Retry

**Idempotent** คือการที่เราเรียก operation เดิมหลายครั้ง แต่ผลลัพธ์เหมือนกัน

ลองเปรียบเทียบ:

**ไม่ Idempotent (อันตราย):**
```
POST /api/orders (สร้าง order ใหม่)
→ Retry 3 ครั้ง → สร้าง order 3 ใบ!
```

**Idempotent (ปลอดภัย):**
```
POST /api/orders? idempotency_key=abc123
→ Retry 3 ครั้ง → สร้าง order 1 ใบ
```

**หลักการสำคัญสำหรับ AI Systems:**

- ใช้ idempotency key สำหรับทุก API call ที่เปลี่ยนแปลง state
- ออกแบบ prompts ให้ได้ผลลัพธ์คล้ายกันเมื่อ retry
- หลีกเลี่ยง side effects ที่สะสม (เช่น ส่ง email ซ้ำ)

---

## ตัวอย่างจริงจาก OpenClaw

**OpenClaw** มีระบบ Fallback 3 ชั้นที่น่าสนใจ:

```
Layer 1: Auth Profile Rotation
  - สลับระหว่าง credentials ต่างๆ (OpenAI, Anthropic)
  
Layer 2: Thinking Level Fallback (per profile)
  - high → medium → low → off
  - reset เมื่อ switch profile
  
Layer 3: Model Fallback
  - claude-opus → gpt-4o → gemini-2.0-flash → default
  - trigger หลัง Layer 1 & 2 ใช้ไม่ได้
```

**การจำแนกประเภท Error:**

| Error Type | วิธีจัดการ |
|------------|-----------|
| Billing failures | ไม่ retry (เป็นปัญหาที่ account) |
| Rate limits | Retry with backoff (ชั่วคราว) |
| Model errors | Fallback ไปยัง alternative models |

**ปัญหาที่พบ (Issue #6230):**

> "When primary model fails and agent falls back to lower-priority model, it stays on fallback permanently until manually restarted. No automatic recovery path."

นี่คือปัญหาที่พบในระบบจริง — เมื่อระบบ fallback ไปใช้ model ที่ต่ำกว่าแล้ว มันไม่ยอมกลับไปใช้ model หลักเมื่อ model หลักฟื้นตัว

**Best Practices จาก OpenClaw:**

- ใช้ `clawbot doctor --fix` สำหรับ auto-repair
- สร้าง backup ก่อนแก้ไข configuration
- ใช้ systemd service สำหรับ auto-restart
- แยกแยะ error types ต่างกัน (billing vs rate limit)

---

## ตัวอย่างจริงจาก LangChain + AutoGen

### LangChain

[LangChain](https://python.langchain.com/docs) [^4] มี built-in retry mechanisms และ fallback support:

```python
from langchain_groq import ChatGroq

llm = ChatGroq(
    model="mixtral-8x7b-32768",
    temperature=0.0,
    max_retries=2,  # Default retry
    timeout=30
)
```

**RunnableWithFallbacks:**

```python
from langchain_core.runnables import RunnableWithFallbacks

chain_with_fallback = RunnableWithFallbacks(
    primary=primary_chain,
    fallbacks=[backup_chain1, backup_chain2]
)
```

**Tool Error Handling:**

```python
# Enable handle_tool_error
tool = SomeTool(
    handle_tool_error=True  # หรือใส่ custom function
)

# หรือใช้ try-except
@retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1))
def safe_tool_call(tool, input_data):
    try:
        return tool.run(input_data)
    except TransientError:
        raise  # ให้ retry
    except PermanentError:
        return fallback_response  # ไม่ retry
```

**LangGraph Error Handling:**

```python
from langchain.memory import ConversationBufferMemory
from langchain.agents import AgentExecutor

memory = ConversationBufferMemory(
    memory_key="chat_history",
    return_messages=True
)

agent = AgentExecutor(memory=memory)

# Error handling with state tracking
error_handler = ErrorHandlerNode(retry_limit=3)

def handle_error(context):
    if context.error_count > error_handler.retry_limit:
        context.switch_to_alternative_path()
```

### AutoGen (Microsoft)

[AutoGen](https://microsoft.github.io/autogen/) [^5] v0.4 มี resilience features ที่ออกแบบมาสำหรับ production:

- **Robustness:** ถ้า agent หนึ่งล้ม ระบบสามารถ re-route task ไปยัง agent อื่น
- **Fault Tolerance:** ออกแบบสำหรับ production environments
- **Scalability:** Scale agents ตาม demand

**Checkpointing & Recovery:**

```python
# Checkpointing สำหรับ resume workflows
agent.run(
    checkpoint=True,
    resume_from_checkpoint=checkpoint_id
)
```

**Multi-Agent Failure Recovery:**

> "Traditional circuit breakers assume stateless services. AI agents violate these assumptions due to stateful nature, learning capabilities, and context maintenance."

สำหรับ Multi-Agent Systems ต้องมี:

1. **Shared Circuit Breaker State** — Agents แชร์สถานะ circuit breaker
2. **Progressive Traffic Restoration** — ค่อยๆ กลับมาใช้งาน
3. **State Synchronization** — จัดการ state หลัง recovery
4. **Conflict Resolution** — แก้ไขข้อขัดแย้งใน views

---

## Best Practices + Monitoring

### Design Principles — หลักการออกแบบ

1. **Design for Failure** — สมมติว่าทุกอย่างจะล้ม
2. **Fail Fast** — แจ้ง failure เร็วที่สุด
3. **Graceful Degradation** — ลดความสามารถลงอย่างมีระดับ
4. **Observability** — มองเห็นทุกอย่างที่เกิดขึ้น
5. **Idempotency** — ปลอดภัยต่อการ retry

### Implementation Checklist

**Retry Logic:**
- [ ] Exponential backoff with jitter
- [ ] Max retry limits
- [ ] Different strategies ตาม error types
- [ ] Timeout per attempt

**Circuit Breaker:**
- [ ] Failure threshold configuration
- [ ] Half-open state testing
- [ ] Metrics & monitoring
- [ ] Integration with fallback

**Fallback:**
- [ ] Define fallback hierarchy
- [ ] Test fallback paths
- [ ] Monitor fallback usage
- [ ] Human handoff procedure

**Recovery:**
- [ ] Checkpointing strategy
- [ ] State persistence
- [ ] Rollback capability
- [ ] Recovery testing

### Metrics ที่ควรติดตาม

| Metric | Description | Alert Threshold |
|--------|-------------|-----------------|
| Error Rate | % ของ requests ที่ fail | > 5% |
| Retry Rate | % ของ requests ที่ต้อง retry | > 20% |
| Circuit Breaker State | Open/Closed/Half-open | ติด Open > 5 นาที |
| Fallback Rate | % ที่ใช้ fallback | > 10% |
| Recovery Time | เวลาที่ใช้ในการกู้ตัว | > 30 วินาที |
| MTTR | Mean Time To Recovery | > 5 นาที |

---

## สรุป

วันนี้เราได้เรียนรู้การออกแบบ Recovery Paths ครบถ้วน:

**ส่วนที่ 1:**
- ทำไมต้องมี Recovery Paths
- Auto vs Manual Recovery
- Fallback Strategies (Model → Provider → Capability)
- Retry Logic + Circuit Breaker

**ส่วนที่ 2:**
- **Rollback Strategy** — Checkpointing และ Idempotent Operations
- **ตัวอย่างจาก OpenClaw** — ระบบ 3 Layer Fallback
- **ตัวอย่างจาก LangChain + AutoGen** — Built-in mechanisms
- **Best Practices** — หลักการออกแบบ + Metrics ที่ต้องติดตาม

**บทเรียนสำคัญ:**

1. ออกแบบระบบโดยคิดว่าทุกอย่างจะล้ม
2. มี Fallback หลายระดับ (Model → Provider → Capability)
3. ใช้ Circuit Breaker ป้องกัน Cascading Failures
4. Checkpoint เพื่อให้ Rollback ได้
5. ทำทุกอย่างให้ Idempotent
6. ติดตาม Metrics อย่างต่อเนื่อง

AI Systems ต้องการการดูแลมากกว่าซอฟต์แวร์ทั่วไป เพราะมีจุดล้มเหลวหลายจุด แต่ถ้าเราออกแบบมาดี ระบบก็สามารถ "รู้จักแก้ตัว" ได้ด้วยตัวเอง

---

## อ้างอิง

[^1]: [Uptime Institute Annual Report 2024](https://uptimeinstitute.com/resources/research-and-reports/annual-data-center-survey) - สถิติ uptime ของระบบที่ไม่มี fallback mechanism

[^2]: [Google SRE Book - Reliability Targets](https://sre.google/sre-book/availability-table/) - เปรียบเทียบ uptime ระหว่างระบบที่มีและไม่มี automatic recovery

[^3]: [Portkey.ai Documentation - Circuit Breakers](https://portkey.ai/docs) - Best practices สำหรับ circuit breaker pattern ใน AI systems

[^4]: [LangChain Documentation - Retry and Fallback](https://python.langchain.com/docs/how_to/fallbacks/) - Built-in retry mechanisms และ fallback support

[^5]: [Microsoft AutoGen Documentation](https://microsoft.github.io/autogen/stable/) - Resilience features สำหรับ multi-agent systems

[^6]: [AWS Well-Architected Framework - Reliability Pillar](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/welcome.html) - หลักการออกแบบระบบที่ทนทานต่อความผิดพลาด

[^7]: [Martin Fowler - Circuit Breaker Pattern](https://martinfowler.com/bliki/CircuitBreaker.html) - คำอธิบาย pattern ที่ใช้กันอย่างแพร่หลาย

[^8]: [Google Cloud - Exponential Backoff](https://cloud.google.com/iot/docs/how-tos/exponential-backoff) - Best practices สำหรับ retry logic

[^9]: [NIST - Resilience Engineering](https://www.nist.gov/system/files/documents/itl/csd/NIST.SP.800-160v1.pdf) - มาตรฐานการออกแบบระบบที่ทนทาน

[^10]: [OpenClaw Documentation - Fallback System](https://openclaw.dev/docs) - ตัวอย่างระบบ fallback 3 ชั้นใน production
