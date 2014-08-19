Vue.filter 'encode', (value) ->
  encodeURIComponent(value)

$ ->
  if $('#vue-hashtags').length
    new Vue
      el: '#vue-hashtags'
      paramAttributes: ['hashtagsPath']
      data:
        hashtags: []
      created: ->
        @fetchHashtags()
      methods:
        fetchHashtags: ->
          $.getJSON @hashtagsPath, (data) =>
            @hashtags = data.slice(0, 5)
            @allHashtags = data.slice(5) if data.length > 5
        showMore: (e) ->
          e.preventDefault()
          @hashtags = @hashtags.concat(@allHashtags)
          @allHashtags = []

$ ->
  if $('#vue-queries').length
    new Vue
      el: '#vue-queries'
      paramAttributes: ['queriesPath']
      data:
        queries: []
      created: ->
        @fetchQueries()
      methods:
        fetchQueries: ->
          $.getJSON @queriesPath, (data) =>
            @queries = data.slice(0, 5)
            @allQueries = data.slice(5) if data.length > 5
        showMore: (e) ->
          e.preventDefault()
          @queries = @queries.concat(@allQueries)
          @allQueries = []

