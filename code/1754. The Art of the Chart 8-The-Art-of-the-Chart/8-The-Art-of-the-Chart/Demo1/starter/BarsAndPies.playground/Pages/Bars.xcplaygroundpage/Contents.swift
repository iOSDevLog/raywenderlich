import UIKit
import PlaygroundSupport
//: ## Bar Charts
//: This boring gray box is going to be our chart container, you should see it in the assistant editor 👉
let chart = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
chart.backgroundColor = .lightGray
//: This simple struct represents the data that the chart is modelling
struct ChartData {
    let value: CGFloat
    let color: UIColor
}
//: This code generates some sample data for you
let dataPoints: [ChartData] = [
    ChartData(value: 40, color: .red),
    ChartData(value: 60, color: .orange),
    ChartData(value: 120, color: .yellow),
    ChartData(value: 160, color: .green),
    ChartData(value: 20, color: .blue),
    ChartData(value: 30, color: #colorLiteral(red: 0.364705890417099, green: 0.0666666701436043, blue: 0.968627452850342, alpha: 1.0)),
    ChartData(value: 78, color: .purple)
]
PlaygroundPage.current.liveView = chart
//: **Start your demo coding here!**
//Add a stack view























