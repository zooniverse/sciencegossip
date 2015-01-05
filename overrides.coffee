require './readymade/overrides.coffee'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

# set the image scale if not already set  
ms.on 'marking-surface:add-tool', (tool) ->
  @rescale() if @scaleX is 0

LAST_TASK = false
INITIAL_STEPS = 2 # number of initial steps before annotating rectangles
ANNOTATION_STEPS = 2 # number of annotation steps per rectangle
MARGIN = 25 # margin on cropped images

current_tool = null

bhl_link = document.createElement 'a'
bhl_link.classList.add 'readymade-clickable'
bhl_link.setAttribute 'href', ''
bhl_link.setAttribute 'target', 'bhl'
bhl_link.innerText = 'Read page on BHL'

drawing_controls = document.querySelector '.drawing-controls'
drawing_controls.appendChild bhl_link

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
    ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
  
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

classify_page.on classify_page.LOAD_SUBJECT, (e, subject)->
  ms.maxWidth = subjectViewer.maxWidth
  ms.maxHeight = subjectViewer.maxHeight
  ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
  
  bhl_link.setAttribute 'href', subject.metadata.bhl_url
