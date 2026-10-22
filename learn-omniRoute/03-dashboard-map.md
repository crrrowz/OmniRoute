# 03 — خريطة لوحة التحكم الكاملة 🗺️

> هذا الملف **مرجع**: كل صفحة بالقائمة الجانبية، رابطها، وشنو تسوي، وبأي ملف تعليمي مشروحة.
> الترتيب مأخوذ من `src/shared/constants/sidebarVisibility/sections.ts` والأسماء من
> `src/i18n/messages/en.json` (اللوحة تدعم العربي كمان — من إعدادات اللغة).

💡 **نصائح للتنقل:**
- القائمة الجانبية مقسمة لأقسام، تكدر **تثبّت** (Pin) أي صفحة أو قسم تستخدمه هواية.
- تكدر تخفي/ترتب العناصر من **Settings ← Sidebar** (`/dashboard/settings/sidebar`).
- بالأعلى في **Command Palette** (لوحة الأوامر) للبحث السريع عن أي صفحة.

---

## 🏠 Home
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| Home | `/home` | نظرة عامة على اللوحة |

## 🔀 OmniProxy — القلب (ابدأ من هنا)
| الصفحة | الرابط | الوظيفة | الملف |
|-------|-------|--------|------|
| Endpoints | `/dashboard/endpoint` | روابط الاتصال بـ OmniRoute + الأنفاق + تبويبات MCP/A2A | [05](05-api-keys-and-endpoint.md) |
| API Keys | `/dashboard/api-manager` | إنشاء/تقييد/إلغاء مفاتيح OmniRoute | [05](05-api-keys-and-endpoint.md) |
| Providers | `/dashboard/providers` | ربط وإدارة المزودين | [04](04-providers.md) |
| Model catalog | `/dashboard/models` | تصفح كل الموديلات من كل المزودين | [04](04-providers.md) |
| Embedded Services | `/dashboard/providers/services` | خدمات محلية اختيارية تنصب وتشتغل من اللوحة | [15](15-advanced-integrations.md) |
| Combos | `/dashboard/combos` | تجميع موديلات مع fallback | [06](06-combos-and-routing.md) |
| Combo Studio | `/dashboard/combos/live` | عرض حي لتسلسل التوجيه | [06](06-combos-and-routing.md) |
| Provider Quota | `/dashboard/quota` | تتبع حدود الاستخدام لكل مزود | [10](10-costs-quota-free-tiers.md) |
| Quota Sharing | `/dashboard/costs/quota-share` | توزيع حصة مزود بعدالة بين عدة مفاتيح | [10](10-costs-quota-free-tiers.md) |

### 🗜️ مجموعة Compression Context (ضغط السياق)
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| Compression Settings | `/dashboard/context/settings` | الإعدادات العامة للضغط |
| Engine Combos | `/dashboard/context/combos` | دمج عدة محركات ضغط بسلسلة |
| Caveman | `/dashboard/context/caveman` | ضغط البرومبت (حذف الحشو) |
| RTK | `/dashboard/context/rtk` | فلترة مخرجات الأوامر (git, test, build…) |
| Headroom | `/dashboard/context/headroom` | ضغط البيانات الجدولية |
| Session Dedup | `/dashboard/context/session-dedup` | حذف التكرار بين الأدوار |
| CCR | `/dashboard/context/ccr` | علامات استرجاع للمحتوى المضغوط |
| LLMLingua | `/dashboard/context/llmlingua` | تقليم دلالي |
| Lite | `/dashboard/context/lite` | تنظيف سريع للمسافات |
| Aggressive | `/dashboard/context/aggressive` | تلخيص + تقادم التاريخ |
| Ultra | `/dashboard/context/ultra` | تقليم بالقواعد |
| OmniGlyph | `/dashboard/context/omniglyph` | السياق كصور |
| Compression Studio | `/dashboard/compression/studio` | عرض حي لسلسلة المحركات |
| Exclusions | `/dashboard/compression/exclusions` | استثناء موديلات/نقاط من الضغط |

كله مشروح بـ [11](11-compression-and-cache.md).

