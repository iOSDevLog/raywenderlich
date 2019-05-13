import UIKit

public class ChartView: UIView {
    
    private let axisPadding = UIEdgeInsets(top: 10, left: 50, bottom: 50, right: 20)
    public let plotArea = UIView()
    
    public init(xAxis: Axis, yAxis: Axis) {
        let xAxisView = AxisView(axis: xAxis, orientation: .horizontal)
        let yAxisView = AxisView(axis: yAxis, orientation: .vertical)
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(plotArea)
        plotArea.translatesAutoresizingMaskIntoConstraints = false
        addSubview(xAxisView)
        addSubview(yAxisView)
        
        let ratio = yAxis.valueRange.size / xAxis.valueRange.size
        let aspect = NSLayoutConstraint(item: plotArea,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: plotArea,
                                        attribute: .width,
                                        multiplier: ratio,
                                        constant: 0)
        NSLayoutConstraint.activate([
            aspect,
            plotArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: axisPadding.left),
            plotArea.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -axisPadding.right),
            plotArea.topAnchor.constraint(equalTo: topAnchor, constant: axisPadding.top),
            plotArea.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -axisPadding.bottom),
            xAxisView.leadingAnchor.constraint(equalTo: plotArea.leadingAnchor, constant: 0.5),
            xAxisView.trailingAnchor.constraint(equalTo:plotArea.trailingAnchor, constant: -0.5),
            xAxisView.topAnchor.constraint(equalTo: plotArea.bottomAnchor, constant: -1),
            yAxisView.trailingAnchor.constraint(equalTo: plotArea.leadingAnchor, constant: 1),
            yAxisView.topAnchor.constraint(equalTo:plotArea.topAnchor, constant: 0.5),
            yAxisView.bottomAnchor.constraint(equalTo: plotArea.bottomAnchor, constant: -0.5)
            ])
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

