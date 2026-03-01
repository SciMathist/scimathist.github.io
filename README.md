# Distill Blog — GitHub Pages

A Quarto blog styled **exactly** like [distill.pub](https://distill.pub), hosted on GitHub Pages with full CI/CD.

## ✨ Features

| Feature | Status |
|---|---|
| Exact distill.pub typography | ✅ |
| Margin notes & margin figures | ✅ |
| Hover citations & footnotes | ✅ |
| KaTeX math rendering | ✅ |
| Interactive charts (Plotly) | ✅ |
| Interactive diagrams (Observable JS) | ✅ |
| Jupyter notebook → post | ✅ |
| GitHub Actions CI/CD | ✅ |
| GitHub Pages hosting | ✅ |
| RSS feed | ✅ |
| Full-text search | ✅ |
| Comments (Utterances) | ✅ |
| Dark mode | ✅ |
| Mobile responsive | ✅ |

---

## 🚀 Setup (5 minutes)

### 1. Fork or clone this repo

```bash
git clone https://github.com/YOUR_USERNAME/distill-blog.git
cd distill-blog
```

### 2. Install Quarto

Download from [quarto.org/docs/get-started](https://quarto.org/docs/get-started/)

```bash
# macOS
brew install quarto

# or download the installer from quarto.org
```

### 3. Install Python dependencies

```bash
pip install -r requirements.txt
```

### 4. Configure your blog

Edit `_quarto.yml` and replace:

```yaml
site-url: "https://YOUR_USERNAME.github.io/YOUR_REPO"
```

Update the navbar title and footer with your info.

### 5. Enable GitHub Pages

1. Push your repo to GitHub
2. Go to **Settings → Pages**
3. Set source to **GitHub Actions**
4. Push to `main` — your blog deploys automatically!

### 6. Enable Comments (optional)

1. Go to [utteranc.es](https://utteranc.es) and install the app on your repo
2. In `_quarto.yml`, update:
```yaml
comments:
  utterances:
    repo: YOUR_USERNAME/YOUR_REPO
```

---

## 📝 Writing Posts

### Option A: New `.qmd` post

```bash
./scripts/new-post.sh "My Post Title"
# Creates posts/YYYY-MM-DD-my-post-title/index.qmd
```

### Option B: Jupyter Notebook

```bash
./scripts/nb2post.sh my_analysis.ipynb "My Analysis Title"
# Copies notebook to posts/ and injects YAML front matter
```

### Option C: Manually

Create `posts/my-post/index.qmd` with front matter:

```yaml
---
title: "Your Title"
description: "Short description."
author:
  - name: Your Name
    url: https://yoursite.com
date: 2024-03-01
categories: [machine learning, tutorial]
bibliography: ../../references.bib
citation: true
draft: false       # set true to hide from listing
---
```

---

## 🎨 Distill Layout Classes

Use these in any post:

```markdown
<!-- Margin note -->
::: {.aside}
This appears in the margin.
:::

<!-- Wide figure (wider than body) -->
::: {.column-body-outset}
![](image.png)
:::

<!-- Full page width -->
::: {.column-page}
![](wide-image.png)
:::

<!-- Full screen width -->
::: {.column-screen}
![](hero-image.png)
:::
```

---

## 📐 Math

Inline: `$f(x) = \sigma(Wx + b)$`

Block:
```
$$
\text{Attention}(Q,K,V) = \text{softmax}\!\left(\frac{QK^T}{\sqrt{d_k}}\right)V
$$
```

---

## 📚 Citations

Add `.bib` entries to `references.bib`, then cite with `[@key]`.

Hover citations are enabled automatically.

---

## 📊 Interactive Charts

### Observable JS (built into Quarto)

````markdown
```{ojs}
viewof x = Inputs.range([0, 10], {label: "x"})
Math.sin(x)
```
````

### Plotly (Python)

````markdown
```{python}
import plotly.express as px
fig = px.scatter(df, x="x", y="y")
fig.show()
```
````

---

## 🔄 Local Preview

```bash
quarto preview
# Opens at http://localhost:4321
```

## 🏗️ Build

```bash
quarto render
# Output goes to docs/
```

---

## 📁 Project Structure

```
distill-blog/
├── _quarto.yml           # main config
├── index.qmd             # home / post listing
├── about.qmd             # about page
├── archive.qmd           # full archive with search
├── references.bib        # global bibliography
├── requirements.txt      # Python deps
├── styles/
│   ├── distill.css       # exact distill.pub CSS
│   ├── syntax.css        # code syntax colors
│   └── meta.html         # font & KaTeX imports
├── posts/
│   └── YYYY-MM-DD-slug/
│       ├── index.qmd     # or index.ipynb
│       └── images/
├── scripts/
│   ├── new-post.sh       # scaffold new post
│   └── nb2post.sh        # notebook → post
└── .github/
    └── workflows/
        └── deploy.yml    # GitHub Actions CI/CD
```

---

## 🤝 Publishing a Post

```bash
# Write your post
./scripts/new-post.sh "Attention is All You Need"

# Edit it
code posts/YYYY-MM-DD-attention-is-all-you-need/index.qmd

# Preview locally
quarto preview

# When ready — remove draft: true, then:
git add posts/
git commit -m "Add: Attention is All You Need"
git push

# GitHub Actions automatically builds and deploys!
```

---

MIT License
