module TimestampScopes
  extend ActiveSupport::Concern
  included do
    scope :active, -> { order(updated_at: :desc) }
  end
end
