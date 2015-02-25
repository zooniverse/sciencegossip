{Mark} = require 'marking-surface'

class PointMark extends Mark
  
  inside: (rectangle) ->
    @x >= rectangle.left && 
    @x <= (rectangle.left + rectangle.width) && 
    @y >= rectangle.top && 
    @y <= (rectangle.top + rectangle.height)

module.exports = PointMark