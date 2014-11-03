$ = window.jQuery
TabSet = require '../tab-control'

class MiniTutorial
  CLOSE_EVENT: 'mini-tutorial:close'

  steps = []

  closeLabel: '&times;'
  previousLabel: 'Previous'
  nextLabel: 'Next'
  finishLabel: 'Finished'

  index: 0

  template: -> "
    <button type='button' name='readymade-mini-tutorial-close' aria-label='Close'>#{@closeLabel}</button>

    <div class='readymade-mini-tutorial-contents'>
      #{("
        <div>
          <div class='readymade-mini-tutorial-images'><img src='#{step.image}' alt='#{step.alt}' class='readymade-mini-tutorial-image' /></div>
          <div class='readymade-mini-tutorial-content'>#{step.content}</div>
        </div>
      " for step in @steps).join '\n'}
    </div>

    <div class='readymade-mini-tutorial-actions'>
      <button type='button' name='readymade-mini-tutorial-previous'>
        <span class='readymade-mini-tutorial-button-label'>#{@previousLabel}</span>
      </button>

      <button type='button' name='readymade-mini-tutorial-next'>
        <span class='readymade-mini-tutorial-button-label'>#{@nextLabel}</span>
      </button>

      <button type='button' name='readymade-mini-tutorial-finish'>
        <span class='readymade-mini-tutorial-button-label'>#{@finishLabel}</span>
      </button>
    </div>

    <div class='readymade-mini-tutorial-steppers'>
      #{("
        <button id='tut-tab-#{i}' type='button' name='readymade-mini-tutorial-stepper'>
          <span class='readymade-mini-tutorial-button-label'>#{i + 1}</span>
        </button>
      " for step, i in @steps).join '\n'}
    </div>
  "

  constructor: (options) ->
    for key, value of options
      @[key] = value

    @el ?= document.createElement 'div'
    @el.classList.add 'readymade-mini-tutorial-underlay'
    @el.setAttribute 'aria-hidden', true

    @close()

    @dialog ?= document.createElement 'div'
    @dialog.classList.add 'readymade-mini-tutorial-dialog'
    @dialog.setAttribute 'role', 'dialog'

    @dialog.insertAdjacentHTML 'afterBegin', @template()

    @previousButton = @dialog.querySelector '[name="readymade-mini-tutorial-previous"]'
    @nextButton = @dialog.querySelector '[name="readymade-mini-tutorial-next"]'
    @finishButton = @dialog.querySelector '[name="readymade-mini-tutorial-finish"]'
    
    $el = $ @el

    $el.on 'click', '[name="readymade-mini-tutorial-close"]', @close.bind this

    $el.on 'click', '[name="readymade-mini-tutorial-previous"]', @previous.bind this
    $el.on 'click', '[name="readymade-mini-tutorial-next"]', @next.bind this
    $el.on 'click', '[name="readymade-mini-tutorial-finish"]', @close.bind this
    $el.on 'focus', 'button[role=tab]', @handleTabClick

    step_controls = new TabSet
    for slide, i in @dialog.querySelectorAll('.readymade-mini-tutorial-contents > div')
      tab = @dialog.querySelector "#tut-tab-#{i}"
      step_controls.add tab, slide, i is 0
      
      $(tab).on 'click', i, (e)=>
        @goTo e.data
      
    
    last_step = step_controls.tabcontrols[ step_controls.tabcontrols.length - 1 ]
    close = @dialog.querySelector '[name="readymade-mini-tutorial-close"]'
    # tab to close button from last stepper button
    $el.on 'keydown', '[name="readymade-mini-tutorial-stepper"]:last', (e) =>
      if e.which == 9 && !e.shiftKey
        e.preventDefault()
        close.focus()
    
    # shift-tab to last stepper button from close button
    $el.on 'keydown', '[name="readymade-mini-tutorial-close"]', (e) =>
      if e.which == 9 && e.shiftKey
        e.preventDefault()
        last_step.tab.focus()
    
    @step_controls = step_controls

    @el.appendChild @dialog

    @goTo @index

  goTo: (@index) ->
    @index %%= @steps.length
    
    @step_controls.goTo @index

    @previousButton.disabled = @index is 0

    lastStep = @steps.length - 1
    @nextButton.disabled = @index is lastStep
    @finishButton.disabled = @index isnt lastStep
    
    @active_button = if @index is lastStep then @finishButton else @nextButton

    return

  handleTabClick: (e) =>
    index = e.target.id.replace 'tut-tab-', ''
    @goTo index
    
  previous: ->
    @goTo @index - 1
    @active_button?.focus()
    return

  next: ->
    @goTo @index + 1
    @active_button?.focus()
    return

  open: ->
    @el.setAttribute 'data-transitioning', true
    @current_focus = document.activeElement ? document.body
    setTimeout =>
      @el.setAttribute 'aria-hidden', false
      @el.removeAttribute 'data-transitioning'
      @active_button?.focus()
    , 250
    return

  close: ->
    @el.setAttribute 'data-transitioning', true
    @el.setAttribute 'aria-hidden', true
    setTimeout @el.removeAttribute.bind(@el, 'data-transitioning'), 250
    $(@el).trigger @CLOSE_EVENT
    @current_focus?.focus()
    return

module.exports = MiniTutorial
