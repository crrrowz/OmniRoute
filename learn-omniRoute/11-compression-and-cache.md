# 11 — ضغط السياق والكاش (توفير التوكنز) 🗜️

## 🎯 شنو هو الضغط؟
قبل لا يوصل طلبك للمزود، OmniRoute يصغّره: يشيل المسافات الزايدة، الكلمات الحشو، التكرار،
ومخرجات الأوامر الطويلة (مثل `npm install` أو `git log`) — **وبنفس الوقت يحافظ على المعنى**.

## 💡 ليش مفيد؟
- **فلوس أقل** (توكنز أقل = كلفة أقل).
- **حصة مجانية تطول أكثر**.
- **السياق يكفي أكثر** — وكلاء البرمجة يملون نافذة السياق بسرعة بمخرجات الأوامر.
- يصير تلقائياً — ما تغير شي بأدواتك.

### ✅ شنو ما ينمس أبداً
الكود (blocks)، الروابط ومسارات الملفات، JSON، المعرفات التقنية، المعادلات، تعريفات الأدوات،
والـ system prompts (بوضع Lite).

---

## 1️⃣ الأوضاع (من الأخف للأقوى)

| الوضع | التوفير التقريبي | شنو يسوي | متى |
|------|-----------------|---------|-----|
| **Off** | 0% | بدون ضغط | — |
| **Lite** | ~15% (<1ms) | تنظيف مسافات، حذف system prompt مكرر، تقصير صور base64 | **دائماً** — آمن تماماً |
| **Standard (Caveman)** | ~30% | يحذف الحشو ("please", "basically") ويختصر العبارات | الشغل اليومي |
| **Aggressive** | ~50% | تقادم الرسائل القديمة + تلخيص مخرجات الأدوات | جلسات debug طويلة |
| **Ultra** | ~75% | تقليم بالقواعد + ترقيق الكود المكرر | لما توصل لحد السياق دائماً |
| **RTK** | 60–90% (على المخرجات المؤهلة) | فلترة ذكية لمخرجات git/test/build/docker… (49 فلتر) — يحافظ على الأخطاء والتحذيرات | **وكلاء البرمجة** |
| **Stacked** | 78–95% (المؤهل) | سلسلة: RTK ← Caveman | خليط مخرجات أوامر + كلام |

⚠️ الأوضاع القوية (Aggressive/Ultra) **تفقد معلومات** (lossy) — جربها وتأكد الجودة ما نزلت.

---

## 2️⃣ وين تضبطه — مجموعة Compression Context

📍 القائمة الجانبية ← **OmniProxy** ← **Compression Context**

| الصفحة | الرابط | شنو تسوي بيها |
|-------|-------|--------------|
| **Compression Settings** | `/dashboard/context/settings` | ⭐ ابدأ هنا: المفتاح العام، الوضع الافتراضي، **Auto-trigger** (يشتغل الضغط تلقائياً لما الطلب يتجاوز عدد توكنز معين) |
| **Engine Combos** | `/dashboard/context/combos` | تسوي سلسلة محركات باسم (مثل `rtk → caveman`) و**تربطها بكومبو توجيه** |
| **Caveman** | `/dashboard/context/caveman` | حزم لغات، معاينة، وضع المخرجات |
| **RTK** | `/dashboard/context/rtk` | معاينة الفلاتر، كتالوج الفلاتر، إعدادات الأمان |
| **Headroom** | `/dashboard/context/headroom` | ضغط الجداول |
| **Session Dedup** | `/dashboard/context/session-dedup` | يحذف المحتوى المكرر بين أدوار المحادثة |
| **CCR** | `/dashboard/context/ccr` | يحط "علامات استرجاع" بدل المحتوى المحذوف حتى يرجعه إذا احتاجه |
| **LLMLingua** | `/dashboard/context/llmlingua` | تقليم دلالي بموديل صغير (اعتماديات اختيارية تتنصب عند الطلب) |
| **Lite / Aggressive / Ultra** | `/dashboard/context/lite` … | إعدادات كل وضع |
| **OmniGlyph** | `/dashboard/context/omniglyph` | يحول السياق لصور (للموديلات اللي تشوف) |
| **Compression Studio** | `/dashboard/compression/studio` | تشوف **حياً** كل محرك شكد ضغط |
| **Exclusions** | `/dashboard/compression/exclusions` | تستثني موديلات/نقاط معينة من الضغط |

📊 النتائج: Analytics ← **Compression** (`/dashboard/analytics/compression`).

---

## 3️⃣ طبقات الأولوية (منو يغلب منو)

من الأقوى للأضعف:
1. **هيدر الطلب** `x-omniroute-compression` (لطلب واحد)
2. إعداد الضغط على **الكومبو**
3. البروفايل النشط
4. Auto-trigger
5. الافتراضي باللوحة

⚠️ إذا الضغط **مطفي عام**، الهيدر ما يكدر يشغله.

### قيم الهيدر
| القيمة | الأثر |
|-------|------|
| `off` | بدون ضغط لهذا الطلب |
| `safe` | dedup + مسافات بس (نفس عدم إرسال الهيدر) |
| `allow-lossy` | يسمح بالمحركات اللي تفقد معلومات |
| `engine:rtk` | محرك واحد محدد |
| `<اسم-combo>` | سلسلة ضغط باسمها |

والرد يرجعلك هيدر `X-OmniRoute-Compression: <mode>; source=<المصدر>` — تعرف شنو انطبق.

```bash
curl -i http://localhost:20128/v1/chat/completions \
  -H "Authorization: Bearer <مفتاحك>" -H "Content-Type: application/json" \
  -H "x-omniroute-compression: engine:rtk" \
  -d '{"model":"auto","messages":[{"role":"user","content":"..."}]}'
```

💡 **الاستراتيجية الذكية:** ضغط قوي (Stacked) على كومبو المجانيين/وكلاء البرمجة، وLite بس
على اشتراكاتك المدفوعة.

📚 `docs/compression/COMPRESSION_GUIDE.md`، `COMPRESSION_ENGINES.md`، `RTK_COMPRESSION.md`

---

## 4️⃣ الكاش (Cache)

🎯 **شنو هو:** إذا نفس الطلب انرسل قبل، يرجع الرد من الكاش **بدون ما يروح للمزود** = مجاني وفوري.

| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| **Cache (analytics)** | `/dashboard/cache` | نسب إصابة الكاش |
| **Cache settings** | `/dashboard/settings/cache` | كاش كتالوج الموديلات وكاش الردود |
| **Media** | `/dashboard/cache/media` | الصور/الفيديو/الصوت المحفوظة |

💡 مفيد جداً للطلبات المتكررة (اختبارات، سكربتات، نفس الأسئلة).
⚠️ لا تعتمد عليه إذا تريد أجوبة مختلفة كل مرة (مثلاً temperature عالية للإبداع).

---

## 🧪 جرّب
1. فعّل **Lite** من Compression Settings.
2. افتح **RTK** ← معاينة ← الصق مخرج `npm install` أو `git log` طويل ← شوف النتيجة.
3. سوّي Engine Combo `rtk → caveman` واربطه بكومبو الوكلاء مالتك.
4. أرسل طلب بهيدر `x-omniroute-compression` وشوف هيدر الرد.
5. افتح **Compression Studio** و Analytics ← **Compression** وشوف التوفير.

## ✅ قائمة التحقق
- [ ] أعرف الفرق بين الأوضاع ومتى كل واحد
- [ ] Lite مفعل
- [ ] ربطت سلسلة ضغط بكومبو
- [ ] شفت أرقام التوفير

➡️ التالي: [12-resilience.md](12-resilience.md)
