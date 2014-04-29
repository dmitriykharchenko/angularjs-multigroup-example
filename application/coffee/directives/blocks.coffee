angular.module('app.directives').directive 'appBlocks', ($filter, assort) ->

  restrict: 'E'

  scope:
    collection: '='
    groupByFields: '='

  templateUrl: 'directives/blocks'
