Rectangle = require './drawing-tools/rectangle'
Details = require './tasks/details'

module.exports =
  id: 'bhl'
  background: 'background.jpg'

  producer: 'Missouri Botanical Garden & Zooniverse'
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
      question: 'Draw rectangles around the illustrations on this page.'
      choices: [{
        type: Rectangle
        label: 'Mark the illustrations'
        color: '#333333'
      }]
      next: 'details'
    details:
      type: 'details'
      question: 'Add information about the illustrations.'
      choices: [{
        label: 'Type'
        value: ''
      },{
        label: 'Artist'
        value: ''
      }]
      next: 'details'

  firstTask: 'illustration'

