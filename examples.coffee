module.exports = [{
    label: 'Type'
    content: '''
                 We're only looking for certain types of illustrations.
                 '''
    
    figures: [{
      label: 'Drawing/painting/diagram'
      image: "examples/drawing.jpg"
      alt: "Examples of pages with a drawing, a painting and a diagram."
    },{
      label: 'Chart/table'
      image: "examples/chart.jpg"
      alt: "3D chart showing sexual dimosrphism in bumble bees"
    },{
      label: "Photograph"
      image: "examples/photograph.jpg"
      alt: "Black and white photograph titled: A Rocky Mountain Carryall"
    },{
      label: "Map"
      image: "examples/map.jpg"
      alt: "Geological map of an area of the Hudson River"
    }]
  },{
    label: "Keywords"
    content: '''
                  <p>Add general keywords or phrases about the primary species or subjects depicted in the  illustration Separate terms by semi-colons e.g. <b>bird; landscape; crab; forest; man; woman; apple; pottery; cemetery; skull; fossil; microscopic view; meteor, meteorological observations</b>.</p> 
                 <p>If it is a chart or table, indicate the topic that the data represents e.g. <b>Montana Wheat; Trout length; Livestock inventory; mirror</b></p>
                  <p>If is it a map, add any current or historic geographic locations indicated by the map or caption e.g. <b>Three Lakes; Southern China; Canada; Uriconium; Yorkshire</b></p>
                 '''
    figures: []
  },{
    label: "Tagging"
    content: '''
                 <p>Click on species, inscriptions and contributors in the illustration to record each one.</p>
                 '''
    figures: [{
      image: "examples/species.jpg"
      alt: "Painting of a crested hornbill"
      label: '''
                   <p>Species</p>
                   <p>Common Name=Crested Hornbill
                   <br>
                   Scientific Name=Bycanistes cristatus</p>
                   '''
      
      },{
        image: "examples/inscriptions.jpg"
        alt: "Handwritten inscription reading: Near Alata Sidaillo, Dec 15- 1926,Bycanistes cristatus"
        label: '''
                       <p>Inscriptions</p>
                       <ul>
                         <li>Near Alata Sidaillo</li>
                         <li>Dec 15- 1926-</li>
                         <li>Bycanistes cristatus</li>
                      </ul>
                       '''
        
      },{
        image: "examples/contributors.jpg"
        alt: "Detail of a painting showing inscriptions for artist and publisher"
        alt: "Contributors example"
        label: '''
                       <p>Contributors</p>
                       
                      <p>Name=Vincent Brooks Day & Son   Role=Lithographer</p>
                       '''
        
      }]
  }]
