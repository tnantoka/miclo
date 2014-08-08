class Post < ActiveRecord::Base
  include TimestampScopes

  belongs_to :user
  belongs_to :topic

  validates :content, presence: true

  acts_as_sequenced scope: [:user_id, :topic_id]
  acts_as_taggable

  before_create :create_topic, if: -> { topic.blank? }
  before_save :update_tag_list
  after_save :touch_topic
  after_destroy :touch_topic
  after_destroy :destroy_topic

  scope :with_user, -> { includes(:user) }
  scope :sequential, -> { order(sequential_id: :desc) }

  HashtagPattern = /(^|\p{blank})(#[^\p{blank}]+)/

  class << self
    include Rails.application.routes.url_helpers

    def render(content)
      renderer = Redcarpet::Render::HTML.new(
        filter_html: true,
        no_images: false,
        no_links: false,
        no_styles: false,
        escape_html: true,
        safe_links_only: false,
        with_toc_data: false,
        hard_wrap: true,
        xhtml: false,
        prettify: true,
        link_attributes: {
          target: '_blank'
        }
      )
      markdown = Redcarpet::Markdown.new(renderer,
        no_intra_emphasis: true,
        tables: true,
        fenced_code_blocks: true,
        autolink: true,
        disable_indented_code_blocks: true,
        strikethrough: true,
        lax_spacing: true,
        space_after_headers: true, # For hashtag
        superscript: true,
        underline: true,
        highlight: true,
        quote: true,
        footnotes: true,
      )
      markdown.render(content.to_s)
    end

    def replace_hashtags(content, user)
      parse_hashtags(content) do |node, prefix, hashtag|
        path = search_path(q: {
          posts_content_cont: hashtag,
          user_id_eq: user.try(:id)
        })
        "#{prefix}#{ActionController::Base.helpers.link_to(hashtag, path)}"
      end
    end

    def extract_hashtags(content)
      hashtags = []
      parse_hashtags(content) do |node, prefix, hashtag|
        hashtags << hashtag
      end
      hashtags
    end

    def parse_hashtags(content)
      doc = Nokogiri::HTML.fragment(content)
      doc.xpath('*[not(self::a)]/text()').each do |node|
        replaced = node.content.gsub(Post::HashtagPattern) do |match|
          yield node, $1, $2
        end
        node.replace(replaced)
      end
      doc.to_s
    end
  end

  def render
    rendered = Post.render(content)
    Post.replace_hashtags(rendered, user)
  end

  def older
    topic.posts.where('sequential_id < ?', sequential_id).last
  end

  def newer
    topic.posts.where('sequential_id > ?', sequential_id).first
  end

  def to_param
    sequential_id
  end

  private
    def create_topic
      self.topic = user.topics.create
    end

    def destroy_topic
      topic.destroy if topic.posts.blank?
    end

    def touch_topic
      topic.touch
    end

    def update_tag_list
      rendered = Post.render(content)
      tags = Post.extract_hashtags(rendered)
      self.tag_list = tags
      user.tag(self, with: tags, on: :tags, skip_save: true) # Infinite loop without skip_save
    end

end
