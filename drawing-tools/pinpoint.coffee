BasePoint = require 'zooniverse-readymade/lib/drawing-tools/point'
ToolControls = require './tool-controls'

class Pinpoint extends BasePoint
  @Controls: ToolControls
  
  constructor: ->
    super
    @disc.attr 'class', 'pinpoint'
    console.log @mark

  rescale: (scale) ->
    super
  
  coords: (e) ->
    @markingSurface.screenPixelToScale @markingSurface.svg.pointerOffset e

  onMove: (e) =>
    {x, y} = @coords e
    @mark.set {x, y}

  render: ->
    super
    
    @controls.moveTo
      x: @mark.x + 30
      y: @mark.y

module.exports = Pinpoint