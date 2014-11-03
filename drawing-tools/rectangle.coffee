RectangleTool = require 'marking-surface/lib/tools/rectangle'
ToolControls = require './tool-controls'

class Rectangle extends RectangleTool
  @Controls: ToolControls
  @count = 0
  defaultRadius: 20
  defaultSquash: 1.5
    
  render: ->
    super
    @controls.moveTo
      x: @mark.left + 5
      y: @mark.top - 5
  
  moveOutline: (e) ->
    super unless @disabled

  dragXHandle: (e) ->
    super unless @disabled


  dragYHandle: (e) ->
    super unless @disabled


module.exports = Rectangle