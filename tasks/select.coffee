DecisionTree = require 'zooniverse-decision-tree'

class SelectTask extends DecisionTree.Task
  choiceTemplate: (choice, i) -> "
  <label class=''>

      #{if choice.image? then "<div class='readymade-choice-image'><img src='#{choice.image}' /></div>" else ''}

      <span class='readymade-choice-label'>#{choice.label ? choice.value ? i}</span>
        
      <select name='#{choice.key}'>
        #{("
          <option>#{option}</option>
        " for option in choice.options).join '\n'}
      </select>
  </label>
  "
  
  getValue: ->
    output = {}
    inputs = @el.querySelectorAll "select"
    output[input.name] = input.value for input in inputs
    
    output
    
  reset: (values) ->
    inputs = @el.querySelectorAll "select"
    input.value = '' for input in inputs
    
    for name of values
      input = @el.querySelector "select[name=#{name}]"
      input.value = values[name]
    
    
  
module.exports = SelectTask