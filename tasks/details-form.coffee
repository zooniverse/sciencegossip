# This is not a proper eco template at the moment because it takes arguments.

typeMap =
  'details': 'text'

module.exports = (choice, i) -> "
  <label class=''>
    <span class='readymade-choice-label'>#{choice.label ? choice.value ? i}</span>
    <input type='#{typeMap[@constructor?.type] ? typeMap[@type] ? @constructor?.type ? @type}'
      name='#{@key}'
      value='#{choice.value}'
      data-choice-index='#{i}'
    />
  </label>
"