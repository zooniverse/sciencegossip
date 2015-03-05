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
                  <p>e.g. <b>bird; landscape; crab; forest; man; woman; apple; pottery; cemetery; skull; fossil; microscopic view; meteor; meteorological observations</b>.</p> 
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
  },{
    label: 'Latin terms'
    content: '''
                 <dl>
                 <dt>Delineavit, del, delin, delt</dt> 
                 <dd>An abbreviation of the Latin delineavit, ‘he/she drew [it]’, sometimes occurs in the lower margin or corner of a print, usually an engraving or an etching, to indicate a particular artist on whose original drawing the print is based. The name precedes it, usually found on the bottom left side of the plate</dd>
                 <dt>Dir.: direxit</dt> 
                 <dd>persons supervising the engraving. The name precedes it.</dd> 
                 <dt>sc. (or sculp., sculpsit., sculpt., Inc., incidit)</dt> 
                 <dd>[Latin, ‘he/she carved [it]’] sometimes appears on a piece of sculpture after the sculptor's name to indicate it is an original direct carving rather than a cast or copy. It can also occur in the margin of a print after an artist's name to indicate he was the engraver or etcher (in a reproductive print the original design may have been by someone else). In a printmaking context it carries the same meaning as inc., an abbreviation of the Latin incidit, ‘he/she cut [it]. It follows the engraver’s name. Usually found on the bottom right-hand side of a plate.</dd>
                 <dt>Exc.: excudit</dt> 
                 <dd>engraved by.</dd> 
                 <dt>Fec.</dt> 
                 <dd>He made it</dd>
                 <dt>Imp.: impressit</dt> 
                 <dd>means printed by, often found below the title of the print.</dd> 
                 <dt>Lith.</dt> 
                 <dd>Lithographer, whose name follows it.</dd>
                 <dt>Pinx, ping, pinxit, del. Pinx</dt> 
                 <dd>[Latin, an abbreviation of pinxit, ‘he/she painted [it]’] was often inscribed after the artist's signature in a painting to indicate he was the author. It was also found in the lower corners of the margins of prints where it had the same meaning as inv., or invenit, ‘he/she designed [it]’. del. Pinx.: sometimes denotes the hand-colorist.</dd>
                 </dl>
                 '''
    figures: []
  }]
