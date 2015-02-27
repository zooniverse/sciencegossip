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
                  <p>Add general keywords or phrases about the primary species or subjects depicted in the illustration. Separate terms by semi-colons. Keywords can be based on information from a caption, when available, or simply your observation of objects in the image. You do not need to repeat information from the species, inscription and contributor task. Add keywords in your native language.</p>
                  <p>e.g. <b>bird; landscape; crab; forest; man; woman; apple; pottery; cemetery; skull; fossil; microscopic view; meteor, meteorological observations</b>.</p> 
                 <p>If it is a chart or table, indicate the topic that the data represents e.g. <b>Montana Wheat; Trout length; Livestock inventory; mirror</b>. The topic may be indicated in a caption or in the surrounding text of the page. You do not need to transcribe all the data in the table.</p>
                  <p>If is it a map, add any current or historic geographic locations indicated by the map or caption e.g. <b>Three Lakes; Southern China; Canada; Uriconium; Yorkshire</b></p>
                 '''
    figures: []
  },{
    label: "Tagging"
    content: '''
                 <p>Click on species, inscriptions and contributors in the illustration to record each one. These will often be blank for Charts/Tables and Maps i.e. you do not need to transcribe all the data in a table. If a species is not indicated in a caption you may find the species name in the text surrounding the illustration or on the pages before and after the page you are describing. To see the full book or journal click on the page (<span class="fa fa-file"></span>) link.</p>
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
