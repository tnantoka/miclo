class HTMLWithHashtag < Redcarpet::Render::HTML
  attr_accessor :user
  def normal_text(text)
    text.gsub(Post::HashtagPattern) do |match|
      path = Rails.application.routes.url_helpers.search_path(q: {
        posts_content_cont: match,
        user_id_eq: user.try(:id)
      })
      ActionController::Base.helpers.link_to(match, path)
    end
  end
end
