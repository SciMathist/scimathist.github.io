#!/usr/bin/env bash
# ============================================================
# new-post.sh — Scaffold a new Distill-style post
#
# Usage:
#   ./scripts/new-post.sh "Understanding Transformers"
# ============================================================

set -e

TITLE="${1:?Provide a post title}"
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
DATE=$(date +%Y-%m-%d)
POST_DIR="posts/${DATE}-${SLUG}"

echo "Creating post: $POST_DIR"
mkdir -p "$POST_DIR"

cat > "$POST_DIR/index.qmd" << EOF
---
title: "$TITLE"
description: "A short description of this post."
author:
  - name: Your Name
    url: https://yoursite.com
    affiliation: Your Institution
    affiliation-url: https://yourinstitution.edu
date: $DATE
categories: []
bibliography: ../../references.bib
citation: true
draft: true
---

## Introduction

Write your introduction here.

::: {.aside}
A margin note.
:::

## Main Content

## Conclusion

## Acknowledgments
EOF

echo "✅ Created: $POST_DIR/index.qmd"
echo "   Set 'draft: false' when ready to publish."
echo "   Preview with: quarto preview $POST_DIR/index.qmd"
