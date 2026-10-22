# 08 — ساحات التجربة والاختبار 🧪

> هنا تجرب الموديلات من داخل اللوحة **بدون ما تكتب كود أو تربط أداة**.
> كلها بقسم **Dev Tools** و**Agentic Features** بالقائمة الجانبية.

---

## 1️⃣ Playground Studio — ساحة التجارب الرئيسية

📍 **وين:** Dev Tools ← **Playground** — `/dashboard/playground`

💡 **ليش مفيدة:** تجرب أي موديل/كومبو، تقارن موديلات، تبني tools، وتطلع الكود جاهز.

### التبويبات الأربعة

| التبويب | شنو يسوي | استخدمه لـ |
|--------|---------|-----------|
| 💬 **Chat** | محادثة متعددة الأدوار مع stream، Markdown، توكنز وكلفة لكل رسالة، Regenerate | تجربة عادية |
| ⚖️ **Compare** | **برومبت واحد على 4 موديلات بنفس الوقت** — كل عمود يعرض TTFT (وقت أول توكن)، TPS (سرعة)، التوكنز، والكلفة | **تختار أحسن موديل لشغلك** |
| `{}` **API** | محرر Monaco لـ 10 نقاط: chat، completions، embeddings، images، audio، speech، transcriptions، moderations، rerank، search + رفع ملفات | تجرب أي endpoint |
| 🔧 **Build** | بناء `tools[]` (function calling) بمحرر JSON schema + Structured output (JSON mode) | تجرب استدعاء الأدوات |

### لوحة الإعدادات (يمين)
Endpoint، Model، System prompt، Temperature/max_tokens/top_p/seed…، **Presets** (تحفظ إعداداتك
باسم)، و**✨ Improve prompt** (يحسن البرومبت — ⚠️ يستهلك من حصتك).

### زر `</>` Export code
يطلعلك نفس الطلب كـ **curl / Python / TypeScript** جاهز للنسخ. 🔥 مفيد جداً للتعلم.

🧪 **جرّب:** بتبويب Compare حط نفس السؤال البرمجي على `auto/fast` و`auto/coding` وموديل مجاني
وموديل اشتراك — قارن السرعة والجودة والكلفة.

---

## 2️⃣ Translator — مترجم الصيغ

📍 **وين:** Dev Tools ← **Translator** — `/dashboard/translator`

🎯 **شنو هو:** OmniRoute يحول بين صيغ OpenAI ↔ Claude ↔ Gemini ↔ Responses API. هذي الصفحة
توريك التحويل خطوة بخطوة.

أربع أوضاع:
| الوضع | الوظيفة |
|------|--------|
| **Playground** | تلصق طلب بصيغة وتشوفه بصيغة ثانية |
| **Chat Tester** | طلبات حية |
| **Test Bench** | اختبارات دفعة وحدة |
| **Live Monitor** | مراقبة الـ stream لحظياً |

💡 **متى تحتاجه:** لما أداة ترجع خطأ غريب مع مزود معين — تشوف وين صار الخلل بالتحويل.

---

## 3️⃣ Search Tools Studio — البحث والكشط من الويب

📍 **وين:** Dev Tools ← **Search Tools** — `/dashboard/search-tools`

| التبويب | الوظيفة |
|--------|--------|
| 🔍 **Search** | بحث ويب/أخبار عبر مزودي بحث (Serper، Tavily…) مع الكلفة |
| 📄 **Scrape** | كشط صفحة (md/text/html) |
| ⚖️ **Compare** | مقارنة مزودي البحث جنب بعض |

💡 مفيد إذا تبني وكيل يحتاج بحث ويب — تختار أرخص/أدق مزود بحث.
التحليلات: Analytics ← **Search** (`/dashboard/analytics/search`).

---

## 4️⃣ Chaos Mode — مهمة وحدة لعدة مزودين

📍 **وين:** Agentic Features ← **Chaos Mode** — `/dashboard/chaos`

🎯 **شنو هو:** يرسل **نفس المهمة لعدة مزودين بنفس الوقت** وتشوف كل الأجوبة جنب بعض.
⚠️ **مطفي افتراضياً** — لازم تفعله من الصفحة. ولا يأثر على ترافيكك العادي.

| الوضع | الوظيفة |
|------|--------|
| **parallel** | كل موديل يجاوب لوحده — تقارن |
| **collaborative** | سلسلة: كل موديل يشوف جواب اللي قبله ويحسنه/ينتقده |

الإعدادات: المزودين المشاركين، system prompt، timeout (افتراضي 120 ثانية)، maxTokens (4096).

💡 **مفيد لـ:** قرارات مهمة (تريد آراء متعددة)، مراجعة كود من عدة موديلات، brainstorming.
⚠️ كل مشارك = طلب مدفوع (لو مو مجاني).

**الفرق عن `auto/chaos`:** `auto/chaos` موديل ID ترسله بطلب عادي — يرسل لعدة مزودين بالتوازي
بس **يرجعلك جواب واحد** (تدفع N طلب وتاخذ رد واحد). Chaos Mode الصفحة يرجعلك كل الأجوبة.

📚 `docs/guides/CHAOS-MODE.md`

---

## 5️⃣ Combo Playground

📍 `/dashboard/combos/playground` — تجرب كومبو قبل لا تعتمده (شوف [06](06-combos-and-routing.md)).

---

## ✅ قائمة التحقق
- [ ] قارنت 4 موديلات بتبويب Compare
- [ ] صدّرت طلب كـ Python من زر `</>`
- [ ] شفت تحويل طلب OpenAI لصيغة Claude بالـ Translator
- [ ] (اختياري) فعلت Chaos Mode وجربت parallel و collaborative

➡️ التالي: [09-monitoring-and-logs.md](09-monitoring-and-logs.md)
