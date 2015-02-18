Rectangle = require './drawing-tools/rectangle'
Pinpoint = require './drawing-tools/pinpoint'
Details = require './tasks/details'
GroupsPage = require './groups'

group_page = new GroupsPage
teampage = require './templates/team-page'
subjectGroup = localStorage.getItem 'active-group'

team =
  organizations: 
    title: "Partners"
    members: [{
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

  missouri: 
    title: "Missouri Botanical Garden"
    members: [{
      image: '//placehold.it/100.png?text=Example'
      name: 'Trish Rose-Sandler'
      location: 'St Louis, MO, USA'
      description: 'Missouri Botanical Garden'
    },{
      image: '//placehold.it/100.png?text=Example'
      name: 'William Ulate'
      location: 'St Louis, MO, USA'
      description: 'Missouri Botanical Garden'
    },{
      image: '//placehold.it/100.png?text=Example'
      name: 'Mike Lichtenberg'
      location: 'St Louis, MO, USA'
      description: 'Missouri Botanical Garden'
    }]
  
  conscicom: 
    title: "Constructing Scientific Communities"
    members: [{
      image: '//placehold.it/100.png?text=Example'
      name: 'Sally Shuttleworth'
      location: 'Oxford, UK'
      description: 'Principle Investigator'
    },{
      image: '//placehold.it/100.png?text=Example'
      name: 'Chris Lintott'
      location: 'Oxford, UK'
      description: 'Co-investigator'
    },{
      image: '//placehold.it/100.png?text=Example'
      name: 'Geoffrey Belknap'
      location: 'Leicester, UK'
      description: 'Postdoctoral researcher, Constructing Scientific Communities'
      url: 'http://twitter.com/geoffreybelknap'
    }]

  developers: 
    title: "Zooniverse"
    members: [{
      image: '//placehold.it/100.png?text=Example'
      name: 'Jim O\'Donnell'
      location: 'Oxford, UK'
      description: 'Web developer'
      url: 'http://twitter.com/pekingspring'
    },{
      image: '//placehold.it/100.png?text=Example'
      name: 'Victoria Van Hyning'
      location: 'Oxford, UK'
      description: 'Humanities project lead'
    },{
      image: '//placehold.it/100.png?text=Example'
      name: 'Adam McMaster'
      location: 'Oxford, UK'
      description: 'Web infrastructure'
    }]

module.exports =
  id: 'illustratedlife'
  background: 'background.jpg'
  subjectGroup: subjectGroup ? true
  groups: group_page.groups

  title: 'Science Gossip'
  summary: 'Uncover the history of citizen science'
  description: '''
                 In the Victorian period, just like today, scientists and members of the public worked together to further scientific discovery. Before computers and cameras they had to draw what they saw. Their drawings are locked away in the pages of Victorian periodicals, such as <cite>Science Gossip</cite>, <cite>Recreative Science</cite> and <cite>The Intellectual Observer</cite>. Help us to classify their drawings and map the origins of citizen science.
                 '''
  

  pages: [{
      'Periodicals': group_page
    },{
    'About': [
      {
        'Science Gossip': '''
      <h2>About ‘Science Gossip’</h2>

      <p>The publication of books and periodicals are key locations for visualizing knowledge about the natural world. The Biodiversity Heritage Library has digitized and catalogued millions of pages of printed text between the 1400's and today related to the investigation of the natural world. Illustrations are a large part of these printed pages, and we need your to help identify, classify and correlate them. The data you create by tagging illustrations and adding artist and engraver information will have a direct impact on the research of historians who are trying to figure out why, how often, and who made images depicting a whole range of natural sciences in the Victorian period.</p> 

      <h2>BHL and Constructing Scientific Communities</h2>

      <p><cite>‘Science Gossip’</cite> is born from a collaboration between an Arts and Humanities Research Council project in the UK, called <cite>‘Constructing Scientific Communities: Citizen Science in the 19th and 21st Centuries’</cite> (<a href="http://conscicom.org">ConSciCom</a>) and the <cite>Missouri Botanical Garden</cite> who are providing content from the <a href="http://blog.biodiversitylibrary.org/">Biodiversity Heritage Library</a>.</p> 

      <p>The ConSciCom project is investigating the role of naturalists and ‘amature’ science enthusiasts in the making and communication of science in both the Victorian period and today. Historians at the Universities of Leicester and Oxford are investigating the particular roles of the periodical press in the nineteenth century as an arena in which citizen scientists of the past participated in scientific research. Periodicals and books of the Victorian era were heavily illustrated, but little is know about who made the illustrations and how they ended up in print. The data you create by tagging illustrations and adding artist and engraver information will have a direct impact on the research of historians who are trying to figure out why, how often, and who made images depicting a whole range of natural sciences in the Victorian period.</p>

      <p>Better understanding the range of individuals who made science through their images will help us ascertain what constituted a nineteenth century scientist and citizen scientist. This is the first Zooniverse project where citizen scientists are both the researchers and the subject of the research. Citizen scientists of today can have a direct impact on how we understand historical and modern notions of what it means to do science.</p>
      
    '''
      },{
        'The Team': teampage team
      }]
  }]
  
  externalLinks:
    Blog: 'http://blog.biodiversitylibrary.org/'
    '<i class="fa fa-twitter fa-lg">Twitter</i>': 'http://twitter.com/the_zooniverse'
    Feedback: 'https://docs.google.com/forms/d/1Ce3OeHM_PlCOIYQCLeBvrVSoxB7Mwku7g-GAD5_-xUc/viewform?c=0&w=1'

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
        label: 'drawing/painting/diagram'
        value: 'drawing'
        color: '#006666'
        checked: true
      },{
        type: Rectangle
        label: 'chart/table'
        value: 'chart'
        color: '#666666'
      },{
        type: Rectangle
        label: 'photograph'
        value: 'photograph'
        color: '#660066'
      },{
        type: Rectangle
        label: 'map'
        value: 'map'
        color: '#666600'
      }]
      next: 'parts'
    details:
      type: 'details'
      question: 'Add information about the illustration.'
      choices: [{
        type: 'textarea'
        key: 'keywords'
        label: 'Keywords'
        value: ''
        placeholder: 'bird; landscape; crab; forest; man; woman; apple; pottery; cemetery; skull; fossil; microscopic view; meteor, meteorological observations'
      }]
      next: 'review'
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
              'artist'
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

