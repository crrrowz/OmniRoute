# 05 — مفاتيح API ورابط الاتصال (Endpoint) 🔑

## 🎯 شنو هي؟
- **Endpoint** = العنوان اللي أدواتك ترسل عليه: `http://localhost:20128/v1`
- **API Key** = مفتاح تصنعه داخل OmniRoute حتى أداة معينة تدخل. كل أداة/شخص/سكربت ينطيه
  مفتاحه الخاص.

## 💡 ليش مفيد؟
- تعرف **منو** استهلك شنو (السجلات والتكاليف تنفصل لكل مفتاح).
- تكدر **تقيّد** مفتاح: بس موديلات معينة، بس كومبوهات معينة، حد استخدام، ميزانية.
- إذا مفتاح تسرّب، تلغيه بدون ما تأثر على الباقي.
- مفاتيح المزودين الحقيقية (OpenAI…) **ما تطلع أبداً** لأدواتك — تبقى داخل OmniRoute مشفرة.

---

## 1️⃣ صفحة Endpoints

📍 **وين:** القائمة الجانبية ← **OmniProxy** ← **Endpoints** — `/dashboard/endpoint`

شنو تلكى بيها:
- **روابط الاتصال** وقدرات كل نوع: Chat Completions، Responses API، Embeddings، توليد الصور،
  Reranking، تحويل الصوت لنص، النص لصوت، Moderations.
- **الأنفاق (Tunnels)** — تخلي OmniRoute يوصله من برّا جهازك:
  **Cloudflare Quick Tunnel**، **Tailscale Funnel**، **ngrok**.
  ⚠️ قبل لا تفتح نفق: فعّل `REQUIRE_API_KEY` واستخدم مفاتيح، وإلا أي أحد عنده الرابط يستخدم مزوديك.
- **تبويب MCP** و**تبويب A2A** — لوحات سيرفر MCP وسيرفر A2A (شرحهم بـ [13](13-agentic-features.md)).
- مصادر سياق مثل **Notion** و**Obsidian**.

---

## 2️⃣ صفحة API Keys

📍 **وين:** القائمة الجانبية ← **OmniProxy** ← **API Keys** — `/dashboard/api-manager`

🛠️ **إنشاء مفتاح:**
1. اضغط إنشاء مفتاح جديد، وانطيه اسم واضح (مثل `cursor-laptop`).
2. ⚠️ **انسخ المفتاح فوراً** — ما يطلع مرة ثانية.
3. (اختياري) قيّده بالخيارات اللي تحت.

### خيارات تقييد المفتاح (موجودة بالكود: `api-manager/components/`)

| الخيار | شنو يسوي | متى تستخدمه |
|-------|---------|-----------|
| **Provider / Connection permissions** | يسمح بس لمزودين/حسابات معينة | مفتاح لصديق تريده يستخدم بس المجاني |
| **Model permissions** | يسمح بس لموديلات معينة | تمنع الموديلات الغالية |
| **Allowed Combos** | يسمح بس لكومبوهات معينة | تجبره يمشي عبر كومبو معين |
| **Auto combos toggle** | يسمح/يمنع استخدام `auto/*` | تحكم |
| **Catalog scope** | شنو يشوف بـ `/v1/models` | تبسيط قائمة الموديلات بالأداة |
| **Compression toggle** | تفعيل الضغط لهذا المفتاح | توفير توكنز لأداة معينة |
| **Chaos Mode access** | يسمح بـ Chaos Mode | لأن Chaos يكلف أكثر (عدة طلبات) |
| **Usage limits** | حدود استخدام | منع الاستهلاك المفرط |
| **Bypass provider quota** | يتجاوز سياسة حصة المزود | لمفتاحك الشخصي المهم بس |
| **Scope: manage** | يسمح بإدارة OmniRoute عبر الـ API | سكربتات أتمتة (⚠️ صلاحية قوية) |
| **Self usage / self quota** | المفتاح يكدر يشوف استهلاكه | لمستخدمين تشاركهم |

💡 بالأعلى في **فلاتر** حتى تلكى مفاتيحك بسرعة إذا صاروا هواية.

📍 **صفحة إضافية:** `/dashboard/api-manager/routing` — توجيه خاص بالمفاتيح.

---

## 3️⃣ أول طلب حقيقي 🧪

```bash
# 1) شوف الموديلات المتاحة لمفتاحك
curl http://localhost:20128/v1/models -H "Authorization: Bearer <مفتاحك>"

# 2) أرسل رسالة (غيّر الموديل لواحد عندك، أو استخدم auto)
curl http://localhost:20128/v1/chat/completions \
  -H "Authorization: Bearer <مفتاحك>" \
  -H "Content-Type: application/json" \
  -d '{"model":"auto","messages":[{"role":"user","content":"مرحبا، منو أنت؟"}]}'

# 3) نفس الشي بس stream (الرد يجي قطعة قطعة)
curl -N http://localhost:20128/v1/chat/completions \
  -H "Authorization: Bearer <مفتاحك>" \
  -H "Content-Type: application/json" \
  -d '{"model":"auto","stream":true,"messages":[{"role":"user","content":"عد من 1 إلى 5"}]}'
```

على Windows PowerShell استخدم `curl.exe` بدل `curl` (لأن `curl` هناك اختصار لأمر ثاني).

بعدها روح لـ **Monitoring ← Logs** (`/dashboard/logs`) وشوف طلبك: أي مزود اختار، كم توكن، كم وقت.

💡 **بالـ response headers** OmniRoute يرجعلك معلومات مفيدة (مثل المزود/الموديل المستخدم
والضغط المطبق). شوفها بـ `curl -i`.

---

## 4️⃣ من الطرفية
```bash
omniroute keys add
omniroute keys list
omniroute keys remove <id>
```

## 5️⃣ إدارة OmniRoute بالـ API (مفتاح بصلاحية manage)
```bash
curl http://localhost:20128/api/providers -H "Authorization: Bearer $OMNIROUTE_MANAGE_KEY"
curl http://localhost:20128/api/combos    -H "Authorization: Bearer $OMNIROUTE_MANAGE_KEY"
curl http://localhost:20128/api/keys      -H "Authorization: Bearer $OMNIROUTE_MANAGE_KEY"
```
المرجع الكامل: `docs/reference/API_REFERENCE.md` و `docs/openapi.yaml`.

---

## ✅ قائمة التحقق
- [ ] عملت مفتاح ونسخته بمكان آمن
- [ ] نجح `GET /v1/models` و `POST /v1/chat/completions`
- [ ] شفت الطلب بصفحة Logs
- [ ] عملت مفتاح ثاني مقيّد بموديل واحد وجربت إنه يرفض موديل ثاني

➡️ التالي: [06-combos-and-routing.md](06-combos-and-routing.md)
