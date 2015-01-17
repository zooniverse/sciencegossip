require './shims/classlist.js'
require './marking-surface'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{header} = currentProject
{decisionTree, subjectViewer} = classify_page
  
classify_page.el.on 'activate-in-stack', ->
  if classify_page.tutorial.el.getAttribute('aria-hidden') is 'false'
    setTimeout => classify_page.tutorial.active_button?.focus()

# focus management for the decision tree.
decisionTree.autofocus = false

classify_page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {index}})->
  unless decisionTree.autofocus
    decisionTree.autofocus = true
    return
    
  if index > 0
    decisionTree.backButton.focus()
  else
    decisionTree.el.querySelector('input').focus()

classify_page.el.on decisionTree.COMPLETE, (e)->
  document.querySelector('button[name=readymade-dont-talk]').focus()
  
    