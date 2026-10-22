# 02 — التشغيل لأول مرة

## 🎯 شنو راح تتعلم
كيف تشغّل OmniRoute (عندك 4 طرق)، كيف تدخل للوحة، وشنو تسوي بأول 5 دقايق.

---

## 1️⃣ طرق التشغيل

### الطريقة أ — من المستودع نفسه (أنت عندك نسخة المصدر)
```bash
npm install      # أول مرة بس — يولد ملف .env من .env.example تلقائياً
npm run dev      # سيرفر التطوير على http://localhost:20128
```
💡 مناسبة إذا تريد تشوف الكود وتعدّل. أبطأ شوية من النسخة المبنية.

### الطريقة ب — Docker (الأسهل للاستخدام اليومي)
```bash
docker run -d --name omniroute -p 20128:20128 diegosouzapw/omniroute:latest
```
📌 بالمستودع عندك كمان صورة محلية مخصصة: `docker/omniroute-chromium/` — تضيف متصفح Chromium
(يحتاجه مزود **ChatGPT Web (Codex)** حتى يتحقق من الكوكيز). تنبني بالسكربت
`docker/omniroute-chromium/rebuild.ps1` (يسحب الصورة الأصلية، يبنيها، ويشغل الحاوية مع
volume اسمه `omniroute-data` حتى بياناتك ما تضيع).

ملفات compose الجاهزة بجذر المستودع: `docker-compose.yml`، `docker-compose.prod.yml`،
`docker-compose.selfhost.yml`، `docker-compose.ollama-local.yml`.

### الطريقة ج — npm عالمي
```bash
npm install -g omniroute
omniroute                 # يشغل السيرفر ويفتح اللوحة
omniroute --port 3000     # على بورت ثاني
```

### الطريقة د — تطبيق سطح المكتب (Electron)
تطبيق لـ Windows/macOS/Linux مع أيقونة بشريط النظام وتحديث تلقائي. التفاصيل:
`docs/guides/ELECTRON_GUIDE.md`.

---

## 2️⃣ الإعدادات المهمة بملف `.env`

| المتغير | القيمة الافتراضية | شنو يسوي |
|--------|------------------|---------|
| `PORT` | `20128` | بورت اللوحة والـ API (نفس البورت للاثنين) |
| `INITIAL_PASSWORD` | `CHANGEME` | كلمة سر الأدمن **أول مرة بس** — غيّرها فوراً بعد الدخول |
| `JWT_SECRET` | فارغ | سر جلسات الدخول (`openssl rand -base64 48`) |
| `API_KEY_SECRET` | فارغ | سر تشفير المفاتيح (`openssl rand -hex 32`) |
| `REQUIRE_API_KEY` | `false` | إذا `true` كل طلب لـ `/v1` لازم يجي ويّاه مفتاح |
| `DATA_DIR` | `~/.omniroute/` | مكان قاعدة البيانات SQLite وكل الإعدادات |

⚠️ **انتبه:** `REQUIRE_API_KEY=false` يعني أي أحد يوصل لجهازك على البورت 20128 يكدر يستخدم
مزوديك. على جهازك المحلي ماكو مشكلة، بس إذا فتحته على الشبكة أو الإنترنت (Tunnel) خلّيه `true`.

---

## 3️⃣ أول دخول

🛠️ **شنو تسوي:**
1. افتح **http://localhost:20128**
2. سجل دخول بكلمة السر (`INITIAL_PASSWORD`).
3. راح يطلعلك **معالج الإعداد (Onboarding)** — `/dashboard/onboarding`:
   - بيه كارت **"Set up free providers"**: يعرض لك المزودين المجانيين اللي ما يحتاجون مفتاح،
     تكدر تشيل الصح من أي واحد ما تريده، ويوريك تحذير ورابط شروط كل مزود.
   - ⚠️ ما يضيف أي مزود بدون موافقتك، وإذا فشل واحد تكدر تعيد بس الفاشل.
4. بعد المعالج توصل لـ **Home** (`/home`) — نظرة عامة على اللوحة.

📍 **غيّر كلمة السر:** القائمة الجانبية ← **Configuration** ← **Security**
(`/dashboard/settings/security`).
إذا نسيتها: `omniroute reset-password`.

---

## 4️⃣ تأكد إنه يشتغل

```bash
# هل السيرفر جاهز؟ (ما يحتاج مفتاح) — يرجع ok إذا جاهز، starting إذا بعده يقوم
curl http://localhost:20128/healthz
```
أو من اللوحة: القائمة الجانبية ← **Monitoring** ← **Health** (`/dashboard/health`).

ومن الطرفية (إذا منصّب عالمياً):
```bash
omniroute doctor     # فحص شامل: مجلد البيانات، القاعدة، المزودين، البورتات
omniroute health     # الصحة بالتفصيل (breakers, cache, memory)
```

---

## 5️⃣ أوامر CLI الداخلية (مفيدة تعرفها من البداية)

من `docs/guides/USER_GUIDE.md` ← "Internal CLI":

```bash
omniroute setup                    # معالج تفاعلي (كلمة سر، مزودين، كومبو)
omniroute doctor                   # تشخيص
omniroute providers available      # المزودين المدعومين
omniroute providers list           # المزودين اللي ربطتهم
omniroute providers test <id>      # اختبار اتصال حقيقي
omniroute combos list              # الكومبوهات
omniroute models                   # الموديلات المتاحة (--json, --search)
omniroute keys add | list | remove # مفاتيح API
omniroute backup / restore         # نسخة احتياطية / استرجاع
omniroute quota                    # استهلاك الحصص
omniroute tunnel list|create|stop  # أنفاق Cloudflare/Tailscale/ngrok
```
> هذا الـ CLI **غير** صفحة "CLI Code" باللوحة — تلك تضبط أدوات خارجية (Claude Code، Codex…)
> حتى تتكلم مع OmniRoute.

---

## 🗑️ إلغاء التثبيت (للمعلومة)

| الأمر | شنو يسوي |
|------|---------|
| `npm run uninstall` | يشيل التطبيق ويخلي قاعدة البيانات والإعدادات بـ `~/.omniroute` |
| `npm run uninstall:full` | يشيل كلشي **ويمسح نهائياً** المفاتيح والقواعد ⚠️ |

---

## ✅ قائمة التحقق
- [ ] اللوحة تفتح على `localhost:20128`
- [ ] دخلت وغيرت كلمة السر
- [ ] شفت صفحة Health خضرة
- [ ] أعرف وين مكان البيانات (`DATA_DIR`)

➡️ التالي: [03-dashboard-map.md](03-dashboard-map.md)
