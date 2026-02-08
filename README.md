# Muhammad Ibnuh's Blog

Personal blog built with Jekyll using the Gale theme.

## Features

- Clean, minimal dark design
- Syntax highlighting for code blocks
- Mermaid diagram support
- Responsive design
- SEO optimized
- HTML compression
- Google Fonts (Lora, Space Grotesk, Inter, JetBrains Mono)

## Mermaid Diagrams

This blog supports Mermaid diagrams for creating flowcharts, sequence diagrams, and other visualizations.

Use `<pre class="mermaid">` tags in your posts:

```html
<pre class="mermaid">
graph TD
    A[Start] --> B{Decision?}
    B -->|Yes| C[Do Something]
    B -->|No| D[Do Nothing]
    C --> E[End]
    D --> E
</pre>
```

The `<pre>` tag is required instead of `<div>` for compatibility with the HTML compress layout, which preserves whitespace inside `<pre>` but not `<div>`.

### Supported Diagram Types

- Flowcharts
- Sequence diagrams
- Class diagrams
- State diagrams
- Entity Relationship diagrams
- Gantt charts
- Pie charts

## Development

### Prerequisites

- Ruby 3.2 or higher
- Bundler

### Setup

```bash
git clone https://github.com/ibnuh/ibnuh.github.io.git
cd ibnuh.github.io
bundle install
bundle exec jekyll serve
```

### Deployment

The site deploys to GitHub Pages via GitHub Actions. Push to `master` to trigger a build.

## License

This project is licensed under the MIT License.
