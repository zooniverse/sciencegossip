LEFT_CURSOR = 37
RIGHT_CURSOR = 39
SPACE = 32

class TabControl
  
  constructor: (@tab, @panel, active = false)->
    
    @tab.setAttribute 'role', 'tab'
    @tab.setAttribute 'aria-controls', @panel.id
    @panel.setAttribute 'role', 'tabPanel'
    @panel.setAttribute 'aria-labelledby', @tab.id
  
    @tab.setAttribute 'aria-selected', active
    @panel.setAttribute 'aria-selected', active
    @panel.setAttribute 'aria-hidden', !active
  
  activate: =>
    @panel.setAttribute 'aria-selected', 'true'
    @panel.setAttribute 'aria-hidden', 'false'
    @tab.setAttribute 'aria-selected', 'true'
    
  deactivate: =>
    @panel.setAttribute 'aria-selected', 'false'
    @panel.setAttribute 'aria-hidden', 'true'
    @tab.setAttribute 'aria-selected', 'false'
  
  destroy: =>
    
    @tab.removeAttribute 'role'
    @tab.removeAttribute 'aria-controls'
    @panel.removeAttribute 'role'
    @panel.removeAttribute 'aria-labelledby'
  
    @tab.removeAttribute 'aria-selected'
    @panel.removeAttribute 'aria-selected'
    @panel.removeAttribute 'aria-hidden'
    

class TabSet
  
  tabcontrols: []
  active_index: 0
  focus_index: 0
  
  constructor: (@tabcontrols = [])->
  
  add: (tab, panel, active = false) =>
    tab = tab[0] if tab[0]?
    panel = panel[0] if panel[0]?
    tab_control = new TabControl tab, panel, active
    @tabcontrols.push tab_control
    tab.addEventListener 'click', @handleClick
    tab.addEventListener 'keydown', @handleKeydown
    tab.addEventListener 'focus', @handleFocus
      
    tab_control
  
  handleClick: (e) =>
    @activate e.currentTarget
  
  handleKeydown: (e) =>
    
    if e.which == LEFT_CURSOR
      new_index = Math.max 0, @focus_index - 1
    
    if e.which == RIGHT_CURSOR
      new_index = Math.min @tabcontrols.length - 1, @focus_index + 1
    
    if e.which == SPACE
      e.currentTarget.click()
    
    @moveFocus new_index if new_index?
  
  handleFocus: (e) =>
    @focus_index = i for tabcontrol, i in @tabcontrols when tabcontrol.tab == e.currentTarget
    
  moveFocus: (new_index) =>
    @tabcontrols[new_index].tab.focus()
    @focus_index = new_index
    
  activate: (el) =>
    el = el[0] if el[0]?
    return if el.getAttribute('aria-selected') is 'true'
    for tab_control, i in @tabcontrols
      if tab_control.tab.id is el.id || tab_control.panel.id is el.id
        tab_control.activate()
        @active_index = i
      else
        tab_control.deactivate()
  
  goTo: (index) =>
    index %%= @tabcontrols.length
    @activate @tabcontrols[index].tab if @tabcontrols[index]
  
  destroy: =>
    for tabcontrol in @tabcontrols
      tabcontrol.tab.removeEventListener 'click', @handleClick
      tabcontrol.destroy()
    
    
module.exports = TabSet