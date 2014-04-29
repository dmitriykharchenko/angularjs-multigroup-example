angular.module('app.services').factory 'generator', ->

  generate_item = (schema) ->
    if _.isString schema
      return chance[schema]()

    else
      item = {}

      for key, type of schema
        if _.isString type
          item[key] = chance[type]()
        else
          if type.amount
            amount = chance.integer type.amount
            item[key] = for index in [0...amount]
              chance[type.type](type.params)
          else
            args = _.result type, 'params'
            console.log args
            item[key] = chance[type.type].apply(chance, args)

      return item

  (schema, amount) ->
    for index in [0...amount]
      generate_item schema
