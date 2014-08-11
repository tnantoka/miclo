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


  def render
    rendered = Markdown.render(content)
    Hashtag.replace(rendered, user)
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
      rendered = Markdown.render(content)
      tags = Hashtag.extract(rendered)
      self.tag_list = tags
      user.tag(self, with: tags, on: :tags, skip_save: true) # Infinite loop without skip_save
    end
end