### 🧰 مجموعة Tools
| الصفحة | الرابط | الوظيفة | الملف |
|-------|-------|--------|------|
| CLI Code | `/dashboard/cli-code` | ضبط أدوات البرمجة (Claude Code، Codex، Cursor…) لتستخدم OmniRoute | [07](07-connect-your-tools.md) |
| CLI Agents | `/dashboard/cli-agents` | وكلاء CLI ذاتيين | [13](13-agentic-features.md) |
| ACP Agents | `/dashboard/acp-agents` | CLIs يشغلها OmniRoute بنفسه | [13](13-agentic-features.md) |
| Cloud Agents | `/dashboard/cloud-agents` | وكلاء سحابيين (Codex Cloud، Devin، Jules…) | [13](13-agentic-features.md) |
| Conductor | `/dashboard/conductor` | أسطول وكلاء CLI | [13](13-agentic-features.md) |
| Orchestration | `/dashboard/orchestration` | تنسيق المهام | [13](13-agentic-features.md) |
| Agent Bridge | `/dashboard/tools/agent-bridge` | اعتراض ترافيك وكلاء الـ IDE (MITM) | [13](13-agentic-features.md) |
| Traffic Inspector | `/dashboard/tools/traffic-inspector` | فحص الطلبات والردود الحية | [09](09-monitoring-and-logs.md) |
| Discovery | `/dashboard/discovery` | اكتشاف | — |

### 🔌 مجموعة Integrations
| الصفحة | الرابط | الوظيفة | الملف |
|-------|-------|--------|------|
| API Endpoints | `/dashboard/api-endpoints` | كشف نقاط مخصصة | [15](15-advanced-integrations.md) |
| Webhooks | `/dashboard/webhooks` | إشعارات بالأحداث | [15](15-advanced-integrations.md) |
| Log export | `/dashboard/log-export` | تصدير سجلات الطلبات لخدمات خارجية | [15](15-advanced-integrations.md) |

### 🌐 Proxy
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| Proxy | `/dashboard/system/proxy` | إعدادات HTTP proxy (عام أو لكل مزود) |

صفحتين موجودات بس مو ظاهرات بالقائمة (تفتحهن بالرابط): **MITM Proxy**
`/dashboard/system/mitm-proxy` (اعتراض MITM) و **1Proxy** `/dashboard/system/1proxy` (بوابة proxy عامة).

### 🔗 صفحات أخرى موجودة بس مو بالقائمة الجانبية
`/dashboard/auto-combo` (كتالوج Auto)، `/dashboard/combos/playground`، `/dashboard/limits`،
`/dashboard/usage`، `/dashboard/relay`، `/dashboard/compression/live`، `/dashboard/radar/*`
(setup، offers، intel، combos)، `/dashboard/onboarding` (المعالج).

---

## 📊 Analytics — التحليلات
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| Usage | `/dashboard/analytics` | إحصائيات الترافيك والاستخدام |
| Combo Health | `/dashboard/analytics/combo-health` | موثوقية كل هدف داخل الكومبو |
| Utilization | `/dashboard/analytics/utilization` | استغلال المزودين |
| Cache | `/dashboard/cache` | نسب إصابة الكاش |
| Compression | `/dashboard/analytics/compression` | التوكنز المحفوظة بالضغط |
| Search | `/dashboard/analytics/search` | تحليلات أدوات البحث |
| Evals | `/dashboard/analytics/evals` | نتائج مجموعات التقييم |
| Provider Stats | `/dashboard/provider-stats` | زمن الاستجابة والأداء |

## 💰 Costs — التكاليف
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| Overview | `/dashboard/costs` | تحليل الكلفة الموحد |
| Pricing | `/dashboard/costs/pricing` | أسعار كل موديل |
| Budget | `/dashboard/costs/budget` | حدود الميزانية |
| Free-Tier Budget | `/dashboard/free-tiers` | الحصص المجانية الشهرية |
| Free Provider Rankings | `/dashboard/free-provider-rankings` | أفضل المزودين المجانيين حسب ELO |
| Radar Catalog | `/dashboard/radar` | كتالوج موديلات مجانية محدث من المجتمع |

كله بـ [10](10-costs-quota-free-tiers.md).

