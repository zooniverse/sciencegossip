DecisionTree = require 'zooniverse-decision-tree'

class TextareaTask extends DecisionTree.Task
  choiceTemplate: (choice, i) -> "
  <label class=''>

      #{if choice.image? then "<div class='readymade-choice-image'><img src='#{choice.image}' /></div>" else ''}

      <span class='readymade-choice-label'>#{choice.label ? choice.value ? i}</span>
      
      <textarea
        name='#{choice.key}'
        value='#{choice.value}'
        data-choice-index='#{i}'
        cols=27
        rows=7
        #{if choice.placeholder? then "placeholder='#{choice.placeholder}'" else ''}
      ></textarea>
  </label>
  "
  
  getValue: ->
    output = {}
    inputs = @el.querySelectorAll "textarea"
    output[input.name] = input.value for input in inputs
    
    output
    
  reset: (values) ->
    inputs = @el.querySelectorAll "textarea"
    input.value = '' for input in inputs
    
    for name of values
      input = @el.querySelector "textarea[name=#{name}]"
      input.value = values[name]
    
    
  
module.exports = TextareaTask