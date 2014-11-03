$ = window.jQuery
TabSet = require '../tab-control'

class FieldGuide
  examples: null

  template: (examples) -> "
    <div class='readymade-field-guide-tabs'>
      #{("
        <button id='fg-tab-#{i}' name='readymade-field-guide-tab'>#{page.label}</button>
      " for page, i in examples).join '\n'}
    </div>

    <div class='readymade-field-guide-pages'>
      #{("
        <div class='readymade-field-guide-page'>
          <div class='readymade-field-guide-content'>#{page.content ? ''}</div>
          <div class='readymade-field-guide-examples'>
            #{("
              <div class='readymade-field-guide-example'>
                <img src='#{figure.image}' alt='#{figure.alt}' class='readymade-field-guide-image' />
                <div class='readymade-field-guide-caption'>#{figure.label}</div>
              </div>
            " for figure in page.figures).join '\n'}
          </div>
        </div>
      " for page, i in examples).join '\n'}
    </div>
  "

  constructor: (config) ->
    for key, value of config
      @[key] = value

    @examples ?= []

    @el ?= document.createElement 'div'
    @el = $(@el)
    @el.addClass 'readymade-field-guide'

    renderedHTML = @template @examples
    @el.append renderedHTML
    
    @tabs = new TabSet
    
    @el.find('.readymade-field-guide-page').each (i, panel) =>
      tab = @el.find "#fg-tab-#{i}"
      @tabs.add tab, panel, i is 0

    @el.on 'focus', 'button[role=tab]', @handleTabClick

    @goTo 0

  handleTabClick: (e) =>
    index = e.target.id.replace 'fg-tab-', ''
    @goTo index

  goTo: (index) =>
    @tabs.goTo parseInt index
      

  destroy: ->
    @el.off 'focus', 'button[role=tab]', @handleTabClick
    @tabs.destroy()

module.exports = FieldGuide