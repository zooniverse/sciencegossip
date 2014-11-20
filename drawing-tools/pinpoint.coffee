BasePoint = require 'zooniverse-readymade/lib/drawing-tools/point'
ToolControls = require './tool-controls'

class Pinpoint extends BasePoint
  @Controls: ToolControls
  
  constructor: ->
    super
    @disc.attr 'class', 'pinpoint'

  rescale: (scale) ->
    super
  
  coords: (e) ->
    @markingSurface.screenPixelToScale @markingSurface.svg.pointerOffset e

  onMove: (e) =>
    {x, y} = @coords e
    @mark.set {x, y}

  render: ->
    super
    
    offset = @radius / @markingSurface.magnification
    
    @controls.moveTo
      x: @mark.x + offset
      y: @mark.y

module.exports = Pinpoint