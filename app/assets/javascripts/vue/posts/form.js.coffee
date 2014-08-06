Miclo.PostFormComponent = Vue.extend
  methods:
    preview: _.throttle (e) ->
      $.post @previewPath, { 'post[content]' : @post.content }, (data) =>
        @messages = []
        @post.content_html = data.content_html

        Miclo.prettify()
    , 1000
    focus: ->
      $(@$el).find('textarea').eq(0).focus()


