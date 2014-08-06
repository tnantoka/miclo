$ ->
  Miclo.navbarVue = new Vue
    el: '#vue-navbar-top'
    paramAttributes: ['userId', 'username']
    ready: ->
      Miclo.typeahead $('#q_posts_content_cont')
    methods:
      scrollToTop: (e) ->
        return true if _.contains(['A', 'INPUT', 'BUTTON'], e.target.tagName)
        $('html, body').animate({ scrollTop: 0 }, 'fast')
      newPost: ->
        @modal = Miclo.newPostModal()
        @modal.show()
      setUser: (userId, username) ->
        @userId = userId
        @username = username

