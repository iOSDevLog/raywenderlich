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
    
    var slices = [CAShapeLayer]()
    
    func createSlicesFor(_ data: [ChartData]) {
        
        slices.forEach { $0.removeFromSuperlayer() }
        let total: CGFloat = data.reduce(0) { $0 + $1.value }
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.height * 0.25
        let lineWidth = bounds.height * 0.5
        
        var runningTotal: CGFloat = 0
        //1
        slices = data.map {
            //2
            runningTotal += $0.value
            let fraction = runningTotal / total
            //3
            let endAngle = .pi * 2 * fraction
            //4
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
            //5
            let slice = CAShapeLayer()
            slice.frame = layer.bounds
            slice.strokeColor = $0.color.cgColor
            slice.fillColor = nil
            slice.lineWidth = lineWidth
            slice.path = path.cgPath
            //6
            slice.setAffineTransform(CGAffineTransform(rotationAngle: -.pi * 0.5))
            layer.insertSublayer(slice, at: 0)
            return slice
        }
    }
    
    func fill(to proportion: CGFloat, animated: Bool = false) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.5
        animation.toValue = proportion
        slices.forEach {
            slice in
            animation.fromValue = slice.strokeEnd
            
            if animated {
                slice.add(animation, forKey: nil)
            }
            slice.strokeEnd = proportion
        }
    }
    
}
//: Put your pie on the screen
let pie = PieChart(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
pie.backgroundColor = .lightGray
PlaygroundPage.current.liveView = pie
//: **Populate your pie data here!**
pie.createSlicesFor(dataPoints)
pie.fill(to: 0)
pie.fill(to: 1, animated: true)










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































