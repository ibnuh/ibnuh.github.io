# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "tale"
  spec.version       = "0.1.4"
  spec.authors       = ["Chester How"]
  spec.email         = ["chesterhow@gmail.com"]

  spec.summary       = %q{Tale is a minimal Jekyll theme curated for storytellers.}
  spec.homepage      = "https://github.com/chesterhow/tale"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(assets|_layouts|_includes|_sass|LICENSE|README)}i) }

  spec.add_runtime_dependency "jekyll"
  spec.add_runtime_dependency "jekyll-paginate"
  spec.add_runtime_dependency "jekyll-feed"
  spec.add_runtime_dependency "jekyll-seo-tag"
  spec.add_runtime_dependency "jekyll-sitemap"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
