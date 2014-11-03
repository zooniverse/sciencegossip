Rectangle = require './drawing-tools/rectangle'

module.exports =
  id: 'bhl'
  background: ''

  producer: 'Biodiversity Heritage Library & Zooniverse'
  title: 'Illustrated Life'
  summary: 'Help catalogue scientific illustrations'
  description: 'Short description'

  pages: [{
    'About': '''
      <h2>All about the project</h2>
      <p>This is where we\'ll go into detail.</p>
      <hr />
      <h3>Lorem ipsum dolor sir amet.</h3>
      <p>Break it into sections, add pictures, whatever.</p>
    '''
  }]

  tasks:
    illustration:
      type: 'drawing'
      question: 'Mark an illustration.'
      choices: [{
        type: Rectangle
        label: 'Mark an illustration'
        color: '#ffffff'
      }]
      next: 'type'
    type:
      type: 'radio'
      question: 'What type of illustraton is it?'
      key: 'type'
      choices:[{
        value: 'choice1'
        label: 'Choice 1'
      }, {
        value: 'choice2'
        label: 'Choice 2'
      }]

  firstTask: 'illustration'

