angular.module('app.controllers').controller 'element', ($scope, regions, hashtags) ->
  $scope.regions = regions()
  $scope.hashtags = hashtags()
