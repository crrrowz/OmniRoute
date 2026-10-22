# 🎓 دليل تعلّم OmniRoute — خطوة بخطوة

> هذا الفولدر معمول إلك حتى تفهم OmniRoute وتجرّب كل ميزة بيه بإيدك.
> كل ملف يجاوبك على 4 أسئلة: **شنو هي الميزة؟ ليش مفيدة؟ وين ألكاها؟ شنو أسوي بالضبط؟**

الإصدار اللي انكتب عليه الدليل: **v3.8.51** (من `package.json`).
لوحة التحكم تشتغل على: **http://localhost:20128**

> ملاحظة: هذا الفولدر (`_learn/`) يبدي بشرطة سفلية `_`، يعني المستودع يتجاهله (gitignored)
> — موجود على جهازك بس وما ينرفع لـ git. تكدر تعدّل عليه وتكتب ملاحظاتك براحتك.

---

## 🗺️ ترتيب القراءة المقترح

| # | الملف | شنو راح تتعلم | الوقت التقريبي |
|---|------|----------------|----------------|
| 1 | [01-what-is-omniroute.md](01-what-is-omniroute.md) | الفكرة الأساسية والمصطلحات (Provider, Combo, Model ID…) | 15 دقيقة |
| 2 | [02-install-and-first-run.md](02-install-and-first-run.md) | تشغيله لأول مرة، تسجيل الدخول، المعالج | 15 دقيقة |
| 3 | [03-dashboard-map.md](03-dashboard-map.md) | **خريطة كاملة** لكل صفحة باللوحة ووظيفتها | 20 دقيقة (مرجع) |
| 4 | [04-providers.md](04-providers.md) | ربط مزودي الذكاء الاصطناعي (مجاني / مفتاح / OAuth) | 30 دقيقة |
| 5 | [05-api-keys-and-endpoint.md](05-api-keys-and-endpoint.md) | مفاتيح API، رابط الاتصال، أول طلب حقيقي | 20 دقيقة |
| 6 | [06-combos-and-routing.md](06-combos-and-routing.md) | الكومبو، استراتيجيات التوجيه، `auto` | 45 دقيقة |
| 7 | [07-connect-your-tools.md](07-connect-your-tools.md) | ربط Claude Code / Codex / Cursor / Continue… | 30 دقيقة |
| 8 | [08-playground-and-testing.md](08-playground-and-testing.md) | ساحة التجارب، المترجم، أدوات البحث، Chaos Mode | 30 دقيقة |
| 9 | [09-monitoring-and-logs.md](09-monitoring-and-logs.md) | السجلات، التحليلات، الصحة، Traffic Inspector | 30 دقيقة |
| 10 | [10-costs-quota-free-tiers.md](10-costs-quota-free-tiers.md) | التكاليف، الحصص، الميزانية، المزودين المجانيين | 30 دقيقة |
| 11 | [11-compression-and-cache.md](11-compression-and-cache.md) | ضغط البرومبت وتوفير التوكنز، الكاش | 40 دقيقة |
| 12 | [12-resilience.md](12-resilience.md) | كيف يتعامل مع الأعطال (Circuit Breaker, Cooldown…) | 30 دقيقة |
| 13 | [13-agentic-features.md](13-agentic-features.md) | MCP، A2A، الذاكرة، المهارات، الوكلاء | 45 دقيقة |
| 14 | [14-settings.md](14-settings.md) | كل صفحات الإعدادات وشنو تسوي | 25 دقيقة |
| 15 | [15-advanced-integrations.md](15-advanced-integrations.md) | Webhooks، تصدير السجلات، Batch، Proxy، Remote Mode، CLI | 40 دقيقة |
| 16 | [16-hands-on-labs.md](16-hands-on-labs.md) | **تمارين عملية متدرجة** مع قوائم تحقق ✅ | حسب سرعتك |
| 17 | [17-troubleshooting-and-glossary.md](17-troubleshooting-and-glossary.md) | حل المشاكل الشائعة + قاموس المصطلحات | مرجع |

---

## 🧭 إذا وقتك قليل — المسار السريع (ساعة وحدة)

1. اقرأ **01** (الفكرة) → 2. شغّل حسب **02** → 3. اربط مزود مجاني من **04** →
4. اعمل مفتاح وجرّب `curl` من **05** → 5. جرّب `model: "auto"` من **06** →
6. شوف طلبك بالسجلات من **09**.

بعدها كمّل باقي الملفات على راحتك، وارجع لـ **16** حتى تطبّق كلشي عملياً.

---

## 🔖 رموز تشوفها بالملفات

| الرمز | المعنى |
|------|--------|
| 📍 **وين** | المسار باللوحة (مثلاً `القائمة الجانبية ← OmniProxy ← Providers`) والرابط المباشر |
| 🛠️ **شنو تسوي** | خطوات عملية مرقمة |
| 💡 **ليش مفيد** | الفائدة الحقيقية بالاستخدام اليومي |
| ⚠️ **انتبه** | أشياء ممكن تكلفك فلوس أو تخرب شي |
| 🧪 **جرّب** | تجربة صغيرة تثبّت الفهم |
| 📚 **للتعمق** | ملف التوثيق الأصلي بالمستودع (بالإنكليزي) |

---

## 📚 مصادر التوثيق الأصلية (إذا تريد التعمق)

كل المعلومات هنا مأخوذة من المستودع نفسه. أهم المراجع الأصلية:

- `docs/getting-started/` — البداية السريعة، المزودين، Auto-Combo، الطبقات المجانية
- `docs/guides/USER_GUIDE.md` — دليل المستخدم الكامل
- `docs/guides/FEATURES.md` — معرض ميزات اللوحة
- `docs/guides/TROUBLESHOOTING.md` — حل المشاكل
- `docs/routing/AUTO-COMBO.md` — تفاصيل نظام التقييم التلقائي
- `docs/architecture/RESILIENCE_GUIDE.md` — المرونة والأعطال
- `docs/compression/COMPRESSION_GUIDE.md` — الضغط
- `docs/frameworks/` — MCP، A2A، الذاكرة، المهارات، Webhooks…

واللوحة نفسها بيها رابط **Docs** (`/docs`) بقسم Help بالقائمة الجانبية.
