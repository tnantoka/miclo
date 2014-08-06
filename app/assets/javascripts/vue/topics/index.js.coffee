$ ->
  if $('#vue-topics').length
    Miclo.topicsVue = new Vue
      el: '#vue-topics'
      data:
        topics: Miclo.topics.topics
        isLastPage: Miclo.topics.is_last_page
        page: Miclo.topics.page
      created: ->
        @setAjaxEventListeners()
      methods:
        setAjaxEventListeners: ->
          $(@$el).on 'ajax:success', (e, data, status, xhr) =>
            if data && data.topics
              @isLastPage = data.is_last_page
              @topics = @topics.concat(data.topics)
              @page = data.page
        appendTopics: (topics) ->
          @topics = @topics.concat(data.topics)
        prependTopic: (topic) ->
          @topics.unshift(topic)
        prependPost: (post) ->
          topicVue = _.find @$.topics, (v) ->
            v.topic.id == post.topic.id
          if topicVue
            topicVue.prependPost(post)
          else
            topic = post.topic
            topic.posts = [post]
            topic.user = post.user
            @prependTopic(topic)

