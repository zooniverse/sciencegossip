require './readymade/overrides.coffee'
DetailsTask = require './tasks/details'
DecisionTree = require 'zooniverse-decision-tree'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

ms.rescale = (x, y, width, height) ->
  return if ms.root.el.getBoundingClientRect().width is 0 # don't rescale when surface isn't visible
  currentViewBox = @svg.attr('viewBox')?.split /\s+/
  x ?= currentViewBox?[0] ? 0
  y ?= currentViewBox?[1] ? 0
  width ?= currentViewBox?[2] ? 0
  height ?= currentViewBox?[3] ? 0
  @svg.attr 'viewBox', [x, y, width, height].join ' '
  @scaleX = ms.root.el.getBoundingClientRect().width / subjectViewer.maxWidth
  @scaleY = ms.root.el.getBoundingClientRect().height / subjectViewer.maxHeight
  ms.magnification = ms.root.el.getBoundingClientRect().width / subjectViewer.maxWidth
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
  ms.rescale() if ms.magnification is 0

# moving back and forward through the array of marked SVG rectangles
classify_page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task}})->
  if task.key is 'illustration'
    ms.rescale(0,0,subjectViewer.maxWidth,subjectViewer.maxHeight)
    DetailsTask.currentIndex = 0 
  
  if task.key is 'details'
    index = task.value.index
    console.log index
    tool = ms.tools[index]
    tool.select()
    if tool.mark.details?
      task.reset
        index: index
        details: tool.mark.details
    ms.rescale tool.mark.left - 10, tool.mark.top - 10, tool.mark.width + 20, tool.mark.height + 20
    if index == ms.tools.length - 1
      task.next = null
    else
      task.next = 'details'
  
classify_page.el.on 'decision-tree:task-confirm', ({originalEvent: {detail}})->
  console.log 'confirm'
  
  if detail.details?
    ms.tools[detail.index].mark.details = detail.details