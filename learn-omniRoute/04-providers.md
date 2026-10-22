# 04 — المزودين (Providers) 🔌

## 🎯 شنو هي؟
المزود هو مصدر الموديلات. **بدون مزود واحد على الأقل OmniRoute ما يسوي شي.**
OmniRoute يدعم أكثر من 350 مزود (القائمة المعتمدة بالكود: `src/shared/constants/providers.ts`،
والمرجع المولّد: `docs/reference/PROVIDER_REFERENCE.md`).

## 💡 ليش مهمة؟
كل ما تربط مزودين أكثر (وحسابات أكثر لنفس المزود)، يصير عند OmniRoute بدائل أكثر يرجعلها
إذا واحد فشل أو خلصت حصته. هذا أساس كل الميزات الثانية (Combo، Auto، الطبقات المجانية).

📍 **وين:** القائمة الجانبية ← **OmniProxy** ← **Providers** — `/dashboard/providers`
وإضافة مزود جديد: `/dashboard/providers/new`

---

## 🛠️ ربط أول مزود — 4 طرق

### أ) مزود مجاني بدون مفتاح (ابدأ بيه)
1. **Providers** ← **Add Provider**
2. اختر واحد مثل: **Pollinations** أو **OpenCode Free** أو **Kiro AI**
3. اضغط **Connect** — خلاص.

⚠️ اقرأ ملاحظة الشروط: بالكتالوج بعض المزودين المجانيين (مثل Kiro و OpenCode Free) شروطهم
معلّمة `avoid`، وبعضهم (مثل Logfare) **يسجل كل الطلبات** للبحث. لا ترسل بيهم بيانات حساسة.

### ب) مزود بمفتاح API (مدفوع أو له طبقة مجانية)
1. جيب المفتاح من موقع المزود:
   - OpenAI: https://platform.openai.com/api-keys
   - Anthropic: https://console.anthropic.com/
   - Google (Gemini): https://aistudio.google.com/apikey — **له طبقة مجانية سخية**
   - Groq: https://console.groq.com/ — **له طبقة مجانية**
   - DeepSeek: https://platform.deepseek.com/
2. **Add Provider** ← اختر المزود ← الصق المفتاح ← **Connect**.

### ج) اشتراك عن طريق OAuth (Claude Pro، Codex، Copilot…)
1. **Add Provider** ← اختر (مثلاً Claude Code أو GitHub Copilot)
2. **Connect with OAuth** ← سجل دخول بحسابك.
💡 هنا تستفيد من اشتراكك الشهري اللي دافع عليه أصلاً، بدل ما تضيع حصته.

### د) Web Cookie (ChatGPT Web، Gemini Web)
يستخدم جلسة المتصفح. يحتاج متصفح Chromium (لهذا السبب صورتك المحلية
`docker/omniroute-chromium` تضيفه). الدليل: `docs/getting-started/WEB-COOKIE-GUIDE.md`.

### هـ) موديلات محلية (Ollama، MLX، LM Studio…)
أي سيرفر متوافق مع OpenAI تكدر تضيفه كمزود "Custom OpenAI-Compatible".
أدلة: `docs/guides/LOCAL_OLLAMA_DOCKER.md`، و `docs/getting-started/PROVIDERS-GUIDE.md` (MLX).

---

## 🔍 داخل صفحة المزود (`/dashboard/providers/<id>`)

لما تفتح أي مزود مربوط تلكى:

| الميزة | شنو تسوي | ليش تفيدك |
|-------|---------|----------|
| **Test / Validate** | يجرب الاتصال فعلياً | تتأكد المفتاح صحيح قبل الاستخدام |
| **قائمة الموديلات + بحث** | تبحث بالموديلات | تلكى الموديل بسرعة |
| **👁 إخفاء موديل** | الموديل المخفي ما يطلع بـ `/v1/models` | تنظف القائمة بأدواتك من موديلات ما تريدها |
| **عداد `N/M active`** | كم موديل مفعل من الكل | نظرة سريعة |
| **إضافة حساب ثاني** | نفس المزود بحساب/مفتاح ثاني | يوزع الحمل ويعطي بديل لما الأول يتقيّد |
| **Advanced Settings** | إعدادات خاصة بالاتصال (مثل `preset` لـ OpenRouter، proxy خاص) | تحكم دقيق |
| **Repair env** (لمزودي OAuth) | يصلح متغيرات البيئة والمصادقة الخربانة | لما يخرب الدخول |

💡 **إخفاء الإيميلات:** إيميلات حسابات OAuth تطلع مخفية جزئياً (`di*****@g****.com`) حتى لو
تصور الشاشة. تغيّرها من Settings ← Appearance.

---

## 📚 Model catalog — `/dashboard/models`
يعرض كل الموديلات من كل المزودين المربوطين بمكان واحد. منه تنسخ **Model ID** الصحيح
(مثل `glm/glm-4.7`) حتى تستخدمه بأدواتك أو بالكومبو.

نفس الشي من الطرفية:
```bash
curl http://localhost:20128/v1/models -H "Authorization: Bearer <مفتاحك>"
omniroute models --search claude
```

---

## 🆓 المزودين المجانيين — أهم معلومة للتوفير

من `docs/getting-started/FREE-TIERS-GUIDE.md` (أرقام تقديرية، تتغير):

| المزود | الحصة التقريبية | كيف |
|-------|---------------|-----|
| **Gemini** | ~60M توكن/شهر | مفتاح AI Studio |
| **Cloudflare AI** | ~30M توكن/شهر | حساب Cloudflare |
| **Cerebras** | ~30M توكن/شهر | مفتاح |
| **Groq** | ~15M توكن/شهر | مفتاح |
| **GitHub Models** | ~18M توكن/شهر | حساب GitHub |
| **Pollinations / OpenCode Free** | بدون مفتاح | Connect مباشرة |
| **DeepSeek** | 5M توكن عند التسجيل | مرة وحدة |

💡 **الحيلة الذهبية:** اربط 3–4 مزودين مجانيين واستخدم `model: "auto"` — OmniRoute يتنقل
بينهم تلقائياً لما وحد يخلص (تفاصيل بـ [10](10-costs-quota-free-tiers.md)).

---

## 🖥️ نفس الشي من الطرفية
```bash
omniroute providers available                         # كل المدعومين
omniroute providers add glm --credential-env GLM_API_KEY --name work
omniroute providers list
omniroute providers test <connection-id>
omniroute providers remove <connection-id> --yes
```

---

## 🧪 جرّب
1. اربط **Pollinations** (بدون مفتاح).
2. اربط **Gemini** بمفتاح مجاني من AI Studio.
3. افتح Gemini ← أخفِ موديلين ما تحتاجهم ← تأكد إنهم اختفوا من `/v1/models`.
4. روح لـ **Model catalog** وانسخ معرّف موديل من كل مزود.

## ✅ قائمة التحقق
- [ ] عندي مزودين على الأقل مربوطين ونجح اختبارهم
- [ ] أعرف أطلع Model ID الصحيح
- [ ] أعرف أخفي موديلات ما أحتاجها

➡️ التالي: [05-api-keys-and-endpoint.md](05-api-keys-and-endpoint.md)
