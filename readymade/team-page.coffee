teamPageTemplate = require './templates/team-page'

content = 
  organizations: [{
    image: '//placehold.it/100.png?text=Example'
    name: 'Biodiversity Heritage Library'
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

module.exports = teamPageTemplate content