## 🩺 Monitoring — المراقبة
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| Activity | `/dashboard/activity` | آخر الأحداث بشكل مبسط |
| Logs | `/dashboard/logs` | سجل الطلبات |
| Proxy Logs | `/dashboard/logs/proxy` | ترافيك الـ proxy |
| Console | `/dashboard/logs/console` | مخرجات الكونسول |
| Timeline | `/dashboard/logs/timeline` | خط زمني مرئي للطلبات |
| Conversations | `/dashboard/conversations` | محادثات وكلاء متعددة الأدوار |
| Health | `/dashboard/health` | صحة النظام وحالة الـ Circuit Breakers |
| Runtime | `/dashboard/runtime` | المرونة والجلسات لحظياً |
| Resilience Connections | `/dashboard/resilience/connections` | حالة الاتصالات (Cooldown) |
| Audit Log / MCP Audit / A2A Audit | `/dashboard/audit`، `/audit/mcp`، `/audit/a2a` | سجل التدقيق والأمان |

كله بـ [09](09-monitoring-and-logs.md) و[12](12-resilience.md).

## 🧪 Dev Tools — أدوات المطور
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| Translator | `/dashboard/translator` | تحويل الصيغ وتصحيحها |
| Playground | `/dashboard/playground` | تجربة البرومبتات مباشرة |
| Search Tools | `/dashboard/search-tools` | بحث وكشط الويب ومقارنة المزودين |

كله بـ [08](08-playground-and-testing.md).

## 🤖 Agentic Features — ميزات الوكلاء
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| MCP Server | `/dashboard/mcp` | التحكم بسيرفر MCP |
| Memory | `/dashboard/memory` | ذاكرة دائمة للوكلاء |
| AgentSkills | `/dashboard/agent-skills` | سجل مهارات A2A |
| Chaos Mode | `/dashboard/chaos` | تنفيذ متوازي على عدة موديلات |
| OmniSkills | `/dashboard/omni-skills` | سجل مهارات الـ sandbox |
| A2A Server | `/dashboard/a2a` | سيرفر بروتوكول A2A |
| Plugins | `/dashboard/plugins` | سوق الإضافات |

كله بـ [13](13-agentic-features.md) (و Chaos بـ [08](08-playground-and-testing.md)).

## 🎮 Other Features
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| Leaderboard / Profile / Tokens / Gamification Admin | `/dashboard/leaderboard` … | نظام التلعيب (ترتيب وإنجازات) |
| Media | `/dashboard/cache/media` | ملفات الميديا المحفوظة (صور/فيديو/صوت) |
| Batch Jobs / Files | `/dashboard/batch`، `/dashboard/batch/files` | معالجة طلبات كثيرة دفعة وحدة |

## ⚙️ Configuration — الإعدادات
| الصفحة | الرابط | الوظيفة |
|-------|-------|--------|
| Storage | `/dashboard/settings/general` | قاعدة البيانات والنسخ الاحتياطي |
| Appearance | `/dashboard/settings/appearance` | الثيم والشكل |
| AI Settings | `/dashboard/settings/ai` | سلوك الذكاء الافتراضي (الذاكرة، المهارات، Auto…) |
| Modality Bridge | `/dashboard/settings/modality-bridge` | جسر بين أنواع المدخلات |
| Routing | `/dashboard/settings/routing` | قواعد التوجيه العامة |
| Resilience | `/dashboard/settings/resilience` | إعادة المحاولة والـ breakers |
| Advanced | `/dashboard/settings/advanced` | خيارات المحترفين |
| Security | `/dashboard/settings/security` | الدخول والتشفير |
| Access Tokens | `/dashboard/settings/access-tokens` | توكنات CLI للوضع البعيد |
| Feature Flags | `/dashboard/settings/feature-flags` | تشغيل/إطفاء قدرات النظام |
| Cache | `/dashboard/settings/cache` | كاش الكتالوج والردود |
| Sidebar | `/dashboard/settings/sidebar` | ترتيب القائمة الجانبية |

كله بـ [14](14-settings.md).

## ❓ Help
| الصفحة | الرابط |
|-------|-------|
| Docs | `/docs` — التوثيق داخل التطبيق |
| Issues | GitHub Issues للإبلاغ عن مشكلة |
| Changelog | `/dashboard/changelog` — ملاحظات الإصدارات |

---

🧪 **جرّب:** افتح كل قسم من فوق لجوه لمدة دقيقة وبس شوف شكله — لا تغيّر شي.
هالجولة تخلي باقي الملفات أسهل بهواية لأن راح تعرف وين كل شي.

➡️ التالي: [04-providers.md](04-providers.md)
