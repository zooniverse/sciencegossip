require './readymade/overrides.coffee'
DetailsTask = require './tasks/details'
DecisionTree = require 'zooniverse-decision-tree'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

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