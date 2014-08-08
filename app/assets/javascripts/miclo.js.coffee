window.Miclo =
  prettify: ->
    Vue.nextTick prettyPrint
  lang: ->
    $('html').prop('lang')
  typeahead: ($el) ->
    engine = new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('text')
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch:
        url: '/queries'
        #ttl: (1 * 1000 * 60 * 60) # 1 hour
        ttl: 0
    #engine.clearPrefetchCache()
    engine.initialize()
    $el.typeahead {
      hint: false
      highlight: true
    }, {
      name: 'queries'
      displayKey: 'text'
      source: engine.ttAdapter()
    }
  textcomplete: ($el) ->
    $el.textcomplete [
      match: /(^|[\s　])#([^\s　]*)$/
      search: (term, callback) ->
        regexp = new RegExp('^#' + term)
        callback $.grep Miclo.hashtags, (hashtag) ->
          regexp.test(hashtag.name)
      replace: (value) ->
        "$1#{value.name} "
      template: (value) ->
        value.name
    ]

$ ->
  initMousetrap()
  initMoment()
  fetchHashtags()

initMousetrap = ->
  Mousetrap.bind 'n', ->
    if Miclo.newPostVue
      Miclo.newPostVue.$.form.focus()
    else if !Miclo.newPostModalVue
      Miclo.navbarVue.newPost()

  Mousetrap.bindGlobal 'mod+enter', ->
    if Miclo.editPostModalVue
      $(Miclo.editPostModalVue.$el).find('button[type=submit]').click()
    else if Miclo.newPostModalVue
      $(Miclo.newPostModalVue.$el).find('button[type=submit]').click()
    else if Miclo.newPostVue
      $(Miclo.newPostVue.$el).find('button[type=submit]').click()

  Mousetrap.bindGlobal ['mod+left', 'mod+right'], ->
    if Miclo.newPostModalVue
      $(Miclo.newPostModalVue.$el).find('#post_topic_id:not(:checked)').parent(':visible').click()
    else if Miclo.newPostVue
      $(Miclo.newPostVue.$el).find('#post_topic_id:not(:checked)').parent(':visible').click()

initMoment = ->
  moment.locale(Miclo.lang())

fetchHashtags = ->
  Miclo.hashtags = []
  $.getJSON '/hashtags', (data) ->
    Miclo.hashtags = data


