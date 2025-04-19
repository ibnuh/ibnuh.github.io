# Gale

My personal Jekyll theme for my blog. It's a clean, responsive theme that I've customized to my preferences.

## Origin

This theme started as a fork of [Tale](https://github.com/chesterhow/tale) by Chester How, but I've customized it to match my preferences and needs:

- Modern color schemes and typography
- Improved mobile responsiveness
- Enhanced code block styling
- Better hover effects and animations
- Updated layout and spacing
- Custom catalogue styling
- And many other personal touches

## Features

- Clean and minimal design
- Responsive layout
- Syntax highlighting
- Mobile-first approach
- SEO optimized
- Fast loading
- Easy to customize

## Personal Setup

### Initial Setup

1. Install Ruby and Jekyll:
```bash
brew install ruby
gem install bundler jekyll
```

2. Clone the repository:
```bash
git clone https://github.com/ibnuh/ibnuh.github.io.git
cd ibnuh.github.io
```

3. Install dependencies:
```bash
bundle install
```

### Development

To run the site locally:
```bash
bundle exec jekyll serve
```

Visit `http://localhost:4000` to see the site.

### Deployment

The site is automatically deployed to GitHub Pages when changes are pushed to the main branch.

### Theme Setup

This theme is set up as a local theme, not a gem. The theme files are in the `_sass/gale` directory and imported in `_sass/gale.scss`.

To use this theme in another project:
1. Copy the `_sass/gale` directory to your project
2. Copy the `_sass/gale.scss` file to your project
3. Make sure your `_config.yml` doesn't specify a theme (comment out or remove the `theme:` line)
4. Import the theme in your main SCSS file: `@import "gale";`