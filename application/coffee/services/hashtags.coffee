angular.module('app.services').factory 'hashtags', (generator) ->

  _.memoize ->
    generator 'hashtag', chance.integer min: 5, max: 20
