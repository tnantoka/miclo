topic_only ||= false
json.extract! topic, :id, :sequential_id, :created_at, :updated_at
unless topic_only
  json.user { json.partial! topic.user }
  json.posts {
    json.array! topic.posts.sequential.with_user, partial: 'posts/post', as: :post#, post_only: true
  }
end

