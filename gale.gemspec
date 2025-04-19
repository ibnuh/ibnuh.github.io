# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "gale"
  spec.version       = "0.1.0"
  spec.authors       = ["Muhammad Ibnuh"]
  spec.email         = ["ibnuhdev@gmail.com"]

  spec.summary       = %q{Gale is a modern Jekyll theme for personal blogs and documentation.}
  spec.homepage      = "https://github.com/ibnuh/gale"
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