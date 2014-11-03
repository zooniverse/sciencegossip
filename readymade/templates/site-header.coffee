module.exports = (context) ->
  template = ->
    "
      <div class='readymade-creator'>
        <a href='#/'>
          <div class='readymade-project-producer'>#{@producer}</div>
          <h1 class='readymade-project-title'>#{@title}</h1>
        </a>
      </div>

      <ul class='readymade-site-links' role='navigation'></ul>
    "
  template.call context
