# 07 — ربط أدواتك بـ OmniRoute (Claude Code، Codex، Cursor…) 🧩

## 🎯 شنو الفكرة؟
أي أداة تدعم "OpenAI-compatible" أو "Anthropic base URL" تكدر توجهها لـ OmniRoute.
بعدها الأداة تشوف **مزود واحد** بس (OmniRoute)، وهو يوزع على كل مزوديك.

## 💡 ليش مفيد؟
- Claude Code يكدر يشتغل على GLM أو Kimi أو Gemini، مو بس Claude.
- لما تخلص حصة Claude، الأداة تكمل على الاحتياطي بدون ما توگف.
- تشوف كل اللي ترسله الأداة بالسجلات (تعليمي جداً — تعرف شنو ترسل الأدوات بالضبط).

---

## ⚠️ القاعدة الذهبية: `/v1` لو بدون؟

| نوع الأداة | Base URL |
|-----------|---------|
| أدوات صيغة **OpenAI** (Cursor، Continue، Kilo، Roo، Codex، Qwen) | `http://localhost:20128/v1` |
| **Claude Code** (صيغة Anthropic) | `http://localhost:20128` ← **بدون `/v1`** |
| Cline، Goose، Aider (تضيف المسار بنفسها) | `http://localhost:20128` |
| Gemini SDK | الجذر (يضيف `/v1beta/...`) |

أكثر خطأ شائع = حط `/v1` لـ Claude Code أو نسيانها لـ Cursor.

---

## 1️⃣ من اللوحة (أسهل طريقة)

📍 **وين:** القائمة الجانبية ← **OmniProxy ← Tools** ← **CLI Code** — `/dashboard/cli-code`

شنو تلكى: كروت لأدوات البرمجة (Claude Code، Codex CLI، OpenClaw، Kilo Code، Antigravity، Cline،
Continue، Cursor، Factory Droid…). كل أداة إلها صفحة (`/dashboard/cli-code/<id>`) بيها:
- **Apply / Reset** للإعداد تلقائياً،
- **Connection profiles**،
- **Model mapping** (أي موديل يقابل أي موديل).

---

## 2️⃣ من الطرفية — الأوامر السحرية

### الإطلاق المباشر (بدون كتابة أي ملف إعداد)
```bash
omniroute launch                    # Claude Code عبر OmniRoute
omniroute launch-codex --model auto # Codex عبر OmniRoute
omniroute run claude                # المشغل العام
omniroute run codex  --model auto
omniroute run aider  --model glm/glm-4.7
omniroute run opencode
omniroute run gemini
omniroute run qwen   --model <id>   # Qwen لازم --model
omniroute run claude --dry-run      # يوريك شنو راح يشغل بدون ما يشغل
```

### كتابة ملفات إعداد دائمة (`setup-*`)
| الأمر | الأداة | شنو يكتب |
|------|------|---------|
| `omniroute setup-claude` | Claude Code | بروفايل لكل موديل `~/.claude/profiles/<name>/` |
| `omniroute setup-codex` | Codex CLI | بروفايل لكل موديل `~/.codex/<name>.config.toml` |
| `omniroute setup-opencode` | OpenCode | `~/.config/opencode/opencode.json` |
| `omniroute setup-continue` | Continue | `~/.continue/config.yaml` |
| `omniroute setup-cline` | Cline | إعدادات Cline |
| `omniroute setup-kilo` | Kilo Code | إعدادات Kilo |
| `omniroute setup-roo` | Roo Code | ملف استيراد |
| `omniroute setup-cursor` | Cursor | **ما يكتب شي** — يطبع الخطوات |
| `omniroute setup-goose` / `setup-aider` / `setup-qwen` / `setup-crush` | … | … |

خيارات مفيدة:
- `--dry-run` يوريك شنو راح يكتب بدون ما يكتب (جربه أول مرة دائماً).
- `--only glm,kimi` يخلي بس الموديلات اللي اسمها بيه هالكلمات.
- `--remote <url> --api-key <key>` لسيرفر OmniRoute بعيد.

ومعالج تفاعلي يختار لك من الكتالوج:
```bash
omniroute configure claude
omniroute configure opencode --provider glm
```

---

## 3️⃣ يدوياً — لكل أداة

### Claude Code
`~/.claude/settings.json`:
```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "http://localhost:20128",
    "ANTHROPIC_AUTH_TOKEN": "مفتاح-omniroute"
  }
}
```
متغيرات مفيدة إضافية:
- `ANTHROPIC_MODEL` — تجبر موديل معين.
- `CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY=1` — قائمة `/model` تعرض موديلات OmniRoute.
  (تعرض بس اللي يبدي بـ `claude`/`anthropic` — وOmniRoute عنده "discovery aliases" يخلي أي
  موديل يطلع باسم `claude/...`. التفاصيل: `docs/guides/CLAUDE-CODE-CONFIGURATION.md`.)
- ⚠️ أعد تشغيل Claude Code بعد تغيير المتغيرات.

### Codex CLI
```bash
export OPENAI_BASE_URL="http://localhost:20128"
export OPENAI_API_KEY="مفتاح-omniroute"
```
أو الأسهل: `omniroute launch-codex`. الدليل الكامل: `docs/guides/CODEX-CLI-CONFIGURATION.md`.

### Cursor
```
Settings → Models → Advanced:
  OpenAI API Base URL: http://localhost:20128/v1
  OpenAI API Key:      مفتاح-omniroute
  Model:               auto   (أو اسم كومبو)
```

### Continue (VS Code)
`~/.continue/config.yaml`:
```yaml
  - name: OmniRoute - Auto
    provider: openai
    model: auto
    apiBase: http://localhost:20128/v1
    apiKey: <مفتاحك>
```

### Cline / Roo Code / Kilo
```
Provider: OpenAI Compatible
Base URL: http://localhost:20128/v1   (Cline: بدون /v1 إذا تستخدم setup-cline)
API Key:  مفتاح-omniroute
Model:    auto أو اسم كومبو
```

### VS Code Copilot Chat
في إضافة اسمها **OmniCopilot** تربط Copilot Chat بـ OmniRoute: `docs/guides/VSCODE-COPILOT.md`.

### سكربت Python (مكتبة openai)
```python
from openai import OpenAI
client = OpenAI(base_url="http://localhost:20128/v1", api_key="مفتاح-omniroute")
r = client.chat.completions.create(model="auto", messages=[{"role":"user","content":"hi"}])
print(r.choices[0].message.content)
```

---

## 4️⃣ الطريقة العكسية: اعتراض الأداة بدون تغيير إعداداتها
إذا أداة ما تسمح تغير الـ Base URL (بعض الـ IDEs)، استخدم **Agent Bridge** — يعترض ترافيكها
(MITM) ويحوله لـ OmniRoute. شرحه بـ [13](13-agentic-features.md).

---

## 🧪 جرّب
1. `omniroute setup-claude --dry-run` — اقرأ شنو راح يكتب.
2. شغّل `omniroute launch` واسأل Claude Code سؤال بسيط.
3. افتح **Logs** — شوف الطلب، وافتح تفاصيله وشوف شنو يرسل Claude Code (system prompt، الأدوات…).
4. اربط Cursor أو Continue بكومبو سويته بالملف 06.

## ✅ قائمة التحقق
- [ ] أعرف متى أحط `/v1` ومتى لا
- [ ] أداة واحدة على الأقل تشتغل عبر OmniRoute
- [ ] شفت طلبات الأداة بالسجلات

➡️ التالي: [08-playground-and-testing.md](08-playground-and-testing.md)
