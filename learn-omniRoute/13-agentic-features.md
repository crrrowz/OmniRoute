# 13 — ميزات الوكلاء (MCP، A2A، الذاكرة، المهارات، الوكلاء) 🤖

> هذا القسم يحول OmniRoute من "راوتر" إلى **منصة وكلاء**. ما تحتاجه بالبداية — ارجعله بعد ما
> تتقن الملفات 04–12.

---

## 1️⃣ MCP Server — خلّي وكلائك يتحكمون بـ OmniRoute

🎯 **شنو هو:** MCP (Model Context Protocol) = بروتوكول يخلي الوكلاء (Claude Desktop، Cursor،
Claude Code…) يستخدمون "أدوات". OmniRoute عنده **سيرفر MCP مدمج بـ 110 أداة**: إدارة التوجيه،
الكاش، الضغط، الذاكرة، المهارات، الحصص، البحث…

💡 **ليش مفيد:** تكدر تكول لـ Claude "شوف أي مزود عنده حصة وبدل الكومبو" — ويسويها بنفسه.

📍 **وين:** Agentic Features ← **MCP Server** (`/dashboard/mcp`) — وكمان تبويب MCP بصفحة Endpoints.
السجل: Monitoring ← Audit ← **MCP Audit**.

### طرق الاتصال (3)
| النقل | العنوان | لمنو |
|------|--------|-----|
| **stdio** | الأمر `omniroute --mcp` | Claude Desktop، إضافات IDE |
| **SSE** | `http://localhost:20128/api/mcp/sse` | عملاء يحتاجون stream |
| **Streamable HTTP** | `http://localhost:20128/api/mcp/stream` | عملاء HTTP متعددين |

⚠️ نقل HTTP **مطفي افتراضياً** — شغّله من صفحة MCP أو:
```bash
omniroute mcp status
omniroute mcp enable --transport streamable-http
```

### ربط Claude Desktop
```json
{ "mcpServers": { "omniroute": { "command": "omniroute", "args": ["--mcp"] } } }
```

🔒 **الأمان:** مسارات `/api/mcp/*` تشتغل **من الجهاز المحلي بس** (loopback). من برّا لازم مفتاح
بصلاحية `manage`. والصلاحيات مقسمة لـ scopes — كل مفتاح تحدد شنو يكدر يستدعي.
📚 `docs/frameworks/MCP-SERVER.md`

---

## 2️⃣ A2A Server — وكيل يكلم وكيل

🎯 **شنو هو:** A2A (Agent-to-Agent, JSON-RPC 2.0) — وكلاء ثانيين يكدرون "يوظفون" OmniRoute كوكيل
توجيه ذكي. عنده مهارات جاهزة: smart-routing، quota-management، provider-discovery،
cost-analysis، health-report، list-capabilities.

📍 **وين:** Agentic Features ← **A2A Server** (`/dashboard/a2a`)، والتدقيق ← **A2A Audit**.

🧪 **جرّب:** بطاقة الوكيل (Agent Card) — تعرض قدراته:
```bash
curl http://localhost:20128/.well-known/agent.json
```
الدخول الأساسي: `POST /a2a` (يحتاج مفتاح). 📚 `docs/frameworks/A2A-SERVER.md`

---

## 3️⃣ Memory — ذاكرة دائمة

🎯 **شنو هي:** OmniRoute يستخرج حقائق من المحادثات (تفضيلاتك، قراراتك…) ويحقنها تلقائياً بالطلبات
الجاية. الذاكرة **لكل مفتاح API** (واختيارياً لكل جلسة). بحث نصي (SQLite FTS5) + بحث دلالي
اختياري (Qdrant).

⚠️ **مطفية افتراضياً — وإلها كلفة:** إذا شغلتها، تنضاف ~2000 توكن من الذاكرة لـ **كل** طلب.
- تفعيلها: Configuration ← **AI Settings** (`/dashboard/settings/ai`) — قسم الذاكرة والمهارات.
- إدارة الذكريات (بحث، تعديل، تصدير، مسح): Agentic Features ← **Memory** (`/dashboard/memory`).
- تطفيها لطلب واحد: هيدر `x-omniroute-no-memory: true`.

📚 `docs/frameworks/MEMORY.md`

---

## 4️⃣ Skills — نوعين، لا تخلط بينهم

| | **OmniSkills** | **AgentSkills** |
|---|---|---|
| 📍 وين | `/dashboard/omni-skills` | `/dashboard/agent-skills` |
| شنو هي | أدوات تنحقن بطلبات الموديل ويشغلها OmniRoute (قراءة ملفات، HTTP، كود بـ sandbox، مهارات من السوق) | **كتالوج توثيق** (45 ملف SKILL.md) يعلّم الوكلاء الخارجيين كيف يستخدمون API وCLI مال OmniRoute |
| منو يستخدمها | الموديل أثناء المحادثة | وكلاء خارجيين، عملاء MCP، A2A |
| الفائدة | الموديل يكدر ينفذ أشياء فعلية | وكيلك يتعلم يدير OmniRoute بنفسه |

