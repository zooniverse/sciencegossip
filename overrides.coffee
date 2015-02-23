MAX_PAGE_WIDTH = 600

require './readymade/overrides.coffee'
Group = require 'zooniverse/models/project-group'
SubjectViewer = require 'zooniverse-readymade/lib/subject-viewer'
DecisionTree = require 'zooniverse-decision-tree'

SubjectViewer::template = require './templates/subject-viewer'

SubjectViewer::rescale = ()->
  width = Math.min MAX_PAGE_WIDTH, @markingSurface.el.parentNode.offsetWidth
  scale = width / @maxWidth
  @markingSurface.maxWidth = @maxWidth
  @markingSurface.maxHeight = @maxHeight
  @markingSurface.svg.attr
    width: scale * @maxWidth
    height: scale * @maxHeight

SubjectViewer::crop = (rectangle, margin = 25, limit = 1.5)->
  w = rectangle.width + margin * 2
  h = rectangle.height + margin * 2
  scale = @markingSurface.el.parentNode.offsetWidth / w
  scale = Math.min scale, limit
  @markingSurface.svg.attr 'width', scale * w
  @markingSurface.svg.attr 'height', scale * h
  @markingSurface.rescale rectangle.left - margin, rectangle.top - margin, w, h

ClassifyPage = require 'zooniverse-readymade/lib/classify-page'

ClassifyPage::template = require './templates/classify-page'
  
DecisionTree.Task::confirmButtonLabel = 'Continue'

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
favorite = document.querySelector('input[name=favorite]')

classify_page.fieldGuideContainer.attr 'aria-hidden', !help.checked
  
classify_page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task}})->
  task.reset 'yes' if task.key is 'illustrations'
  page_zoom.checked = false
  favorite.checked = false

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
    page_zoom.checked = false
  
  if task.key in ['details', 'parts'] and rectangles.length > 0
    page_zoom.disabled = false
    page_zoom.checked = true
    current_tool?.el.classList.remove 'selected'
    current_tool = rectangles[rect_index]
    subjectViewer.crop current_tool.mark, MARGIN if current_tool?
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

classify_page.el.on decisionTree.CHANGE, ({originalEvent: {detail}})->
  {key, value} = detail
  
  if key is 'illustrations'
    label = decisionTree.currentTask.confirmButtonLabel
    label = 'Finish' unless decisionTree.currentTask.getNext()
    
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
  legend.textContent = label if legend?

page_zoom.addEventListener 'change', (e) ->
  return unless current_tool?
  if @.checked
    subjectViewer.crop current_tool.mark, MARGIN
  else
    subjectViewer.rescale()
    ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
    

help.addEventListener 'change', (e) ->
  classify_page.fieldGuideContainer.attr 'aria-hidden', !@.checked
    
