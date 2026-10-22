# 17 — حل المشاكل + قاموس المصطلحات 🩹📖

## 🩹 جدول سريع (يحل 90% من المشاكل)

من `docs/guides/TROUBLESHOOTING.md`:

| تشوف هذا | المعنى | الحل |
|---------|-------|-----|
| "Can't connect" | OmniRoute مو شغال | شغله (`npm run dev` / `omniroute` / `docker restart omniroute`) |
| "Invalid API key" | المفتاح غلط أو منتهي | — هل هو مفتاح **OmniRoute** (لأدواتك) لو مفتاح **المزود** (بصفحة Providers)؟ لا تخلطهم |
| "Rate limit exceeded" / 429 | طلبات هواية على حساب واحد | انتظر، أو اربط حسابات/مزودين أكثر واستخدم `auto` أو كومبو |
| "Quota exceeded" | الحصة خلصت | Provider Quota ← شوف متى ترجع، أو اربط مزودين أكثر |
| ردود بطيئة | المزود مزدحم | `auto/fast`، أو مزودين سريعين (Groq، Cerebras) |
| "استخدم مزود ثاني" | `auto` اختار غيره | طبيعي. تريد مزود محدد؟ استخدم `provider/model` أو كومبو priority |
| 502 Bad Gateway | المزود واگع | انتظر، أو `auto`/كومبو للانتقال |
| 401 | بيانات الدخول غلط | صحح المفتاح أو أعد OAuth (أو **Repair env** بصفحة المزود) |
| `omniroute` is not recognized (Windows) | PATH ناقص | أضف ناتج `npm config get prefix` لـ PATH |
| أول دخول ما يشتغل | — | تأكد `INITIAL_PASSWORD` بـ `.env`، أو `omniroute reset-password` |
| Docker: `Connection reset by peer` | ربط IPv6 | `-p 127.0.0.1:20128:20128` أو `curl -4` |
| `503 chat_admission_busy` | السيرفر مضغوط | شوف القسم بملف TROUBLESHOOTING |
| Claude Code ما يتصل | `/v1` زايدة | `ANTHROPIC_BASE_URL=http://localhost:20128` **بدون** `/v1` |
| Cursor/Continue ما يتصل | `/v1` ناقصة | `http://localhost:20128/v1` |
| مزود مستبعد دائماً | قاطع OPEN أو حالة نهائية | Health ← شوف وأعد الضبط؛ أو صلح الحساب |
| ChatGPT Web يفشل بالتحقق | ماكو Chromium | استخدم صورتك `docker/omniroute-chromium` |
| كلفة "عالية" باللوحة | هذا توفير تقديري مو فاتورة | شوف ملف 10 |

## 🔍 خطوات التشخيص العامة
1. **Logs** (`/dashboard/logs`) ← افتح الطلب الفاشل ← اقرا الخطأ الحقيقي.
2. **Health** ← حالة المزودين والحسابات والموديلات.
3. `omniroute doctor` ← فحص شامل.
4. **Console** (`/dashboard/logs/console`) ← أخطاء السيرفر.
5. **Translator** ← إذا المشكلة بتحويل الصيغة.
6. سجلات لملف: `APP_LOG_TO_FILE=true` بـ `.env`.

---

## 📖 قاموس المصطلحات

| المصطلح | المعنى بالعربي |
|--------|---------------|
| **Provider** | المزود (OpenAI، Anthropic، Kiro…) |
| **Connection** | حساب/مفتاح واحد لمزود — ممكن عدة اتصالات لنفس المزود |
| **Model ID** | `بادئة/موديل` مثل `cc/claude-opus-4-7` |
| **Combo** | قائمة موديلات باسم واحد + استراتيجية + fallback |
| **Strategy** | طريقة الاختيار بين أهداف الكومبو (priority، round-robin…) |
| **Fallback** | الانتقال للبديل عند الفشل |
| **auto / auto/\*** | توجيه تلقائي بالتقييم |
| **Endpoint** | رابط الاتصال `http://localhost:20128/v1` |
| **API Key** | مفتاح OmniRoute لأدواتك (≠ مفتاح المزود) |
| **Access Token** | توكن إدارة للـ CLI البعيد (`oma_live_…`) |
| **Scope** | صلاحية محددة للمفتاح (مثل `manage`) |
| **OAuth** | دخول بحسابك بدل مفتاح (لاشتراكات مثل Claude Pro) |
| **Free tier** | حصة مجانية من مزود |
| **Quota** | حصة الاستخدام (طلبات/توكنز ضمن فترة) |
| **Rate limit / 429** | تجاوز عدد الطلبات المسموح |
| **Circuit Breaker** | قاطع يحجب مزود كامل يفشل بشكل متكرر |
| **Cooldown** | تبريد مؤقت لحساب واحد |
| **Model Lockout** | قفل موديل واحد على حساب واحد |
| **Backoff** | زيادة وقت الانتظار تدريجياً مع كل فشل |
| **Sticky session** | تثبيت الجلسة على نفس الحساب |
| **Token** | وحدة النص اللي يحسب عليها المزود (تقريباً ¾ كلمة إنكليزية) |
| **Compression** | تصغير البرومبت لتوفير التوكنز |
| **Lossy** | ضغط يفقد جزء من المعلومات |
| **RTK / Caveman** | محركات ضغط: مخرجات الأوامر / حذف الحشو |
| **Cache hit** | الرد رجع من الكاش بدون مزود |
| **Stream / SSE** | الرد يوصل قطعة قطعة |
| **TTFT / TPS** | وقت أول توكن / توكنز بالثانية |
| **p50/p95/p99** | زمن الاستجابة لـ 50%/95%/99% من الطلبات |
| **MCP** | بروتوكول يخلي الوكلاء يستخدمون أدوات |
| **A2A** | بروتوكول وكيل لوكيل |
| **ACP** | تشغيل أداة CLI كـ backend |
| **MITM** | اعتراض الترافيك المشفر (Agent Bridge) |
| **Tunnel** | فتح OmniRoute للإنترنت (Cloudflare/ngrok/Tailscale) |
| **Webhook** | رابط يبعثله OmniRoute إشعار لما يصير حدث |
| **Feature Flag** | مفتاح تشغيل/إطفاء لميزة |
| **PII** | بيانات شخصية حساسة (إخفاؤها اختياري ومطفي افتراضياً) |
| **Fusion** | عدة موديلات بالتوازي + حَكَم يدمج جواب واحد |
| **Context Relay** | نقل ملخص المحادثة لما يتبدل الحساب |

---

## 🆘 مساعدة إضافية
- التوثيق داخل التطبيق: `/docs`
- `docs/guides/TROUBLESHOOTING.md` (مفصّل)
- GitHub Issues: https://github.com/diegosouzapw/OmniRoute/issues
- Changelog: `/dashboard/changelog`

↩️ رجوع للفهرس: [00-README.md](00-README.md)
