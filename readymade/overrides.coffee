require './shims/classlist.js'
require './project'
require './marking-surface'
require './site-header'
team_page = require './team-page'
      
FieldGuide = require './field-guide/field-guide'
MiniTutorial = require './tutorial/mini-tutorial'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{header} = currentProject
{decisionTree, subjectViewer} = classify_page

# map element IDs to ARIA landmarks
document.getElementById( id ).setAttribute( 'role', role ) for id, role of {
  'main-header': 'banner'
  'main-content': 'main'
  'main-footer': 'contentinfo'
  }

# new field guide with keyboard a11y improvements
field_guide = new FieldGuide 
  examples: require './field-guide/examples'
classify_page.fieldGuideContainer.append field_guide.el

# new mini-tutorial with a11y improvements  
classify_page.tutorial = new MiniTutorial
  steps: require './tutorial/tutorial-steps'
classify_page.el.append classify_page.tutorial.el
  
classify_page.el.on 'activate-in-stack', ->
  if classify_page.tutorial.el.getAttribute('aria-hidden') is 'false'
    setTimeout => classify_page.tutorial.active_button?.focus()

# new template for team page
currentProject.addPage '#/team', 'Team', team_page

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
  
    