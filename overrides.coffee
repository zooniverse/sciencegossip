require './readymade/overrides.coffee'
DetailsTask = require './tasks/details'

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
    tool = ms.tools[index]
    task.reset 
      index: index
    tool.select()
    ms.rescale tool.mark.left - 10, tool.mark.top - 10, tool.mark.width + 20, tool.mark.height + 20
    if DetailsTask.currentIndex == ms.tools.length - 1
      task.next = null
    else
      task.next = 'details'
  
    