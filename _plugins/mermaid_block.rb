module Jekyll
  class MermaidBlock < Jekyll::Generator
    safe true
    priority :high  # Run before markdown processing

    def generate(site)
      site.pages.each { |page| process_mermaid_blocks(page) }
      site.posts.docs.each { |post| process_mermaid_blocks(post) }
    end

    private

    def process_mermaid_blocks(page)
      return unless page.content.include?('```mermaid')
      
      # Convert Mermaid code blocks to div containers
      # This regex handles multiline content better
      page.content = page.content.gsub(
        /```mermaid\s*\n(.*?)\n```/m
      ) do |match|
        mermaid_content = $1.strip
        # Clean up any HTML entities that might have been introduced
        mermaid_content = mermaid_content.gsub(/&gt;/, '>')
        mermaid_content = mermaid_content.gsub(/&lt;/, '<')
        mermaid_content = mermaid_content.gsub(/&amp;/, '&')
        # Also handle the specific case of arrow entities
        mermaid_content = mermaid_content.gsub(/--&gt;/, '-->')
        mermaid_content = mermaid_content.gsub(/&lt;--/, '<--')
        "<div class=\"mermaid\">\n#{mermaid_content}\n</div>"
      end
    end
  end
end 