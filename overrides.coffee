require './readymade/overrides.coffee'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

ms.rescale = (x, y, width, height) ->
  root = @root.el.getBoundingClientRect()
  return if root.width is 0 # don't rescale when surface isn't visible
  currentViewBox = @svg.attr('viewBox')?.split /\s+/
  x ?= parseInt currentViewBox?[0] ? 0
  y ?= parseInt currentViewBox?[1] ? 0
  width ?= parseInt currentViewBox?[2] ? 0
  height ?= parseInt currentViewBox?[3] ? 0
  @svg.attr 'viewBox', [x, y, width, height].join ' '
  
  root = @root.el.getBoundingClientRect()
  @scaleX = root.width / subjectViewer.maxWidth
  @scaleY = root.height / subjectViewer.maxHeight
  @magnification = (@scaleX + @scaleY) / 2
  
  # recalculate the viewbox so that the aspect ratio matches the SVG element
  w = parseInt @svg.attr 'width'
  h = parseInt @svg.attr 'height'
  w = w / @scaleX
  h = h / @scaleY
  x = x + .5 * (width - w)
  y = y + .5 * (height - h)
  x = Math.max x, 0
  y = Math.max y, 0
  x = Math.min x, subjectViewer.maxWidth - w
  y = Math.min y, subjectViewer.maxHeight - h
  @svg.attr 'viewBox', [x, y, w, h].join ' '
  @renderTools()

ms.screenPixelToScale = ({x, y}) ->
  if @svg.el.viewBox.animVal?
    x = x / @scaleX
    y = y / @scaleY
    viewBox = @svg.el.viewBox.animVal
    x += viewBox.x
    y += viewBox.y
  {x, y}

ms.scalePixelToScreen = ({x, y}) ->
  if @svg.el.viewBox.animVal?
    viewBox = @svg.el.viewBox.animVal
    x -= viewBox.x
    y -= viewBox.y
    x = x * @scaleX
    y = y * @scaleY
  {x, y}

# set the image scale if not already set  
ms.on 'marking-surface:add-tool', (tool) ->
  @rescale() if @scaleX is 0

LAST_TASK = false
INITIAL_STEPS = 2 # number of initial steps before annotating rectangles
ANNOTATION_STEPS = 2 # number of annotation steps per rectangle
MARGIN = 25 # margin on cropped images

current_tool = null

# moving back and forward through the array of marked SVG rectangles
classify_page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task}})->
  rectangles = []
  for tool in ms.tools
    tool.deselect()
    tool.disable()
    rectangles.push tool if tool.mark._taskIndex is 1
    if tool.attr(subjectViewer.FROM_CURRENT_TASK) == 'true'
      tool.enable()
      tool.select()
  
  rect_index = parseInt (subjectViewer.taskIndex - INITIAL_STEPS) / ANNOTATION_STEPS
  
  if task.key in ['illustration', 'review']
    subjectViewer.rescale()
    ms.rescale(0,0,subjectViewer.maxWidth,subjectViewer.maxHeight)
  
  if task.key in ['details', 'parts'] and rectangles.length > 0
    current_tool = rectangles[rect_index]
    w = current_tool.mark.width + MARGIN * 2
    h = current_tool.mark.height + MARGIN * 2
    ms.svg.attr 'width', w
    ms.svg.attr 'height', h
    ms.rescale current_tool.mark.left - MARGIN, current_tool.mark.top - MARGIN, w, h
  
  if task.key is 'details'
    task.reset if current_tool.mark.details?
      details: current_tool.mark.details
  
  if task.key is 'parts'
    LAST_TASK = rect_index == rectangles.length - 1
    if LAST_TASK
      task.next = 'review'
    else
      task.next = 'details'
  
classify_page.el.on decisionTree.CHANGE, ({originalEvent: {detail}})->
  {key, value} = detail
  
  if key is 'details'
    current_tool.mark.details = value.details
    
