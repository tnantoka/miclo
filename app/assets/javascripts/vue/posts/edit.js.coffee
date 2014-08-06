$ ->
  Vue.component 'edit-post', Miclo.PostFormComponent.extend
    template: '#vue-edit-post-template',
    replace: true,
    created: ->
      @setAjaxEventListeners()
    methods:
      setAjaxEventListeners: ->
        $(@$el).on 'ajax:error', (e, xhr, status, error) =>
          @messages = xhr.responseJSON.messages
          @context = 'danger'

  Miclo.editPostModal = (post, callback) ->
    id = 'vue-edit-post-modal'
    el = $("##{id}").clone().attr('id', "#{id}-#{new Date().getTime()}").appendTo(document.body)
    Miclo.editPostModalVue = new Vue
      el: "##{el.prop('id')}"
      paramAttributes: ['previewPath']
      data:
        post: post
      created: ->
        @setAjaxEventListeners()
        @setModalEventListeners()
      methods:
        setAjaxEventListeners: ->
          $(@$el).on 'ajax:success', (e, data, status, xhr) =>
            setTimeout =>
              @hide()
              callback(data) if callback
              Miclo.prettify()
            , 300
        setModalEventListeners: ->
          $(@$el).on 'hidden.bs.modal', (e) =>
            Miclo.editPostModalVue = null
            @$destroy()
          $(@$el).on 'shown.bs.modal', (e) =>
            @$.form.focus()
        show: ->
          $(@$el).modal 'show'
        hide: ->
          $(@$el).modal 'hide'

