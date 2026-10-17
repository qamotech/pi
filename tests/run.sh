#!/usr/bin/env bash
# Puddlewick Isle test runner.
# Injects each tests/*.harness.html script into a copy of index.html (before the LAST </body>),
# runs it in headless Chrome, and checks the <pre id="RESULT"> report.
# Exit code 0 = every harness passed with no FAIL lines and no runtime errors.
set -u
cd "$(dirname "$0")/.."
ROOT="$(pwd)"
CHROME="${CHROME:-/c/Program Files/Google/Chrome/Application/chrome.exe}"
[ -x "$CHROME" ] || CHROME="$(command -v google-chrome || command -v chromium || command -v chrome || true)"
[ -n "$CHROME" ] || { echo "Chrome not found (set CHROME=/path/to/chrome)"; exit 2; }
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
winpath(){ if command -v cygpath >/dev/null 2>&1; then cygpath -m "$1"; else echo "$1"; fi; }

# 1) syntax check every inline script
python - "$ROOT/index.html" "$TMP/app.js" <<'PY' || exit 1
import sys,re
s=open(sys.argv[1],encoding='utf-8').read()
blocks=re.findall(r'<script>(.*?)</script>',s,re.S)
if not blocks: print('FAIL no inline script found'); sys.exit(1)
open(sys.argv[2],'w',encoding='utf-8').write('\n;\n'.join(blocks))
PY
if command -v node >/dev/null 2>&1; then node --check "$TMP/app.js" || { echo "FAIL syntax error in index.html"; exit 1; }; echo "ok   syntax"; fi

status=0
# 2) the service-worker cache name must track APP_VERSION so returning PWA players get the new build
VER="$(grep -o "const APP_VERSION='[0-9.]*'" index.html | grep -o "[0-9][0-9.]*")"
if [ -n "$VER" ] && grep -q "'pi-v$VER'" sw.js; then echo "ok   sw.js VERSION matches APP_VERSION ($VER)"; else echo "FAIL sw.js VERSION does not match APP_VERSION '$VER' (expected 'pi-v$VER')"; status=1; fi
for H in tests/*.harness.html; do
  name="$(basename "$H" .harness.html)"
  python - "$ROOT/index.html" "$ROOT/$H" "$TMP/$name.html" <<'PY'
import sys
s=open(sys.argv[1],encoding='utf-8').read();h=open(sys.argv[2],encoding='utf-8').read()
k=s.rfind('</body>');open(sys.argv[3],'w',encoding='utf-8').write(s[:k]+h+s[k:])
PY
  UD="$TMP/ud-$name"; mkdir -p "$UD"
  OUT="$("$CHROME" --headless=new --disable-gpu --no-first-run --user-data-dir="$(winpath "$UD")" --virtual-time-budget="${BUDGET:-90000}" --dump-dom "file:///$(winpath "$TMP/$name.html")" 2>/dev/null)"
  REPORT="$(printf '%s' "$OUT" | python -c "import sys,re,html;s=sys.stdin.read();m=re.search(r'<pre id=\"RESULT\">(.*?)</pre>',s,re.S);print(html.unescape(m.group(1)) if m else 'FAIL no RESULT block (page crashed or harness hung)')")"
  echo "== $name"; echo "$REPORT"
  if echo "$REPORT" | grep -q '^FAIL'; then status=1; fi
  ERRS="$(echo "$REPORT" | sed -n '/^--ERRORS--$/,$p' | tail -n +2 | grep -v '^\s*$' || true)"
  if [ -n "$ERRS" ]; then status=1; fi
done
[ $status -eq 0 ] && echo "ALL TESTS PASSED" || echo "TESTS FAILED"
exit $status
