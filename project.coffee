Rectangle = require './drawing-tools/rectangle'
Pinpoint = require './drawing-tools/pinpoint'
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
    illustrations:
      type: 'radio'
      question: 'Are there any illustrations on this page?'
      choices: [{
        label: 'Yes'
        value: 'yes'
        next: 'illustration'
      },{
        label: 'No'
        value: 'no'
      }]
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
      next: 'parts'
    parts: 
      type: 'drawing'
      question: 'Mark any parts of the illustration.'
      choices: [{
        type: Pinpoint
        label: 'Caption'
        color: '#333'
        details:[{
          type: 'text'
          key: 'parts'
          choices:[{
            value: 'text'
            key: 'caption'
            label: 'Caption'
          }]
        }]
      }]
      next: 'details'
    review:
      type: 'button'
      question: "Use the 'Back' button to review your work, or click 'Finished' to move on to the next page."
      choices: [{
        label: 'Finished'
        next: null
      }]

  firstTask: 'illustrations'

