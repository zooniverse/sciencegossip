require './shims/classlist.js'
require './marking-surface'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{header} = currentProject
{decisionTree, subjectViewer} = classify_page
  
classify_page.el.on 'activate-in-stack', ->
  if classify_page.tutorial.el.getAttribute('aria-hidden') is 'false'
    setTimeout => classify_page.tutorial.active_button?.focus()

console.log header
# build tabbed main nav
header.buildNav()

# add external links
externalLinks =
  Blog: 'http://blog.zooniverse.org'
  Twitter: 'http://twitter.com/the_zooniverse'
header.addNavLink href, title for title, href of externalLinks

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
  
    