DecisionTree = require 'zooniverse-decision-tree'

class DetailsTask extends DecisionTree.Task
  @type: 'details'
  
  template: -> """
    <div class='decision-tree-question'>#{@question}</div>

    <form class='decision-tree-choices'>
      <fieldset>
        <legend>Illustration</legend>
        <label class='readymade-choice-label'>Type
          <select name="type">
            <option selected>drawing/painting/diagram</option>
            <option>chart/table</option>
            <option>photograph</option>
            <option>bookplate</option>
            <option>map</option>
          </select>
        </label>
        <label class='readymade-choice-label'>Keywords
          <textarea name=keywords></textarea>
        </label>
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

DecisionTree.registerTask DetailsTask

DecisionTree.DetailsTask = DetailsTask
module?.exports = DetailsTask