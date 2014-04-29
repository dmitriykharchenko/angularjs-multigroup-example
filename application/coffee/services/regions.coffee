angular.module('app.services').factory 'regions', (generator) ->
  region_schema =
    name: 'word'
    color:
      type: 'color'
      params:
        [format: 'hex']


  _.memoize ->
    generator region_schema, chance.integer min: 5, max: 12
