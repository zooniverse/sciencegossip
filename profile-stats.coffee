Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
Group = require 'zooniverse/models/project-group'
User = require 'zooniverse/models/user'

class ProfileStats extends Controller
  
  template: (context) -> 
    return '' unless context.user
    "
      <h2>Pages Classified</h2>
      <ul>
        #{(for key, group of context.user.project.groups
          "<li><span class='title'>#{group.title}</span> <span class='count'>#{group.classification_count}</span></li>"
        ).join '\n'}
      </ul>
    "
  
  groups: []
  
  user: null
  
  constructor: ->
    super
    
    classify_page = null
    @listenTo Api, 'ready', (e) =>
      currentProject = require 'zooniverse-readymade/current-project'
    
    @listenTo Group, 'fetch', (e, @groups) =>
      @setGroupTitles()
      @el.html @template @ if @user
    
    @listenTo User, 'change', (e, @user) =>
      @setGroupTitles()
      @el.html @template @
  
  setGroupTitles: ->
    return unless @user && @groups
    for key, group of @user.project.groups
      group.title = g.metadata.title for g in @groups when g.id is key
        
  
  listenTo: (thing, eventName, handler) ->
    addEvent = if 'on' of thing then 'on' else 'addEventListener'
    removeEvent = if 'off' of thing then 'off' else 'removeEventListener'

    thing[addEvent] eventName, handler

    @on 'destroy', ->
      thing[removeEvent] eventName, handler

module.exports = ProfileStats