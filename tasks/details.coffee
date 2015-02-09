DecisionTree = require 'zooniverse-decision-tree'
{Task} = DecisionTree

class DetailsTask extends DecisionTree.Task
  @type: 'details'
  
  taskTypes:
    select: require './select'
    text: require './text'
    textarea: require './textarea'
  
  defaults: {}
  
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
    super
  
  renderTemplate: =>
    super
    
    @addChoiceTask choice, i for choice, i in @choices
    
    @form = $(@el).find 'form'
    if @defaults?
      @form.find("[name=#{key}]").val(value) for key, value of @defaults

  getNext: =>
    @next
  
  exit: ->
    super

  getChoice: ->

  getValue: ->
    form = @form.serializeArray()
    value = {}
    
    value[o.name] = o.value for o in form
    
    value

  reset: (value) ->
    value ?= @defaults
    
    @form.find("[name=#{k}]").val(v) for k, v of value
  
  addChoiceTask: (choice, i) ->
    fieldset = @el.querySelector 'fieldset'
    
    task = new @taskTypes[choice.type]
    html = task.choiceTemplate choice, i
    fieldset.insertAdjacentHTML 'beforeend', html
    
    @defaults[choice.key] = choice.value
    
    choice

DecisionTree.registerTask DetailsTask

DecisionTree.DetailsTask = DetailsTask
module?.exports = DetailsTask