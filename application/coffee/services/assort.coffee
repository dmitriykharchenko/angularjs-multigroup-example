angular.module('app.services').service 'assort', ($parse) ->

  (list, group_by) ->
    if not group_by
      return collection: list

    values = []
    groups = {}
    groups_order = []

    for item in list
      if _.isFunction group_by
        group_by_value = group_by item

      else if _.isString group_by
        group_by_value = $parse(group_by)(item)

      values = if _.isArray(group_by_value) then group_by_value else [group_by_value]

      for value in values
        groups_order.push value
        groups[value] ?= []
        groups[value].push item

    groups_order = _.uniq groups_order

    grouped = []

    for group_field_value in groups_order
      data = {}
      data[group_by] = group_field_value

      grouped.push
        collection: groups[group_field_value]
        group_by: group_by
        name: group_field_value

    grouped
