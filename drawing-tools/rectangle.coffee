RectangleTool = require 'marking-surface/lib/tools/rectangle'
ToolControls = require './tool-controls'

class Rectangle extends RectangleTool
  @Controls: ToolControls
  
  coords: (e) ->
    @markingSurface.screenPixelToScale @markingSurface.svg.pointerOffset e
    
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