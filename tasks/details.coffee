DecisionTree = require 'zooniverse-decision-tree'

class DetailsTask extends DecisionTree.Task
  @type: 'details'
  
  template: -> """
    <div class='decision-tree-question'>#{@question}</div>

    <form class='decision-tree-choices'>
      <label class='readymade-choice-label'>Type
        <select name="type">
          <option>Lithograph</option>
          <option>Etching</option>
          <option>Drawing</option>
        </select>
      </label>
      <label class='readymade-choice-label'>Artist
        <input type=text name=artist>
      </label>
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
      details: [{name: 'type', value: 'Lithograph'}, {name: 'artist', value: ''}]
    
    @form.find("[name=#{o.name}]").val(o.value) for o in value.details
    @value = value

DecisionTree.registerTask DetailsTask

DecisionTree.DetailsTask = DetailsTask
module?.exports = DetailsTask