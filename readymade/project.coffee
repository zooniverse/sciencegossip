dash = (string) ->
  string.toLowerCase().replace /\W+/g, '-'
Project = require 'zooniverse-readymade/lib/project'

Project.prototype.addPage = (href, label, content) ->
    @stack.changeDisplay = false
    
    frag_id = href.split('/').pop()
    frag_id = 'home' if frag_id == ''
    
    if content instanceof StackOfPages
      href += "/*"
    
    @stack.add href, content
    page = @stack.el.children[@stack.el.children.length - 1]
    page.id = frag_id
    
    link = @header.addNavLink '#' + frag_id, label
    link.addEventListener 'click', (e) ->
      window.location.hash = href
      e.preventDefault()

    page
    
Project.prototype.navLink = (id, hash, title) ->
  link = document.createElement 'a'
  link.href = '#' + id
  link.textContent  = title
  link.addEventListener 'click', (e) =>
    e.preventDefault()
    window.location.hash = hash
  
  link

Project.prototype.makeStackFromPages = (pages, currentPath = []) ->
  mapOfHashes = {}

  nav = document.createElement 'nav'
  nav.className = 'readymade-subnav'

  for description, i in pages
    for title, content of description
      id = dash title
      currentPath.push id

      hash = ['#', currentPath...].join '/'
      mapOfHashes.default ?= hash
      
      nav.appendChild @navLink id, hash, title
      
      mapOfHashes[hash] = if content instanceof Array
        @makeStackFromPages content, currentPath
      else if typeof content is 'string'
        """
          <div id='#{id}' class='readymade-generic-page' data-readymade-page='#{dash title}'>#{content}</div>
        """
      else
        container = document.createElement 'div'
        # TODO: Add sub-navigation.
        content

      currentPath.pop()

  stack = new StackOfPages mapOfHashes
  stack.el.insertBefore nav, stack.el.firstChild
  setTimeout -> stack.onHashChange()
  stack