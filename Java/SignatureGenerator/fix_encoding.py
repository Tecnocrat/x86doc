#!/usr/bin/env python3
# Fix encoding issues in Main.java

with open('src/main/java/converter/Main.java', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace the corrupted em-dash characters with Unicode escape
content = content.replace('indexOf("â€"")', 'indexOf("\\u2014")')
content = content.replace('indexOf("—")', 'indexOf("\\u2014")')

with open('src/main/java/converter/Main.java', 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed encoding issues in Main.java")