📚 `docs/frameworks/SKILLS.md`، `docs/frameworks/AGENT-SKILLS.md`

---

## 5️⃣ الوكلاء — 5 صفحات بمجموعة Tools

| الصفحة | الرابط | شنو هي | ليش تفيد |
|-------|-------|-------|---------|
| **CLI Agents** | `/dashboard/cli-agents` | شبكة وكلاء CLI (Codex، Claude، Goose، Aider، OpenCode، Cline، Cursor CLI، Devin CLI…) مع حالة التثبيت والإصدار، وتكدر تسجل وكيل مخصص | تعرف شنو منصب عندك + **CLI Fingerprint Matching** (يطابق توقيع الأداة الأصلية ويقلل خطر الحظر) |
| **ACP Agents** | `/dashboard/acp-agents` | **CLI كـ backend**: OmniRoute يشغل أداة CLI (Claude Code، Codex…) كعملية ويرسلها البرومبت | تستخدم اشتراك CLI **بدون مفتاح API** |
| **Cloud Agents** | `/dashboard/cloud-agents` | مهام طويلة على وكلاء سحابيين: Codex Cloud، Devin، Jules، Cursor Cloud — تعطيه برومبت + رابط repo ويرجعلك PR | تفوّض شغلة كبيرة وتتابعها من مكان واحد |
| **Conductor** | `/dashboard/conductor` | أسطول وكلاء CLI: runners، طابور مهام، و"مجالس" — مباشر | تشغيل عدة وكلاء على مهام بالتوازي |
| **Orchestration** | `/dashboard/orchestration` | تنسيق المهام بين الوكلاء | سير عمل متعدد الخطوات |

📚 `docs/frameworks/ACP.md`، `CLOUD_AGENT.md`، `AGENT_PROTOCOLS_GUIDE.md`

---

## 6️⃣ Agent Bridge — اعتراض وكلاء الـ IDE

📍 Tools ← **Agent Bridge** (`/dashboard/tools/agent-bridge`)

🎯 **شنو هو:** proxy من نوع MITM يعترض ترافيك وكلاء الـ IDE (Antigravity، Kiro، GitHub Copilot،
Codex، Cursor، Zed، Claude Code، OpenCode…) **بدون ما تغير إعداداتهم**، ويحوله لـ OmniRoute.

💡 **الفائدة:** Copilot يحچي مع OpenAI؟ تحوله لـ Claude أو Gemini أو أي مزود. وتطبق model
mapping (مثلاً `gemini-3-flash` → `claude-sonnet-4.7`) وكل الترافيك يطلع بـ Traffic Inspector.

⚠️ يحتاج تنصيب شهادة (cert) وتعديل ملف hosts — صلاحيات مدير. افهم شنو تسوي قبل لا تفعله.
📚 `docs/frameworks/AGENTBRIDGE.md`

---

## 7️⃣ Plugins — `/dashboard/plugins`

نظام إضافات مثل WordPress: كل إضافة تتعلق بمراحل الطلب (`onRequest` / `onResponse` / `onError`).
سوق إضافات + تثبيت، وكل إضافة إلها صفحة إعدادات (`/dashboard/plugins/<name>/config`).
🔒 مسارات الإضافات **محلية بس** لأنها تشغل كود.

وكمان في **إضافات للـ CLI** (`omniroute plugin install/list/scaffold`) — شي ثاني.
📚 `docs/frameworks/PLUGIN_MARKETPLACE.md`، `PLUGINS.md`، `PLUGIN_SDK.md`

---

## 🧪 جرّب (بالترتيب)
1. `curl http://localhost:20128/.well-known/agent.json` — اقرا قدرات A2A.
2. افتح **CLI Agents** — شوف شنو منصب عندك.
3. فعّل MCP (stdio) واربطه بـ Claude Desktop أو Claude Code، واسأله "شنو المزودين المربوطين بـ OmniRoute؟".
4. (اختياري) فعّل الذاكرة لمفتاح تجريبي، احكي معلومة عن نفسك، وبطلب جديد شوف إذا يتذكرها — بعدين طفيها.

## ✅ قائمة التحقق
- [ ] أعرف الفرق بين MCP و A2A
- [ ] أعرف إن الذاكرة مطفية افتراضياً وليش
- [ ] أعرف الفرق بين OmniSkills و AgentSkills
- [ ] أعرف الفرق بين CLI Agents / ACP / Cloud Agents

➡️ التالي: [14-settings.md](14-settings.md)
