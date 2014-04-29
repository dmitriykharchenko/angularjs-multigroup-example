angular.module('app.services').factory 'blocks', (generator, regions, hashtags) ->

  random = ->
    chance.integer min: 3, max: 15


  block_schema =
    region:
      type: 'pick'

    tags:
      type: 'pick'

    created_at: 'date'
    description: 'paragraph'
    hash: 'hash'

    first_name:
      type: 'pick'
      params: [generator 'first', random()]

    last_name:
      type: 'pick'
      params: [generator 'last', random()]


  _.memoize ->
    block_schema.region.params = [regions()]
    block_schema.tags.params = -> [hashtags(), random()]

    generator block_schema, chance.integer min: 30, max: 60
