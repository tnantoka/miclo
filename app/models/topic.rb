class Topic < ActiveRecord::Base
  include TimestampScopes

  belongs_to :user

  has_many :posts, dependent: :destroy

  acts_as_sequenced scope: :user_id

  paginates_per 10

  def older
    user.topics.where('sequential_id < ?', sequential_id).last
  end

  def newer
    user.topics.where('sequential_id > ?', sequential_id).first
  end

  def to_param
    sequential_id
  end
end
