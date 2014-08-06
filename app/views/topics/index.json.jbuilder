json.topics { json.array! @topics, partial: 'topics/topic', as: :topic }
json.is_last_page @topics.last_page?
json.page @topics.current_page
