DecisionTree = require 'zooniverse-decision-tree'

class TextTask extends DecisionTree.Task
  choiceTemplate: (choice, i) -> "
  <label class=''>

      #{if choice.image? then "<div class='readymade-choice-image'><img src='#{choice.image}' /></div>" else ''}

      <span class='readymade-choice-label'>#{choice.label ? choice.value ? i}</span>
      
      <input type='text'
        name='#{choice.key}'
        value='#{choice.value}'
        data-choice-index='#{i}'
      />
  </label>
  "
  
  getValue: ->
    output = {}
    inputs = @el.querySelectorAll "input[type=text]"
    output[input.name] = input.value for input in inputs
    
    output
    
  reset: (values) ->
    inputs = @el.querySelectorAll "input[type=text]"
    input.value = '' for input in inputs
    
    for name of values
      input = @el.querySelector "input[name=#{name}]"
      input.value = values[name]
    
    
  
module.exports = TextTask