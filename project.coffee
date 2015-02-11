Rectangle = require './drawing-tools/rectangle'
Pinpoint = require './drawing-tools/pinpoint'
Details = require './tasks/details'
GroupsPage = require './groups'

group_page = new GroupsPage

module.exports =
  id: 'bhl'
  background: 'background.jpg'

  title: 'Science Gossip'
  summary: 'Uncover the history of citizen science'
  description: '''
                 In the Victorian period, just like today, scientists and members of the public worked together to further scientific discovery. Before computers and cameras they had to draw what they saw. Their drawings are locked away in the pages of Victorian periodicals, such as <cite>Science Gossip</cite>, <cite>Recreative Science</cite> and <cite>The Intellectual Observer</cite>. Help us to classify their drawings and map the origins of citizen science.
                 '''
  

  pages: [{
      'Periodicals': group_page
    },{
    'About': '''
      <h2>About ‘Science Gossip’</h2>

      <p>The publication of books and periodicals are key locations for visualizing knowledge about the natural world. The Biodiversity Heritage Library has digitized and catalogued millions of pages of printed text between the 1400's and today related to the investigation of the natural world. Illustrations are a large part of these printed pages, and we need your to help identify, classify and correlate them. The data you create by tagging illustrations and adding artist and engraver information will have a direct impact on the research of historians who are trying to figure out why, how often, and who made images depicting a whole range of natural sciences in the Victorian period.</p> 

      <h2>BHL and Constructing Scientific Communities</h2>

      <p><cite>Illustrated Life</cite> is a project collaboration between an Arts and Humanities Research Council project <cite>Constructing Scientific Communities: Citizen Science in the 19th and 21st Centuries</cite> (ConSciCom) and the Missouri Botanical Garden who are providing content from the Biodiversity Heritage Library. The ConSciCom project is investigating the role of the non-professional in the making and communication of science in both the Victorian period and today. Historians at the Universities of Leicester and Oxford are investigating the particular roles of the periodical press in the 19th century as a place for an amateur or non-professional individual to participate in scientific research. Periodicals and books of the Victorian era were heavily illustrated, but little is know about who made the illustrations and how they ended up in print. One of the fundamental aims of the ConSciCom project, through your help on <cite>Illustrated Life</cite>, is to better understand exactly why and how images were used to produce knowledge about the natural world within printed media. Unlike the 20th and 21st centuries, the barriers to participating in science in the 19th century were not as straightforward as they are now. Better understanding the range of individuals who made science through their images will help us ascertain what constituted a 19th century scientist.. The ultimate goal of the project is to better understand the roots of citizen science – and this is the first Zooniverse project where citizen scientists are both the researchers and the subject of the research. In this way, how you – as a citizen scientist –participate in this project has a direct impact on how we can come to understand historical and modern notions of what it means to <em>do</em> science.</p>
      
    '''
  }]
  
  organizations: [{
    image: '//placehold.it/100.png?text=Example'
    name: 'Missouri Botanical Garden'
    description: 'description'
  },{
    image: '//placehold.it/100.png?text=Example'
    name: 'Constructing Scientific Communities'
    description: 'AHRC research project'
    url: ['http://conscicom.org/', 'https://twitter.com/conscicom']
  },{
    image: '//placehold.it/100.png?text=Example'
    name: 'Zooniverse'
    description: 'Citizen Science Platform'
    url: ['https://www.zooniverse.org/', 'https://twitter.com/the_zooniverse', 'https://github.com/zooniverse']
  }]

  scientists: [{
    image: '//placehold.it/100.png?text=Example'
    name: 'Geoffrey Belknap'
    location: 'Leicester, U.K.'
    description: 'Postdoctoral researcher, Constructing Scientific Communities'
    url: 'http://twitter.com/geoffreybelknap'
  }]

  developers: [{
    image: '//placehold.it/100.png?text=Example'
    name: 'Jim O\'Donnell'
    location: 'Oxford, UK'
    description: 'Web Developer'
    url: 'http://twitter.com/pekingspring'
  }]
  
  externalLinks:
    Talk: 'http://talk.penguinwatch.org'
    Blog: 'http://blog.biodiversitylibrary.org/'
    Twitter: 'http://twitter.com/the_zooniverse'

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
      next: 'parts'
    details:
      type: 'details'
      question: 'Add information about the illustration.'
      legend: 'Illustration'
      choices: [{
        type: 'select'
        key: 'type'
        label: 'Type'
        value: 'drawing/painting/diagram'
        options: [
          'drawing/painting/diagram'
          'chart/table'
          'photograph'
          'map'
        ]
      },{
        type: 'textarea'
        key: 'keywords'
        label: 'Keywords'
        value: ''
      }]
      next: 'details'
    parts: 
      type: 'drawing'
      question: 'Mark any species, inscriptions and contributors in the illustration.'
      choices: [{
        type: Pinpoint
        label: 'Species'
        color: '#333'
        checked: true
        details:[{
          type: 'text'
          key: 'subject'
          choices:[{
            value: ''
            key: 'common'
            label: 'Common Name'
          },{
            value: ''
            key: 'scientific'
            label: 'Scientific Name'
          }]
        }]
      },{
        type: Pinpoint
        label: 'Inscription'
        color: '#333'
        details:[{
          type: 'textarea'
          key: 'inscription'
          choices:[{
            value: ''
            key: 'text'
            label: 'Text'
          }]
        }]
      },{
        type: Pinpoint
        label: 'Contributor'
        color: '#333'
        details:[{
          type: 'text'
          key: 'name'
          choices:[{
            value: ''
            key: 'name'
            label: 'Name'
          }]
        },{
          type: 'select'
          key: 'role'
          choices:[{
            value: 'illustrator'
            key: 'role'
            label: 'Role'
            options: [
              'illustrator'
              'engraver'
              'lithographer'
              'printer'
              'photographer'
              'painter'
              'other'
            ]
          }]
        }]
      }]
      next: 'details'
    review:
      type: 'radio'
      confirmButtonLabel: 'Finished'
      question: "Use the 'Back' button to review your work, or click 'Finished' to move on to the next page."
      choices: []

  firstTask: 'illustrations'
  
  examples: require './examples'

  tutorialSteps: require './tutorial-steps'

