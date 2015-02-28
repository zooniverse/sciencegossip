ToolControls = require 'zooniverse-readymade/lib/drawing-tools/tool-controls'
{Task} = require 'zooniverse-decision-tree'

class AccessibleControls extends ToolControls
  template: require('../templates/tool-controls')()
  
  constructor: ->
    super
    
    @taskTypes.text = require '../tasks/text'
    @taskTypes.textarea = require '../tasks/textarea'
    @taskTypes.select = require '../tasks/select'
    
    @tool.addEvent 'marking-surface:tool:select', @onToolSelect
    @tool.addEvent 'marking-surface:tool:deselect', @onToolDeselect
    
    delete_button = @el.querySelector 'button[name="readymade-destroy-drawing"]'
    dismiss_button = @el.querySelector 'button[name="readymade-dismiss-details"]'
    
    delete_button.setAttribute 'aria-label', 'Delete'
    @addFieldset @label if @label?
    
    @addEvent 'keydown', 'button[name="readymade-destroy-drawing"]', (e) =>
      if @details? && e.which == 9 && e.shiftKey
        dismiss_button.focus()
        e.preventDefault()
        
    @addEvent 'keydown', 'button[name="readymade-dismiss-details"]', (e) =>
      if e.which == 9 && !e.shiftKey
        delete_button.focus()
        e.preventDefault()
    
    @addEvent 'submit', 'form', (e) =>
      e.preventDefault()
  
  onToolSelect: =>
    @current_focus = document.activeElement
    # autofocus the first field in the details form.
    # doesn't seem to work without the 250ms delay.
    setTimeout =>
      @el.querySelector('input, select, textarea')?.focus()
    , 250
    
  onToolDeselect: =>
    @current_focus.focus()
    
  addDetail: (detail) ->
    if @label?
      selector = 'fieldset'
    else
      selector = 'form'
      
    form = @el.querySelector selector

    unless detail instanceof Task
      detail = new @taskTypes[detail.type] detail
    @detailTasks[detail.key] = detail
    detail.renderTemplate()
    detail.show()
    form.appendChild detail.el
  
  addFieldset: (legend) ->
    form = @el.querySelector 'form'
    form.insertAdjacentHTML 'afterbegin', "<fieldset><legend>#{legend}</legend></fieldset>"
  
  render: ->
    
  
module.exports = AccessibleControls