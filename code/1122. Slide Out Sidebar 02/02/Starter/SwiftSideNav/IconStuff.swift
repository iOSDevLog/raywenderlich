/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

enum IconRating {
  case unrated
  case ugly
  case ok
  case nice
  case awesome
}

struct Icon {
  let title: String
  let subtitle: String
  let image: UIImage!
  var rating: IconRating
}

struct IconSet {
  let name: String
  let icons: [Icon]
}

class IconHelper {
  class func allIconSets() -> [IconSet] {
    return [ summerIconSet(), winterIconSet() ]
  }

  class func winterIconSet() -> IconSet {
    return IconSet(name: "Winter Icons", icons: [
      Icon(title: "Ornament", subtitle:"Hang on your tree", image: UIImage(named: "icons_winter_01"), rating: .unrated),
      Icon(title: "Candy Cane", subtitle:"Mmm, tasty", image: UIImage(named: "icons_winter_02.png"), rating: .unrated),
      Icon(title: "Snowman", subtitle:"A very happy soul", image: UIImage(named: "icons_winter_03.png"), rating: .unrated),
      Icon(title: "Penguin", subtitle:"Mario's friend", image: UIImage(named: "icons_winter_04.png"), rating: .unrated),
      Icon(title: "Santa Hat", subtitle:"Found it in the chimney", image: UIImage(named: "icons_winter_05.png"), rating: .unrated),
      Icon(title: "Gift", subtitle:"Under the tree", image: UIImage(named: "icons_winter_06.png"), rating: .unrated),
      Icon(title: "Gingerbread Man", subtitle:"Lives in a yummy house", image: UIImage(named: "icons_winter_07.png"), rating: .unrated),
      Icon(title: "Christmas Tree", subtitle:"Smells good", image: UIImage(named: "icons_winter_08.png"), rating: .unrated),
      Icon(title: "Snowflake", subtitle:"Unique and beautiful", image: UIImage(named: "icons_winter_09.png"), rating: .unrated),
      Icon(title: "Reindeer", subtitle:"A very shiny nose", image: UIImage(named: "icons_winter_10.png"), rating: .unrated),
    ])
  }

  class func summerIconSet() -> IconSet {
    return IconSet(name: "Summer Icons", icons: [
      Icon(title: "Sun", subtitle: "A beautiful day", image: UIImage(named: "summericons_01"), rating: .unrated),
      Icon(title: "Beach Ball", subtitle: "Fun in the sand", image: UIImage(named: "summericons_02"), rating: .unrated),
      Icon(title: "Swim Trunks", subtitle: "Time to go swimming", image: UIImage(named: "summericons_03"), rating: .unrated),
      Icon(title: "Bikini", subtitle: "Fun in the sun", image: UIImage(named: "summericons_04"), rating: .unrated),
      Icon(title: "Sand Bucket and Shovel", subtitle: "Castles in the sand", image: UIImage(named: "summericons_05"), rating: .unrated),
      Icon(title: "Surfboard", subtitle: "Catch a wave", image: UIImage(named: "summericons_06"), rating: .unrated),
      Icon(title: "Strawberry Daiquiri", subtitle: "Great way to relax", image: UIImage(named: "summericons_07"), rating: .unrated),
      Icon(title: "Sunglasses", subtitle: "I wear mine at night", image: UIImage(named: "summericons_08"), rating: .unrated),
      Icon(title: "Flip Flops", subtitle: "Sand between your toes", image: UIImage(named: "summericons_09"), rating: .unrated),
      Icon(title: "Ice Cream", subtitle: "A summer treat", image: UIImage(named: "summericons_10"), rating: .unrated),
    ])
  }
}
