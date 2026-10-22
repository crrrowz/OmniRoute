# 10 — التكاليف، الحصص، والطبقات المجانية 💰

## ⚠️ أول شي لازم تفهمه
> **رقم "الكلفة" باللوحة = متتبع توفير، مو فاتورة.**
> OmniRoute ما يحاسبك على شي. يحسب: "لو هالطلبات رحت بيها لـ API مدفوع بالسعر الرسمي، كم
> جان راح تدفع". فإذا شفت "$290" وكلها على موديلات مجانية، معناها **وفّرت ~$290**.
> (من `docs/guides/COST_TRACKING.md`)

موديل ما عنده سعر بالجدول يطلع "Legacy / Free" بدل `$0`.

---

## 1️⃣ قسم Costs

### Overview — `/dashboard/costs`
- كروت الصرف: اليوم، 7 أيام، 30 يوم (نطاق 7d/30d/90d/all).
- **Cost Explorer**: جدول تجمعه حسب **المزود / الموديل / مفتاح API / الحساب / service tier**.
- **Routing efficiency**: كم مرة صار fallback ونسبته.
- **Monthly forecast**: توقع نهاية الشهر.
- رسوم: الاتجاه اليومي، حصة المزودين، أعلى الموديلات، الكلفة لكل مفتاح، heatmap.
- **Export** CSV/JSON.

### Pricing — `/dashboard/costs/pricing`
أسعار كل موديل (input/output/cache). تكدر **تعدّل السعر** إذا مزودك يحاسبك بسعر مختلف حتى
الأرقام تصير دقيقة.

### Budget — `/dashboard/costs/budget`
💡 **أهم ميزة للحماية:** تحط حد صرف (عام، أو لكل مفتاح). إذا مفتاح تجاوز ميزانيته يصير حدث `quota.exceeded`
(تكدر تربطه بـ Webhook يبعثلك إشعار — شوف [15](15-advanced-integrations.md)).

### Free-Tier Budget — `/dashboard/free-tiers`
الحصص المجانية الشهرية لكل مزود مجاني وكم استهلكت منها.

### Free Provider Rankings — `/dashboard/free-provider-rankings`
أفضل المزودين المجانيين مرتبين حسب تقييم ELO لموديلاتهم — **تعرف أي مجاني يستاهل تربطه**.

### Radar Catalog — `/dashboard/radar`
إضافة **اختيارية** (مطفية افتراضياً، `RADAR_ENABLED`) تجيب كتالوج موديلات مجانية محدّث من
المجتمع بين الإصدارات (لأن العروض المجانية تتغير أسرع من الإصدارات). موقّع رقمياً، وما يمسح
شي من الكتالوج الأساسي. صفحات فرعية: setup، offers، intel، combos.
📚 `docs/frameworks/RADAR.md`

---

## 2️⃣ الحصص (Quota)

### Provider Quota — `/dashboard/quota`
📍 OmniProxy ← **Provider Quota**
يعرض حدود الاستخدام لكل مزود/حساب: كم باقي، ومتى ترجع (مثلاً نافذة Codex 5 ساعات، الحد
اليومي لـ GLM). يدعم مزودين مثل Kiro (رصيد ومتى يتجدد)، Cursor Pro، DeepSeek…

💡 **ليش مهم:** استراتيجيات مثل `reset-aware` تستخدم هالمعلومة حتى تفضّل الحساب اللي حصته
ترجع أقرب.

### Quota Sharing — `/dashboard/costs/quota-share`
🎯 **المشكلة:** عندك حساب Codex واحد وتشاركه 3 مفاتيح (إلك، لصديقك، لسكربت). سكربت واحد ممكن
يخلص الحصة كلها.
🎯 **الحل:** يوزع الحصة **بعدالة** بين المفاتيح — وإذا مفتاح ما يستخدم حصته، الباقين يستعيرون منها
(work-conserving). 📚 `docs/routing/QUOTA_SHARE.md`

---

## 3️⃣ استراتيجية "صفر دولار" 🆓

من `docs/getting-started/FREE-TIERS-GUIDE.md`:

**الفكرة:** بدل ما تعتمد على مزود مجاني واحد (حصته تخلص بسرعة)، **تكدس** عدة مزودين.

🛠️ **الخطوات:**
1. اربط: **Gemini** (مفتاح AI Studio)، **Groq**، **Cerebras**، **Pollinations**
   (+ **Cloudflare AI** و **GitHub Models** إذا عندك حسابات).
2. استخدم `model: "auto"` أو `auto/cheap`، أو سوّي كومبو priority من المجانيين.
3. OmniRoute يتنقل بينهم تلقائياً لما وحد يخلص أو يفشل.
4. فعّل الضغط (ملف [11](11-compression-and-cache.md)) — كل توكن توفره = حصة مجانية أطول.
5. ضيف أكثر من حساب لنفس المزود إذا شروطه تسمح.

⚠️ **الحقيقة:**
- المجاني بيه rate limits، وممكن يتغير أو يختفي.
- بعض المزودين المجانيين يسجلون طلباتك (مثل Logfare) أو شروطهم معلّمة `avoid`.
- **لا ترسل كود سري أو بيانات شخصية لمزود مجاني ما تثق بيه.**

---

## 4️⃣ من الطرفية
```bash
omniroute cost                          # آخر 30 يوم حسب المزود
omniroute cost --period 7d --group-by model
omniroute usage budget set 20 --scope global --period monthly
omniroute usage budget list
omniroute usage quota
omniroute pricing list --provider openai
omniroute pricing sync                  # تحديث الأسعار
```

---

## 🧪 جرّب
1. افتح **Costs** وشوف Cost Explorer مجمّع حسب **API key**.
2. حط ميزانية صغيرة ($1) لمفتاح تجريبي وشوف شنو يصير لما تقرب منها.
3. افتح **Free Provider Rankings** واختر مزود مجاني جديد تربطه.
4. افتح **Provider Quota** وشوف متى ترجع حصة كل حساب.

## ✅ قائمة التحقق
- [ ] فاهم إن الكلفة باللوحة = توفير تقديري
- [ ] حطيت ميزانية
- [ ] عندي 3+ مزودين مجانيين مكدسين

➡️ التالي: [11-compression-and-cache.md](11-compression-and-cache.md)
