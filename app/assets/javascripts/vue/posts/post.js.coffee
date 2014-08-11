Vue.component 'post',
  template: '#vue-post-template',
  replace: true,
  ready: ->
    Miclo.prettify()
  created: ->
    @setAjaxEventListeners()
  computed:
    timeAgo: ->
      updated = moment(@post.updated_at)
      "<span title=\"#{updated.format()}\">#{updated.fromNow()}</span>"
  methods:
    setAjaxEventListeners: ->
      $(@$el).on 'ajax:success', (e, data, status, xhr) =>
        if status == 'nocontent'
          e.stopPropagation()
          @$parent.removePost(@post)
          @$destroy()
    editPost: ->
      @modal = Miclo.editPostModal(@post, (data) ->
        @post = data
      )
      @modal.show()
    canManage: ->
      @post.user.id == Miclo.currentUser.id

$ ->
  if $('#vue-post').length
    Miclo.postVue = new Vue
      el: '#vue-post'
      data:
        post: Miclo.post

