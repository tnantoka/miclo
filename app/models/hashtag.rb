class Hashtag
  HashtagPattern = /(^|\p{blank})(#[^\p{blank}]+)/

  class << self
    include Rails.application.routes.url_helpers

    def replace(content, user)
      parse(content) do |node, prefix, hashtag|
        path = search_path(q: {
          posts_content_cont: hashtag,
          user_id_eq: user.try(:id)
        })
        "#{prefix}#{ActionController::Base.helpers.link_to(hashtag, path)}"
      end
    end

    def extract(content)
      hashtags = []
      parse(content) do |node, prefix, hashtag|
        hashtags << hashtag
      end
      hashtags
    end

    def parse(content)
      doc = Nokogiri::HTML.fragment(content)
      doc.xpath('*[not(self::a)]/text()').each do |node|
        replaced = node.content.gsub(HashtagPattern) do |match|
          yield node, $1, $2
        end
        node.replace(replaced)
      end
      doc.to_s
    end
  end
end
