Rectangle = require './drawing-tools/rectangle'
Pinpoint = require './drawing-tools/pinpoint'
Details = require './tasks/details'

module.exports =
  id: 'bhl'
  background: 'background.jpg'

  producer: 'Missouri Botanical Garden & Zooniverse'
  title: 'Illustrated Life'
  summary: 'Help catalogue scientific illustrations'
  description: '''
                 Illustrations are an essential part of visualising and understanding the natural world. We need your help to identify and classify the range of illustrations printed in books and periodicals over the last 200 years.
                 '''
  

  pages: [{
    'About': '''
      <h2>About ‘Illustrated Life’</h2>

      <p>The publication of books and periodicals are key locations for visualizing knowledge about the natural world. The Biodiversity heritage library has digitized and catalogued millions of pages of printed text between x and x related to the investigation of the natural world. Illustrations are a large part of these printed pages, and we need your to help identify, classify and correlate them. The data you create by tagging illustrations and adding artist and engraver information will have a direct impact on the research of historians who are trying to figure out why, how often, and who made images depicting a whole range of natural sciences in the Victorian period.</p> 

      <h2>BHL and Constructing Scientific Communities</h2>

      <p><cite>Illustrated Life</cite> is a project collaboration between the Biodiversity Heritage Library (BHL) operated through the Missouri Botanical Garden and an Arts and Humanities Research Council project Constructing Scientific Communities: Citizen Science in the 19th and 21st Centuries (conscicom). The ConSciCom project is investigating the role of the non-professional in the making and communication of science in both the Victorian period and today. Historians at the Universities of Leicester and Oxford are investigating the particular roles of the periodical press in the 19th century as a place for an amateur or non-professional individual to participate in scientific research. Periodicals and books of the Victorian era were heavily illustrated, but little is know about who made the illustrations and how they ended up in print. One of the fundamental aims of the ConSciCom project, through your help on Illustrated Life, is to better understand exactly why and how images were used to produce knowledge about the natural world within printed media. Unlike the 20th and 21st centuries, the barriers to participating in science in the 19th century were not as straightforward as they are now. Better understanding the range of individuals who made science through their images will help us ascertain what constituted a 19th century scientist.. The ultimate goal of the project is to better understand the roots of citizen science – and this is the first Zooniverse project where citizen scientists are both the researchers and the subject of the research. In this way, how you – as a citizen scientist –participate in this project has a direct impact on how we can come to understand historical and modern notions of what it means to do science.</p>
      
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

