# 09 — المراقبة والسجلات والتحليلات 🩺📊

## 🎯 شنو هي؟
OmniRoute يسجل **كل طلب**: منو أرسله (أي مفتاح)، أي موديل/مزود خدمه، كم توكن، كم كلّف،
كم أخذ وقت، هل صار fallback، وشنو كان الخطأ إذا فشل.

## 💡 ليش مفيدة؟
- **تصحيح الأخطاء:** أداتك تگول "error"؟ السجل يگلك السبب الحقيقي.
- **التعلم:** تشوف بالضبط شنو ترسل أدوات مثل Claude Code (system prompt، الأدوات، الرسائل).
- **التحسين:** تعرف أي مزود أسرع وأي واحد يفشل هواية.

---

## 1️⃣ قسم Monitoring

### Activity — `/dashboard/activity`
خلاصة بسيطة "شنو صار مؤخراً" — بداية جيدة كل يوم.

### Logs (مجموعة) — سجل الطلبات
| الصفحة | الرابط | شنو تشوف |
|-------|-------|---------|
| **Logs** | `/dashboard/logs` | كل طلب: الحالة، المزود، الموديل، الحساب، المفتاح، التوكنز، الوقت. اضغط على أي طلب للتفاصيل الكاملة |
| **Proxy Logs** | `/dashboard/logs/proxy` | ترافيك الـ proxy الخام |
| **Console** | `/dashboard/logs/console` | مخرجات السيرفر (مثل الطرفية) |
| **Timeline** | `/dashboard/logs/timeline` | خط زمني مرئي — تشوف الطلبات المتداخلة والبطيئة |
| **Conversations** | `/dashboard/conversations` | محادثات الوكلاء متعددة الأدوار مجمعة |

💡 الفلترة بالـ Logs: حسب المزود، الموديل، الحساب، مفتاح API.

### System (مجموعة) — الصحة
| الصفحة | الرابط | شنو تشوف |
|-------|-------|---------|
| **Health** | `/dashboard/health` | 6 كروت: حالة النظام (uptime، نسخة، ذاكرة)، **صحة المزودين (Circuit Breaker)**، Rate Limits (الحسابات المبردة والوقت المتبقي)، Active Lockouts (موديلات مقفولة مؤقتاً)، Signature Cache، Latency (p50/p95/p99). تتحدث كل 10 ثواني |
| **Runtime** | `/dashboard/runtime` | المرونة والجلسات لحظياً |
| **Resilience Connections** | `/dashboard/resilience/connections` | حالة كل اتصال/حساب |

💡 **إذا مزود "علگ" وما يرجع:** من Health تكدر تشوف وتعيد ضبط الـ breaker يدوياً
(تفاصيل بـ [12](12-resilience.md)).

### Audit (مجموعة) — التدقيق الأمني
| الصفحة | الرابط | شنو تشوف |
|-------|-------|---------|
| **Audit Log** | `/dashboard/audit` | كل إجراء إداري: منو، شنو، متى، من أي IP |
| **MCP Audit** | `/dashboard/audit/mcp` | كل استدعاء لأدوات MCP |
| **A2A Audit** | `/dashboard/audit/a2a` | طلبات بروتوكول A2A |

---

## 2️⃣ قسم Analytics

| الصفحة | الرابط | الفائدة |
|-------|-------|--------|
| **Usage** | `/dashboard/analytics` | التوكنز، الكلفة التقديرية، heatmap النشاط، توزيع أسبوعي، تفصيل لكل مزود |
| **Combo Health** | `/dashboard/analytics/combo-health` | أي خطوة بالكومبو تفشل هواية — تعدل الترتيب على أساسها |
| **Utilization** | `/dashboard/analytics/utilization` | كم تستغل كل مزود |
| **Cache** | `/dashboard/cache` | نسبة إصابة الكاش (كل إصابة = طلب مجاني) |
| **Compression** | `/dashboard/analytics/compression` | كم توكن وفّر الضغط |
| **Search** | `/dashboard/analytics/search` | استخدام أدوات البحث |
| **Evals** | `/dashboard/analytics/evals` | نتائج مجموعات التقييم (تقيس جودة الموديلات على مهام ثابتة) |
| **Provider Stats** | `/dashboard/provider-stats` | زمن الاستجابة والأداء لكل مزود |

---

## 3️⃣ Traffic Inspector — مثل Charles/Fiddler بس يفهم الذكاء الاصطناعي

📍 **وين:** OmniProxy ← Tools ← **Traffic Inspector** — `/dashboard/tools/traffic-inspector`

🎯 **شنو هو:** يشوف الترافيك **الخام** بين أي تطبيق والمزودين — حتى اللي ما يمر عبر OmniRoute.
يفهم صيغ OpenAI/Anthropic/Gemini، يجمع الـ SSE stream لرسالة كاملة، يعرض المحادثة كفقاعات،
ويسجل جلسات تصدرها `.har` أو `.jsonl`.

### طرق الالتقاط (5)
| الطريقة | الإعداد | يحتاج صلاحية مدير؟ | يغطي |
|--------|--------|-------------------|------|
| 1. AgentBridge | تلقائي | مرة وحدة (شهادة) | وكلاء الـ IDE |
| 2. Custom Hosts | تضيف host | نعم (ملف hosts) | أي تطبيق يستخدم ذاك الـ host |
| 3. HTTP_PROXY | `HTTPS_PROXY=http://127.0.0.1:8080` | لا | التطبيقات اللي تحترم المتغير |
| 4. System-wide | تفعيل + تأكيد | نعم | كل تطبيقات الجهاز (يطفى تلقائياً بعد 30 دقيقة) |
| 5. TPROXY | Linux + root | نعم | أي host — متقدم |

🧪 **أسهل تجربة (بدون صلاحيات):**
```bash
HTTPS_PROXY=http://127.0.0.1:8080 curl https://api.openai.com/v1/models
```
(افتراضياً HTTPS يتسجل كبيانات وصفية بس — فك التشفير خيار يحتاج تثق بشهادة AgentBridge.)

📚 `docs/frameworks/TRAFFIC_INSPECTOR.md`

---

## 4️⃣ من الطرفية
```bash
omniroute usage logs --limit 50 --follow     # مثل tail -f للطلبات
omniroute usage logs --search "error"
omniroute health
omniroute doctor --json                      # تربطه بأداة مراقبة
```

---

## 🧪 جرّب
1. أرسل 5 طلبات بموديلات مختلفة (أو من Playground).
2. افتح **Logs** ← اضغط على طلب ← اقرأ الـ request والـ response كاملين.
3. افتح **Timeline** وشوف شكلهم زمنياً.
4. افتح **Health** وشوف حالة الـ breakers والـ latency.
5. افتح **Usage** وشوف الرسوم البيانية.

## ✅ قائمة التحقق
- [ ] أعرف ألكى طلب معين وأشوف تفاصيله
- [ ] أعرف أقرا كروت صفحة Health
- [ ] أعرف شنو تعرض Combo Health ومتى أحتاجها

➡️ التالي: [10-costs-quota-free-tiers.md](10-costs-quota-free-tiers.md)
