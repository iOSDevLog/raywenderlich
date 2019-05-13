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
 Here are the `Student` and `Classroom` types from the last challenge on **structures**. You'll find instructions below on how you'll use them in this challenge.
*/
struct Student {
  let firstName: String
  let lastName: String
  var grade: Int
}

struct Classroom {
  let className: String
  var students: [Student]

  var highestGrade: Int? {
    return students.map { $0.grade } .max()
  }
}
/*:
 1. Alter `Classroom` so that this `classroom` can be a constant, declared with `let`.
 */
var classroom = Classroom(
  className: "Grade Curving Basics",
  students: [
    Student(firstName: "Sally", lastName: "Seventie", grade: 70),
    Student(firstName: "Theo", lastName: "Therty", grade: 30),
    Student(firstName: "Fievel", lastName: "Fifti", grade: 50),
    Student(firstName: "Nuno", lastName: "Neintee", grade: 90)
  ]
)
classroom.highestGrade
/*:
2. Rewrite `curveGrades` to not involve copying any student.
*/
extension Classroom {
  mutating func curveGrades() {
    guard let highestGrade = highestGrade else {
      return
    }
    
    let curveAmount = 100 - highestGrade
    
    students =
      students.map { student in
        var student = student
        student.grade += curveAmount
        return student
      }
      .sorted { $0.grade > $1.grade }
  }
}
//: Use "Show Result" on the two `classroom.students` lines below to make sure `curveGrades` is working as exptected.
classroom.students
classroom.curveGrades()
classroom.students
