#!/bin/sh
# CHROME_PATH target. OmniRoute launches Chromium through Playwright only when
# a browser-based provider needs it; this wrapper drops --headless (headless
# Chromium gets a Cloudflare 403 on chatgpt.com) and runs it on a throwaway
# Xvfb display. Chromium and Xvfb both exit when Playwright closes the browser.
# Not xvfb-run: it closes fds 3/4, which Playwright's --remote-debugging-pipe needs.
for arg do
  shift
  case "$arg" in
    --headless | --headless=*) ;;
    *) set -- "$@" "$arg" ;;
  esac
done

display=99
while [ -e "/tmp/.X${display}-lock" ]; do display=$((display + 1)); done

Xvfb ":${display}" -screen 0 1920x1080x24 -nolisten tcp >/dev/null 2>&1 3>&- 4>&- &
xvfb_pid=$!
trap 'kill "$xvfb_pid" 2>/dev/null' EXIT INT TERM

i=0
while [ ! -e "/tmp/.X11-unix/X${display}" ] && [ "$i" -lt 50 ]; do
  sleep 0.1
  i=$((i + 1))
done

DISPLAY=":${display}" /usr/bin/chromium "$@"
