Vue.component 'topic',
  template: '#vue-topic-template',
  replace: true,
  created: ->
    @setAjaxEventListeners()
  computed:
    duration: ->
      created = @formatDate(@topic.created_at)
      updated = @formatDate(@topic.updated_at)
      d = created
      d += " &ndash; #{ updated }" if created != updated
      d
  methods:
    setAjaxEventListeners: ->
      $(@$el).on 'ajax:success', (e, data, status, xhr) =>
        if status == 'nocontent'
          @$destroy()
    prependPost: (post) ->
      if @topic.id == post.topic.id
        topic = @topic
        topic.posts.unshift(post)
        @topic = topic
    removePost: (post) ->
      topic = @topic
      topic.posts = _.without(topic.posts, post)
      @topic = topic
    formatDate: (time) ->
      moment(time).format('l')

$ ->
  if $('#vue-topic').length
    Miclo.topicVue = new Vue
      el: '#vue-topic'
      data:
        topic: Miclo.topic
      methods:
        prependPost: (post) ->
          @$.topic.prependPost(post)

