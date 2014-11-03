ToolControls = require 'zooniverse-readymade/lib/drawing-tools/tool-controls'

class AccessibleControls extends ToolControls
  
  constructor: ->
    super
    
    @tool.addEvent 'marking-surface:tool:select', @onToolSelect
    @tool.addEvent 'marking-surface:tool:deselect', @onToolDeselect
    
    delete_button = @el.querySelector 'button[name="readymade-destroy-drawing"]'
    dismiss_button = @el.querySelector 'button[name="readymade-dismiss-details"]'
    
    delete_button.setAttribute 'aria-label', 'Delete'
    
    @addEvent 'keydown', 'button[name="readymade-destroy-drawing"]', (e) =>
      if @details? && e.which == 9 && e.shiftKey
        dismiss_button.focus()
        e.preventDefault()
        
    @addEvent 'keydown', 'button[name="readymade-dismiss-details"]', (e) =>
      if e.which == 9 && !e.shiftKey
        delete_button.focus()
        e.preventDefault()
  
  onToolSelect: =>
    @current_focus = document.activeElement
    
  onToolDeselect: =>
    @current_focus.focus()
  
module.exports = AccessibleControls