module Jekyll
  class MermaidTag < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @markup = markup.strip
    end

    def render(context)
      content = super
      "<div class=\"mermaid\">#{content}</div>"
    end
  end
end

Liquid::Template.register_tag('mermaid', Jekyll::MermaidTag) 