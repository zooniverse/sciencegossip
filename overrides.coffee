MAX_PAGE_WIDTH = 600

require './readymade/overrides.coffee'
Group = require 'zooniverse/models/project-group'
SubjectViewer = require 'zooniverse-readymade/lib/subject-viewer'

SubjectViewer::template = require './templates/subject-viewer'

SubjectViewer::rescale = ()->
  width = Math.min MAX_PAGE_WIDTH, @markingSurface.el.parentNode.offsetWidth
  scale = width / @maxWidth
  @markingSurface.maxWidth = @maxWidth
  @markingSurface.maxHeight = @maxHeight
  @markingSurface.svg.attr
    width: scale * @maxWidth
    height: scale * @maxHeight

ClassifyPage = require 'zooniverse-readymade/lib/classify-page'

ClassifyPage::template = require './templates/classify-page'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

# set the image scale if not already set  
ms.on 'marking-surface:add-tool', (tool) ->
  @rescale() if @scaleX is 0

LAST_TASK = true
INITIAL_STEPS = 2 # number of initial steps before annotating rectangles
ANNOTATION_STEPS = 2 # number of annotation steps per rectangle
MARGIN = 25 # margin on cropped images

current_tool = null
rect_index = 0

bhl_link = document.querySelector('a[target=bhl]')
page_zoom = document.querySelector('input[name=pagezoom]')
help = document.querySelector('input[name=help]')

classify_page.fieldGuideContainer.attr 'aria-hidden', !help.checked

# moving back and forward through the array of marked SVG rectangles
classify_page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task}})->
  rectangles = []
  page_zoom.disabled = true
  
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
    current_tool?.el.classList.remove 'selected'
  
  if task.key in ['details', 'parts'] and rectangles.length > 0
    page_zoom.disabled = false
    current_tool?.el.classList.remove 'selected'
    current_tool = rectangles[rect_index]
    w = current_tool?.mark.width + MARGIN * 2
    h = current_tool?.mark.height + MARGIN * 2
    ms.rescale current_tool?.mark.left - MARGIN, current_tool?.mark.top - MARGIN, w, h
    current_tool?.el.classList.add 'selected'
  
  if task.key is 'details'
    value = current_tool?.mark.details
    task.reset value if value?
  
  if task.key is 'details'
    LAST_TASK = rect_index == rectangles.length - 1 if rectangles.length
    if LAST_TASK
      task.next = 'review'
    else
      task.next = 'parts'

classify_page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task}})->
  task.reset 'yes' if task.key is 'illustrations'
  page_zoom.checked = false

classify_page.el.on decisionTree.CHANGE, ({originalEvent: {detail}})->
  {key, value} = detail

  if decisionTree.currentTask.getNext()
    label = 'OK'
  else
    label = 'Finish'
  decisionTree.currentTask.confirmButton.innerHTML = label if label?
  
  current_tool?.mark.details = value if key is 'details'
  current_tool?.mark.parts = value if key is 'parts'

classify_page.on classify_page.LOAD_SUBJECT, (e, subject)->
  ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
  
  bhl_link.setAttribute 'href', "http://biodiversitylibrary.org/page/#{subject.metadata.page_id}"
  current_tool = null
  
  group = (group for group in currentProject.groups when group.zooniverse_id is subject.group.zooniverse_id)
  classify_page.el.find('h2.group-title').text group[0].metadata.title

Group.on 'fetch', (e, groups) ->
  currentProject.groups = groups
  
ms.on 'marking-surface:add-tool', (tool) ->
  {label} = decisionTree.currentTask.getChoice() ? ''
  legend = tool.controls.el.querySelector 'legend'
  legend.innerText = label if legend?

page_zoom.addEventListener 'change', (e) ->
  return unless current_tool?
  if @.checked
    ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
  else
    w = current_tool.mark.width + MARGIN * 2
    h = current_tool.mark.height + MARGIN * 2
    ms.rescale current_tool.mark.left - MARGIN, current_tool.mark.top - MARGIN, w, h

help.addEventListener 'change', (e) ->
  classify_page.fieldGuideContainer.attr 'aria-hidden', !@.checked
    
