
## เชื่อมต่อ Telegram

หนึ่งในจุดเด่นที่น่าสนใจที่สุดของ Hermes คือ คุณสามารถคุยกับ AI ผู้ช่วยผ่าน Telegram ได้ โดยไม่จำกัดว่าจะอยู่หน้าคอมแต่อยู่ในบ้าน

### ขั้นตอนการเชื่อมต่อ

1. สร้าง Bot ใน Telegram ผ่าน @BotFather
2. ได้รับ API Token
3. รันคำสั่งตั่งค่าใน Hermes:

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

นี่คือคำสั่ງพื้นฐานที่ผมใช้ทุกวัน:

### คำสั่งทั่วไป

```bash
# เริ่มสนทนากับ Hermes
hermes

# คุยกับงานและทำงานที่ต้องการทำ
hermes do "อะไรก็ได้"

# คุยกับงานโดยไม่ต้องตรวจสอบ
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

- อ่านและวิเคราะห์เอกสาร โดยไม่ต้องไล่นหัวข้อ
- สร้างบทความบน Hugo blog พร้อม build และ deploy
- เขียนโค้ด Python และ debug ครั้งแรก
- ค้นหาข้อมูลทางวิชาการ และสรุปง่ายๆ
- ตั้งเวลาทำงานอัตโนมัติ เช่น แจ้งเตือนราคาทองทุกเช้า

ข้อดี ของ Hermes คือ **ทุกอย่างทำบนเครื่องคุณเอง** และมี **หน่วยความจำมำงานที่ดี** หมายคือ คุณสามารถควบคุมงาน ไฟล์ และการเชื่อมต่อได้หมด โดยไม่ต้องอัปโหลดข้อมูลให้เว็บไซต์ทุกครั้ง

---

## บทสรุป

Hermes Agent เป็นเครื่องมือที่ช่วยให้คุณทำงานบนคอมพิวเตอร์ของตัวเองได้อย่างมีประสิทธิภาพ ตั้งแต่ติดตั้ง ตั้งค่า provider และเชื่อมต่อ Telegram คุณก็จะมีผู้ช่วย AI ที่พร้อมทำงานในทุกที่

หากคุณกำลังมองหา AI agent ที่รันบนเครื่องของตัวเอງ มีทักษะวิทยาในการควบคุม และได้เชื่อมต่อกับเครื่องมือได้หลากหลาย Hermes อาจเป็นตัวเลือกที่น่าสนใจสำหรับคุณ

ในตอนถัดไป ผมจะมาดูวิธีการสร้าง skill ใน Hermes และวิธีใช้ memory ให้ agent จำข้อมูลได้มากยิ่งขึ้น รอติดตามได้เลย!

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
