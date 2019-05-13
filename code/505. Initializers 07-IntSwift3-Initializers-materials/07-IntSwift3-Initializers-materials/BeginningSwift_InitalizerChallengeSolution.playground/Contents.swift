import UIKit

/*:
 #### Intermediate Swift Video Tutorial Series - raywenderlich.com
 #### Video 7: Initializers
 
 **Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
 
 */

//: Create a story class that contains two string properties: name and a writer. Provide an a init() that sets both properties
class Story {
  var name: String
  var writer: String
  
  init(name: String, writer: String) {
    self.name = name
    self.writer = writer
  }
}

//: Create a new Movie class that is a sublcass of the story class. Give it a new string propery called directory. Create a init that sets the director, name, and writer properties.
class Movie: Story {
  var director: String
  
  init(director: String, name: String, writer: String) {
    self.director = director
    super.init(name: name, writer: writer)
  }

//: Create a convenience init that takes just a director's name. Set the name to "Unknown Title" and the writer to "Unknown writer"
  convenience init(director: String) {
    self.init(director: director, name: "Unknown Title", writer: "Unknown writer")
  }
  
}