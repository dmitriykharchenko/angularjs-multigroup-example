angular.module('app.directives').directive 'appGroup', ($filter, assort) ->

  restrict: 'E'

  scope:
    collection: '='
    groupFields: '='
    elementTemplate: '='

  templateUrl: 'directives/group'

  controller: ($scope) ->
    $scope.update_groups = ->
      $scope.groups = undefined
      $scope.elements = undefined

      if $scope.group_by_field
        $scope.groups = assort $scope.collection, $scope.group_by_field
      else
        $scope.elements = $scope.collection

    $scope.update_group_fields = ->
      $scope.group_fields = _.compact [].concat $scope.groupFields
      $scope.group_by_field = $scope.group_fields.shift()
      $scope.update_groups()


  link: ($scope, $element, $attrs) ->

    $scope.$watch 'groupFields', (value, old_value) ->
      if value isnt old_value
        $scope.update_group_fields()


    $scope.$watch 'collection', (value, old_value) ->
      if value isnt old_value and $scope.group_by_field
        $scope.update_groups()

    , true

    $scope.update_group_fields()
