class Query < ActiveRecord::Base
  include TimestampScopes

  belongs_to :user

  validates :text, presence: true, uniqueness: { scope: :user_id }

  paginates_per 30
end
