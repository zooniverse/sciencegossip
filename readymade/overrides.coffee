require './shims/classlist.js'
require './marking-surface'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{header} = currentProject
{decisionTree, subjectViewer} = classify_page
  
classify_page.el.on 'activate-in-stack', ->
  if classify_page.tutorial.el.getAttribute('aria-hidden') is 'false'
    setTimeout => classify_page.tutorial.active_button?.focus()

  
    