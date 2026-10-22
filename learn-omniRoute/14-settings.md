# 14 — الإعدادات (Configuration) ⚙️

📍 القائمة الجانبية ← **Configuration**. كل صفحة هنا محتواها مأخوذ من المكونات الفعلية بالكود
(`src/app/(dashboard)/dashboard/settings/`).

> 💡 **نصيحة:** قبل لا تلعب بالإعدادات، سوّي **نسخة احتياطية** من صفحة Storage (أول وحدة تحت).

---

## 🗄️ Storage — `/dashboard/settings/general`
- معلومات التخزين وقاعدة البيانات.
- **Backup**: تصدير/استيراد قاعدة البيانات كاملة، وسياسة الاحتفاظ بالنسخ.
- 💡 قبل أي تجربة كبيرة: صدّر نسخة. من الطرفية: `omniroute backup` و `omniroute restore`.

## 🎨 Appearance — `/dashboard/settings/appearance`
- ثيم فاتح/غامق/حسب النظام، 7 ألوان جاهزة أو لون مخصص.
- **Whitelabeling**: اسم التطبيق، لوكو، favicon خاص بيك.
- **إظهار/إخفاء إيميلات الحسابات** (مخفية جزئياً افتراضياً — مفيد لما تصور الشاشة).
- إخفاء سجلات health من السجلات.

## 🧠 AI Settings — `/dashboard/settings/ai`
| القسم | شنو يسوي |
|------|---------|
| **System Prompt** | رسالة نظام عامة تنضاف للطلبات |
| **Thinking Budget** | ميزانية توكنز التفكير للموديلات اللي تفكر (reasoning) |
| **Memory & Skills** | تفعيل الذاكرة والمهارات (⚠️ الذاكرة تكلف توكنز بكل طلب) |
| **Model Capability Overrides** | تصحح قدرات موديل (يدعم صور؟ أدوات؟) إذا الكتالوج غلطان |
| **Models.dev Sync** | مزامنة معلومات الموديلات من models.dev |
| **Claude Fast Mode** / **Codex Fast Tier** / **Codex Auto Ping** | إعدادات خاصة بـ Claude و Codex |
| **Responses State Policy** | سياسة حالة Responses API |

## 🌉 Modality Bridge — `/dashboard/settings/modality-bridge`
تبويبات **Vision / Audio / Video**: إذا موديل ما يدعم صور أو صوت أو فيديو، OmniRoute يكدر يحولها
(مثلاً يوصف الصورة بموديل ثاني) حتى الموديل النصي يفهمها.

## 🔀 Routing — `/dashboard/settings/routing`
| القسم | الفائدة |
|------|--------|
| **Routing Strategy** | كيف يختار بين حسابات نفس المزود (Fill First، Round Robin، P2C، Random، Least Used، Cost Optimized) |
| **Model Aliases** | تحويل أسماء (مع wildcard `*` و `?`) |
| **Fallback Chains** | سلاسل احتياط عامة |
| **Combo Defaults** | القيم الافتراضية للكومبوهات الجديدة |
| **Quota Preflight** | يفحص الحصة قبل لا يرسل |
| **Background Degradation** | إذا المزود ما يدعم وضع background بـ Responses API، يرجع لوضع متزامن مع تحذير |
| **Model routing** | قواعد توجيه حسب الموديل |

شرح كامل بـ [06](06-combos-and-routing.md).

## 🛡️ Resilience — `/dashboard/settings/resilience`
الطوابير، التبريد، القواطع، Wait for cooldown… شرح كامل بـ [12](12-resilience.md).

## 🔧 Advanced — `/dashboard/settings/advanced`
| القسم | الفائدة |
|------|--------|
| **Request Limits** | حدود حجم/عدد الطلبات |
| **Payload Rules** | قواعد تعدّل محتوى الطلب |
| **Debug Mode** | سجلات تفصيلية للتصحيح |
| **Log Tool Sources** | تسجيل مصادر الأدوات |
| **Headroom Proxy** / **CLIProxyAPI** | تكاملات خاصة |

## 🔒 Security — `/dashboard/settings/security`
- حماية نقاط الـ API (تفرض مفتاح)، حظر مزودين مخصصين.
- **IP Filter**: قائمة سماح/منع IPs.
- **Authz**: جرد المسارات وسياسة التجاوز.
- معلومات الجلسة، وتغيير كلمة السر.
- ⚠️ إذا فتحت OmniRoute على الشبكة، هذي أول صفحة تضبطها.

## 🎟️ Access Tokens — `/dashboard/settings/access-tokens`
توكنات محددة الصلاحية للـ CLI بـ **Remote Mode** (تتحكم بـ OmniRoute على سيرفر بعيد من لابتوبك).
شرح بـ [15](15-advanced-integrations.md).

## 🚩 Feature Flags — `/dashboard/settings/feature-flags`
مفاتيح تشغيل/إطفاء لقدرات النظام (~80 مفتاح بـ `src/shared/constants/featureFlagDefinitions.ts`).
أمثلة مهمة:

| المفتاح | شنو يسوي |
|--------|---------|
| `REQUIRE_API_KEY` | يفرض مفتاح على كل طلب |
| `INJECTION_GUARD_MODE` | حماية من حقن البرومبت |
| `PII_REDACTION_ENABLED` | إخفاء البيانات الشخصية بالطلب — **مطفي افتراضياً عمداً** |
| `PII_RESPONSE_SANITIZATION` | إخفاء البيانات الشخصية بالرد — **مطفي افتراضياً** |
| `OUTBOUND_SSRF_GUARD_ENABLED` | يمنع الطلبات لعناوين داخلية خطرة |
| `ENABLE_TLS_FINGERPRINT` | بصمة TLS مشابهة للمتصفحات |
| `RADAR_ENABLED` | كتالوج Radar |
| `RATE_LIMIT_AUTO_ENABLE` | تفعيل حدود المعدل تلقائياً |

⚠️ لا تغير مفتاح ما تفهمه — كل كرت بيه وصف، اقراه أول.

## 💾 Cache — `/dashboard/settings/cache`
كاش كتالوج الموديلات وكاش الردود.

## 📑 Sidebar — `/dashboard/settings/sidebar`
تخفي/ترتب أقسام القائمة الجانبية — **خفي اللي ما تستخدمه حتى اللوحة تصير أبسط**.

---

## 🧪 جرّب
1. Storage ← صدّر نسخة احتياطية.
2. Appearance ← غيّر اللون والثيم.
3. Sidebar ← خفي قسم Gamification إذا ما تحتاجه.
4. Routing ← سوّي alias: `my-fast` → موديل سريع عندك، وجربه بـ `model: "my-fast"`.

## ✅ قائمة التحقق
- [ ] عندي نسخة احتياطية
- [ ] أعرف وين أفعل الذاكرة ووين أغير استراتيجية الحسابات
- [ ] قريت أوصاف Feature Flags الأمنية

➡️ التالي: [15-advanced-integrations.md](15-advanced-integrations.md)
