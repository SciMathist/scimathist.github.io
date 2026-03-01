#!/usr/bin/env bash
# ============================================================
# nb2post.sh — Convert a Jupyter notebook to a Distill post
#
# Usage:
#   ./scripts/nb2post.sh path/to/notebook.ipynb "My Post Title"
#   ./scripts/nb2post.sh path/to/notebook.ipynb "My Post Title" "Description here"
# ============================================================

set -e

NOTEBOOK="${1:?Usage: nb2post.sh <notebook.ipynb> <title> [description]}"
TITLE="${2:?Provide a post title}"
DESCRIPTION="${3:-A post converted from a Jupyter notebook.}"

# Create slug from title
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
DATE=$(date +%Y-%m-%d)
POST_DIR="posts/${DATE}-${SLUG}"

echo "📓 Converting: $NOTEBOOK"
echo "📁 Output dir: $POST_DIR"

# Create post directory
mkdir -p "$POST_DIR"

# Copy notebook
cp "$NOTEBOOK" "$POST_DIR/index.ipynb"

# Inject YAML front matter into the notebook
python3 - <<PYEOF
import json, sys

path = "${POST_DIR}/index.ipynb"
with open(path) as f:
    nb = json.load(f)

# Check if front matter already exists
has_front_matter = (
    nb['cells'] and
    nb['cells'][0].get('cell_type') == 'raw' and
    nb['cells'][0]['source'][0].startswith('---')
)

if not has_front_matter:
    front_matter = {
        "cell_type": "raw",
        "metadata": {"raw_mimetype": "text/yaml"},
        "source": [
            "---\n",
            f'title: "${TITLE}"\n',
            f'description: "${DESCRIPTION}"\n',
            "author:\n",
            "  - name: Your Name\n",
            "    url: https://yoursite.com\n",
            f"date: {DATE}\n",
            "categories: []\n",
            "citation: true\n",
            "---\n"
        ]
    }
    nb['cells'].insert(0, front_matter)

    with open(path, 'w') as f:
        json.dump(nb, f, indent=1)
    print("✅ Front matter injected.")
else:
    print("ℹ️  Front matter already exists — skipping injection.")
PYEOF

echo ""
echo "✅ Post created at: $POST_DIR"
echo ""
echo "Next steps:"
echo "  1. Edit $POST_DIR/index.ipynb to update author, categories, etc."
echo "  2. Run: quarto preview $POST_DIR/index.ipynb"
echo "  3. When ready: git add $POST_DIR && git commit -m 'Add: $TITLE'"
echo "  4. git push → GitHub Actions auto-deploys!"
