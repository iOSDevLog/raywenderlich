import UIKit

public class ChartView: UIView {
    
    public convenience init(maxX: CGFloat, maxY: CGFloat) {
        let xAxis = Axis(valueRange: 0...maxX, maximumTickCount: 11)!
        let yAxis = Axis(valueRange: 0...maxY, maximumTickCount: 11)!
        
        self.init(xAxis: xAxis, yAxis: yAxis)
        bounds = CGRect(x:0, y:0, width: 500, height: 500)
        layoutIfNeeded()
    }
    
    private let xAxis: Axis
    private let yAxis: Axis
    
    public var scaleTransform: CGAffineTransform {
        let xRatio = plotArea.bounds.width / xAxis.valueRange.size
        let yRatio = plotArea.bounds.height / yAxis.valueRange.size
        return CGAffineTransform(scaleX: xRatio, y: yRatio)
    }
    
    private let axisPadding = UIEdgeInsets(top: 10, left: 50, bottom: 50, right: 20)
    public let plotArea = UIView()
    
    public init(xAxis: Axis, yAxis: Axis) {
        self.xAxis = xAxis
        self.yAxis = yAxis
        let xAxisView = AxisView(axis: xAxis, orientation: .horizontal)
        let yAxisView = AxisView(axis: yAxis, orientation: .vertical)
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(plotArea)
        plotArea.translatesAutoresizingMaskIntoConstraints = false
        plotArea.layer.isGeometryFlipped = true
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
    
    public func createShapeLayer(strokeColor: UIColor? = nil, fillColor: UIColor? = nil) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.frame = plotArea.bounds
        plotArea.layer.addSublayer(layer)
        layer.strokeColor = strokeColor?.cgColor
        layer.fillColor = fillColor?.cgColor
        layer.lineWidth = 2
        layer.lineJoin = kCALineJoinRound
        return layer
    }
    
}

