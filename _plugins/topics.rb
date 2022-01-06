Jekyll::Hooks.register :posts, :post_write do |post|
  all_existing_topics = Dir.entries("_topics")
    .map { |t| t.match(/(.*).md/) }
    .compact.map { |m| m[1] }

    if post['topics']
        topics = post['topics'].split(" ")
        topics.each do |topic|
            generate_topic_file(topic) if !all_existing_topics.include?(topic)
        end
    end
end

def generate_topic_file(topic)
  File.open("_topics/#{topic}.md", "wb") do |file|
    file << "---\nlayout: topics\ntopics: #{topic}\n---\n"
  end
end