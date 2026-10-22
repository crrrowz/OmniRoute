# 15 — التكاملات المتقدمة 🔗

> Webhooks، تصدير السجلات، Batch، الميديا، الخدمات المدمجة، Proxy، الأنفاق، Remote Mode،
> والتلعيب. كل وحدة مستقلة — اقرا اللي تحتاجه.

---

## 1️⃣ Webhooks — إشعارات بالأحداث 🔔

📍 OmniProxy ← Integrations ← **Webhooks** — `/dashboard/webhooks`

🎯 OmniRoute يبعث HTTP POST لرابطك لما يصير حدث (مثلاً لـ Slack أو Discord أو n8n).

| الحدث | متى |
|------|-----|
| `request.completed` | طلب نجح |
| `request.failed` | طلب فشل بعد كل المحاولات والـ fallback |
| `quota.exceeded` | مفتاح تجاوز ميزانية/حصة |
| `test.ping` | تجربة من زر الاختبار |
| `*` | كل الأحداث |

- كل رسالة موقعة بـ HMAC-SHA256 (هيدر `X-Webhook-Signature: sha256=...`) إذا حطيت secret — تتأكد إنها منه.
- يعيد المحاولة 3 مرات، ويطفي الـ webhook اللي يفشل هواية تلقائياً.

🧪 **جرّب:** سوّي webhook على موقع مثل webhook.site واضغط **Test** وشوف `test.ping` يوصل.
📚 `docs/frameworks/WEBHOOKS.md`

---

## 2️⃣ Log export — تصدير السجلات 📤

📍 Integrations ← **Log export** — `/dashboard/log-export`

يرسل سجلات الطلبات لخدمة تحليل خارجية. الوجهة المدعومة حالياً بالكود: **BigQuery**
(`src/lib/logExport/destinations/bigquery.ts`). 📚 `docs/frameworks/LOG-EXPORT.md`

---

## 3️⃣ API Endpoints — `/dashboard/api-endpoints`
كتالوج كل نقاط الـ API مال OmniRoute مع شارات توضح: محلي فقط (loopback)، محمي دائماً، داخلي —
وتكدر تشوف تفاصيل كل نقطة. 💡 مرجع ممتاز إذا تكتب سكربتات. والمواصفة الكاملة: `docs/openapi.yaml`.

---

## 4️⃣ Batch — معالجة دفعات 📦

📍 Other Features ← **Batch Jobs** (`/dashboard/batch`) و **Files** (`/dashboard/batch/files`)

🎯 ترفع ملف بيه طلبات كثيرة وتنعالج دفعة وحدة (مثل OpenAI Batch API).
💡 مفيد لـ: تصنيف 1000 نص، ترجمة مجموعة ملفات، توليد أوصاف منتجات.

---

## 5️⃣ الميديا: صور، فيديو، صوت 🎨

| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| **Media providers** | `/dashboard/media-providers` (وأنواعها `/dashboard/media-providers/<kind>`) | مزودي توليد الصور/الفيديو/الموسيقى (OpenAI، xAI، Together، SD WebUI، ComfyUI، MusicGen…) |
| **Media** | `/dashboard/cache/media` | الملفات المولدة المحفوظة |

ونقاط الـ API: توليد صور، تحويل صوت لنص، نص لصوت — كلها بصفحة Endpoints، وتجربها من
Playground ← تبويب API.

---

## 6️⃣ Embedded Services — خدمات محلية مدمجة 🧩

📍 OmniProxy ← **Embedded Services** — `/dashboard/providers/services`

خدمات اختيارية **ينصبها ويشغلها OmniRoute بنفسه** على جهازك وتصير أهداف توجيه:

| الخدمة | البورت | شنو تسوي |
|-------|-------|---------|
| **9Router** | 20130 | راوتر ثاني يستخدمه OmniRoute كمزود فرعي |
| **CLIProxyAPI** | 8317 | proxy لمصادقة CLI مال Anthropic |
| **Mux** | 8322 | خدمة تنسيق وكلاء |
| **Bifrost** | 8080 | بوابة AI بلغة Go |
| **Dario** | 3456 | proxy لاشتراك Claude |
| **open-wa** | 8323 | أتمتة واتساب ويب |

لكل خدمة: تنصيب، تشغيل، إيقاف، تحديث، سجلات، تشغيل تلقائي.
🔒 هذي المسارات **محلية فقط** (تشغل عمليات على جهازك). 📚 `docs/frameworks/EMBEDDED-SERVICES.md`

---

## 7️⃣ Proxy — `/dashboard/system/proxy` 🌐

🎯 تخلي طلبات OmniRoute للمزودين تطلع عبر proxy (HTTP/SOCKS5) — **عام** أو **لكل مزود** أو
لكل كومبو. بيها سجل proxies، فحص صحة، استيراد جماعي.
💡 **متى تحتاجه:** مزود محجوب ببلدك، أو تريد IP مختلف لكل حساب.
📚 `docs/guides/USER_GUIDE.md` ← Network Proxy Configuration

---

## 8️⃣ الوصول من برّا جهازك 🌍

### أ) الأنفاق (Tunnels) — من صفحة Endpoints
Cloudflare Quick Tunnel، Tailscale Funnel، ngrok. أو من الطرفية:
```bash
omniroute tunnel list
omniroute tunnel create
omniroute tunnel stop
```
⚠️ **قبل لا تفتح نفق:** `REQUIRE_API_KEY=true` + مفاتيح مقيدة + كلمة سر قوية.

### ب) Remote Mode — تدير سيرفر بعيد من لابتوبك
إذا OmniRoute شغال على VPS أو جهاز ثاني:
```bash
omniroute connect 192.168.0.15      # تدخل بكلمة السر ← ياخذ توكن
omniroute models list               # هسه كل الأوامر تشتغل على السيرفر البعيد
omniroute configure codex           # يكتب إعداد Codex عندك من كتالوج البعيد
omniroute contexts use default      # ترجع للمحلي
```
- **Access tokens** (`oma_live_…`) للإدارة ≠ **API keys** للطلبات. تديرها من
  `/dashboard/settings/access-tokens`.
- ⚠️ `contexts remove` يمسح التوكن من جهازك بس، **ما يلغيه** على السيرفر — ألغيه من هناك.

📚 `docs/guides/REMOTE-MODE.md`، `docs/ops/TUNNELS_GUIDE.md`

---

## 9️⃣ Gamification — التلعيب 🎮

📍 Other Features ← **Gamification**: Leaderboard، Profile، Tokens، Gamification Admin.
ترتيب وإنجازات حسب الاستخدام، مع مراقبة شذوذ ومكافحة غش. ممتع إذا تشارك OmniRoute مع فريق.
📚 `docs/frameworks/GAMIFICATION.md`

---

## 🔟 أوامر CLI إضافية مفيدة
```bash
omniroute providers import ./providers.json --dry-run   # استيراد مزودين من ملف
omniroute plugin list                                    # إضافات CLI
omniroute completion                                     # إكمال تلقائي للطرفية
```

---

## ✅ قائمة التحقق
- [ ] جربت webhook بـ test.ping
- [ ] أعرف الفرق بين Access token و API key
- [ ] أعرف شروط الأمان قبل فتح نفق

➡️ التالي: [16-hands-on-labs.md](16-hands-on-labs.md)
