#!/bin/bash
# Super key cheat sheet — opens a floating HTML overlay
# Reads bindings directly from karabiner.json

KARABINER="$HOME/.config/karabiner/karabiner.json"

# Extract descriptions and build rows
ROWS=$(python3 - "$KARABINER" <<'EOF'
import json, sys, re

with open(sys.argv[1]) as f:
    data = json.load(f)

rows = []
for rule in data['profiles'][0]['complex_modifications']['rules']:
    for m in rule['manipulators']:
        desc = m.get('description', '')
        # Match "Caps Lock + X → App Name"
        match = re.match(r'Caps Lock \+ (.+?) → (.+)', desc)
        if match:
            key, app = match.group(1), match.group(2)
            rows.append(f'<tr><td><kbd>⇪</kbd> + <kbd>{key}</kbd></td><td>{app}</td></tr>')

print('\n'.join(rows))
EOF
)

HTML=$(cat <<HTML
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Super Key Shortcuts</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: -apple-system, BlinkMacSystemFont, sans-serif;
    background: rgba(30, 30, 30, 0.97);
    color: #eee;
    padding: 24px;
    border-radius: 12px;
  }
  h1 { font-size: 15px; color: #aaa; margin-bottom: 16px; letter-spacing: 0.05em; text-transform: uppercase; }
  table { width: 100%; border-collapse: collapse; }
  tr:not(:last-child) td { border-bottom: 1px solid #333; }
  td { padding: 8px 12px; font-size: 14px; }
  td:first-child { width: 160px; }
  kbd {
    background: #444;
    border: 1px solid #666;
    border-radius: 4px;
    padding: 2px 6px;
    font-size: 12px;
    font-family: monospace;
    color: #fff;
  }
  td:last-child { color: #ccc; }
</style>
</head>
<body>
<h1>Super Key Shortcuts</h1>
<table>
$ROWS
</table>
</body>
</html>
HTML
)

TMPFILE=$(mktemp /tmp/super-cheatsheet.XXXX)
mv "$TMPFILE" "${TMPFILE}.html"
TMPFILE="${TMPFILE}.html"
echo "$HTML" > "$TMPFILE"
open "$TMPFILE"
