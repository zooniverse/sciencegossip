DecisionTree = require 'zooniverse-decision-tree'
{Task} = DecisionTree

class DetailsTask extends DecisionTree.Task
  @type: 'details'
  
  taskTypes:
    select: require './select'
    text: require './text'
    textarea: require './textarea'
  
  template: -> """
    <div class='decision-tree-question'>#{@question}</div>

    <form class='decision-tree-choices'>
      <fieldset>
        <legend>#{@legend}</legend>
      </fieldset>
    </form>

    <div class='decision-tree-confirmation'>
      <button type='button' name='#{@confirmButtonName}'>#{@confirmButtonLabel}</button>
    </div>
  """
  
  enter: =>
    console.log 'enter'
    super
  
  renderTemplate: =>
    super
    
    @addChoiceTask choice, i for choice, i in @choices
    
    @form = $(@el).find 'form'
    if @value?
      @form.find("[name=#{o.name}]").val(o.value) for o in @value.details

  getNext: =>
    @next
  
  exit: ->
    console.log 'exit'
    super

  getChoice: ->

  getValue: ->
    @value.details = @form.serializeArray()
    @value

  reset: (value) ->
    console.log 'reset' unless value?
    value ?=
      details: [{name: 'type', value: 'drawing/painting/diagram'}, {name: 'keywords', value: ''}]
    
    @form.find("[name=#{o.name}]").val(o.value) for o in value.details
    @value = value
  
  addChoiceTask: (choice, i) ->
    fieldset = @el.querySelector 'fieldset'
    
    task = new @taskTypes[choice.type]
    html = task.choiceTemplate choice, i
    fieldset.insertAdjacentHTML 'beforeend', html
    
    choice

DecisionTree.registerTask DetailsTask

DecisionTree.DetailsTask = DetailsTask
module?.exports = DetailsTask