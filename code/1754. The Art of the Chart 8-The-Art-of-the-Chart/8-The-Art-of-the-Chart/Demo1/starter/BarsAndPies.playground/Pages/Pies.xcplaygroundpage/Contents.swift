import UIKit
import PlaygroundSupport
//: ## Pie Charts
//: A pie chart is best made using CAShapeLayers. It represents proportions so just takes a series of numbers and colors. In this case we are interested in how much of the total each number represents.
//: This is the same sample data and structure as the previous page.
struct ChartData {
    let value: CGFloat
    let color: UIColor
}
let dataPoints: [ChartData] = [
    ChartData(value: 40, color: .red),
    ChartData(value: 60, color: .orange),
    ChartData(value: 120, color: .yellow),
    ChartData(value: 160, color: .green),
    ChartData(value: 20, color: .blue),
    ChartData(value: 30, color: #colorLiteral(red: 0.364705890417099, green: 0.0666666701436043, blue: 0.968627452850342, alpha: 1.0)),
    ChartData(value: 78, color: .purple)
]
//: **Start your demo coding here!**
class PieChart: UIView {
    
}
//: Put your pie on the screen
let pie = PieChart(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
pie.backgroundColor = .lightGray
PlaygroundPage.current.liveView = pie
//: **Populate your pie data here!**





















//: ## Some diagrams to help with theory
//: #### Arc thickness:
//:![Arc Thickness](ArcThickness.png)
//: _Arcs are drawn with a thickness equal to the radius of the pie to draw a wedge_
//:
//: #### Degrees versus radians:
//:![Degrees versus radians](radians.png)
//: _There are 2-pi radians in a circle_
//:
//: #### Assembling slices:
//:![Assembling slices](AssemblingSlices.png)
//: _Each slice starts at 0 and goes to the running total. They are stacked on top of each other_
//:






























