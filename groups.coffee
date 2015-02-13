Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
Group = require 'zooniverse/models/project-group'

class GroupsPage extends Controller
  
  template: (context) -> "
    <h2>Periodicals</h2>
    #{(for group in context.groups
      "<p>#{group.metadata.title}</p>"
    ).join '\n'}
  "
  
  groups: []
  
  constructor: ->
    super
    
    @listenTo Api, 'ready', (e) =>
      Group.fetch()
    
    @listenTo Group, 'fetch', (e, @groups) =>
      @el.html @template @
  
  listenTo: (thing, eventName, handler) ->
    addEvent = if 'on' of thing then 'on' else 'addEventListener'
    removeEvent = if 'off' of thing then 'off' else 'removeEventListener'

    thing[addEvent] eventName, handler

    @on 'destroy', ->
      thing[removeEvent] eventName, handler

module.exports = GroupsPage