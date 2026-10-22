# Local OmniRoute image with Chromium baked in, so the ChatGPT Web (Codex)
# provider can validate cookies and run turns. Chromium is not kept running:
# OmniRoute launches it on demand via CHROME_PATH, and chromium-headed.sh runs
# it headed on a throwaway Xvfb display (headless gets a Cloudflare 403 on
# chatgpt.com). Rebuild after each upstream release (see rebuild.ps1).
FROM diegosouzapw/omniroute:next

USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      chromium xvfb xauth fonts-liberation fonts-noto-color-emoji \
 && rm -rf /var/lib/apt/lists/*
COPY --chmod=755 chromium-headed.sh /usr/local/bin/chromium-headed
# Strip CRLF in case the script was checked out on Windows.
RUN sed -i 's/\r$//' /usr/local/bin/chromium-headed
USER node

ENV CHROME_PATH=/usr/local/bin/chromium-headed
