angular.module('app.controllers').controller 'main', ($scope, blocks) ->

  $scope.blocks = blocks()
  $scope.group_by_fields = []

  $scope.fields_to_group_by = [
    'region.name'
    'region.color'
    'first_name'
    'last_name'
    'tags'
    'created_at'
  ]

  $scope.toggle_group_by = (field) ->
    if 0 <= _.indexOf $scope.group_by_fields, field
      $scope.group_by_fields = _.without $scope.group_by_fields, field
    else
      $scope.group_by_fields = $scope.group_by_fields.concat field
