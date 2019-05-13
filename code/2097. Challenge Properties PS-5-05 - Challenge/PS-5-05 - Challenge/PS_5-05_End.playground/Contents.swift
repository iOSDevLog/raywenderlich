/*:
Copyright (c) 2018 Razeware LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
distribute, sublicense, create a derivative work, and/or sell copies of the
Software in any work that is designed, intended, or marketed for pedagogical or
instructional purposes related to programming, coding, application development,
or information technology.  Permission for such use, copying, modification,
merger, publication, distribution, sublicensing, creation of derivative works,
or sale is expressly withheld.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

---
 
# Challenge Time! 😃
Create a struct named `Temperature` with properties for degrees in both Celsius and Fahrenheit, as `Double`s.
* _Hint 1_: One property must be stored, but the other can be computed. They should always stay in sync.
* _Hint 2_: To convert from Fahrenheit to Celsius, subtract 32, then divide by 1.8.
*/
struct Temperature {
  var degreesF: Double {
    didSet {
      if degreesF > 100 {
        print("It's \(degreesF) degrees Fahrenheit! I had fun coding in Swift with you before I melted.")
      }
    }
  }
  
  var degreesC: Double {
    get { return (degreesF - 32) / 1.8 }
    set { degreesF = newValue * 1.8 + 32 }
  }
}

var temperature = Temperature(degreesF: 32)
temperature.degreesC
//: Modify the Fahrenheit property to print out a warning message if it is set to above 100 degrees.
temperature.degreesC = 75
