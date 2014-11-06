DecisionTree = require 'zooniverse-decision-tree'

class DetailsTask extends DecisionTree.Task
  @type: 'details'
  @currentIndex: 0

  choiceTemplate: require './details-form'
  
  enter: =>
    console.log 'enter'
    super
    DetailsTask.currentIndex ?= 0
    @value ?=
      index: DetailsTask.currentIndex

  getNext: =>
    DetailsTask.currentIndex++
    @next
  
  exit: ->
    console.log 'exit'
    super

  getChoice: ->

  getValue: ->
    @value

  reset: (value) ->
    @value = value

DecisionTree.registerTask DetailsTask

DecisionTree.DetailsTask = DetailsTask
module?.exports = DetailsTask