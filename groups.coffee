Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
Group = require 'zooniverse/models/project-group'
descriptions = require './content/groups'

class GroupsPage extends Controller
  
  template: (context) -> "
    <h2>Periodicals</h2>
    <p>Select a periodical to work on or <a href='#/classify' data-group='all'>choose pages from random periodicals</a>.</p>
    <ul>
      #{(for group in context.groups
        "<li><a href='#/classify' role='button' data-group='#{group.id}'>
                <img src='#{descriptions[group.name]?.image}' alt='#{descriptions[group.name]?.alt}'>
                <h3>#{group.metadata.title}</h3>
                <p>#{descriptions[group.name]?.description}</p>
              </a></li>"
      ).join '\n'}
    </ul>
  "
  
  groups: []
  
  constructor: ->
    super
    
    classify_page = null
    @listenTo Api, 'ready', (e) =>
      Group.fetch()
      currentProject = require 'zooniverse-readymade/current-project'
      classify_page = currentProject.classifyPages[0]
    
    @listenTo Group, 'fetch', (e, @groups) =>
      @el.html @template @
      @el.on 'click', 'a[data-group]', ->
        group_id = @.getAttribute 'data-group'
        if group_id == 'all'
          group_id = true
          localStorage.removeItem 'active-group'
        else 
          localStorage.setItem 'active-group', group_id
        classify_page.Subject.group = group_id
        classify_page.Subject.destroyAll()
        classify_page.Subject.next()
        
  
  listenTo: (thing, eventName, handler) ->
    addEvent = if 'on' of thing then 'on' else 'addEventListener'
    removeEvent = if 'off' of thing then 'off' else 'removeEventListener'

    thing[addEvent] eventName, handler

    @on 'destroy', ->
      thing[removeEvent] eventName, handler

module.exports = GroupsPage