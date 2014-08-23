post_only ||= false
json.extract! post, :id, :sequential_id, :created_at, :updated_at, :content
json.content_html post.render
unless post_only
  json.user { json.partial! post.user }
  json.topic { json.partial! post.topic, topic_only: true } if post.topic.present?
end
