$ ->
  Vue.component 'new-post', Miclo.PostFormComponent.extend
    template: '#vue-new-post-template',
    paramAttributes: ['newPostPath']
    replace: true,
    created: ->
      @fetchPost()
      @setAjaxEventListeners()
    methods:
      fetchPost: ->
        if !@$parent.post
          $.getJSON @newPostPath, (data) =>
            @post = data
            @post.topic = Miclo.topic if Miclo.topic
      setAjaxEventListeners: ->
        # v-on, @$on doesn't work
        $(@$el).on 'ajax:success', (e, data, status, xhr) =>
          @post = _.clone(data.post)
          @post.content = ''
          @post.content_html = ''
          @messages = data.messages
          @context = 'success'
          Miclo.topicsVue.prependPost(data.post) if Miclo.topicsVue
          Miclo.topicVue.prependPost(data.post) if Miclo.topicVue
          Miclo.topic = data.post.topic unless Miclo.topic
          @focus()
        $(@$el).on 'ajax:error', (e, xhr, status, error) =>
          @messages = xhr.responseJSON.messages
          @context = 'danger'
          @focus()
    ready: ->
      Miclo.textcomplete($(@$el).find('textarea').eq(0))

  if $('#vue-new-post').length
    Miclo.newPostVue = new Vue
      el: '#vue-new-post'
      data:
        post: Miclo.newPost
      paramAttributes: ['previewPath']

  Miclo.newPostModal = ->
    id = 'vue-new-post-modal'
    el = $("##{id}").clone().attr('id', "#{id}-#{new Date().getTime()}").appendTo(document.body)
    Miclo.newPostModalVue = new Vue
      el: "##{el.prop('id')}"
      paramAttributes: ['previewPath']
      created: ->
        @setAjaxEventListeners()
        @setModalEventListeners()
      methods:
        setAjaxEventListeners: ->
          $(@$el).on 'ajax:success', (e, data, status, xhr) =>
            Miclo.newPostVue.post.topic = data.post.topic if Miclo.newPostVue
            setTimeout =>
              @hide()
            , 300
        setModalEventListeners: ->
          $(@$el).on 'hidden.bs.modal', (e) =>
            Miclo.newPostModalVue = null
            @$destroy()
          $(@$el).on 'shown.bs.modal', (e) =>
            @$.form.focus()
        show: ->
          $(@$el).modal 'show'
        hide: ->
          $(@$el).modal 'hide'

