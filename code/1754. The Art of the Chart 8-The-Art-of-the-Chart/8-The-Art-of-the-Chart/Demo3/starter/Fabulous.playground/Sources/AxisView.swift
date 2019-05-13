import UIKit

public class AxisView: UIView {
    
    public enum orientation { case vertical, horizontal }
    let tickViews: [TickView]
    let line = UIView()
    
    public init(axis: Axis, orientation: orientation) {
        tickViews = axis.ticks.map { TickView(tick: $0, orientation: orientation) }
        super.init(frame: .zero)
        clipsToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        
        let shortSide: NSLayoutDimension
        switch orientation {
        case .horizontal:
            shortSide = line.heightAnchor
            constraints.append(line.topAnchor.constraint(equalTo: topAnchor))
            constraints.append(line.leadingAnchor.constraint(equalTo: leadingAnchor))
            constraints.append(line.trailingAnchor.constraint(equalTo: trailingAnchor))
        case .vertical:
            shortSide = line.widthAnchor
            constraints.append(line.trailingAnchor.constraint(equalTo: trailingAnchor))
            constraints.append(line.topAnchor.constraint(equalTo: topAnchor))
            constraints.append(line.bottomAnchor.constraint(equalTo: bottomAnchor))
        }
        constraints.append(shortSide.constraint(equalToConstant: 1))
        
        tickViews.forEach {
            addSubview($0)
            switch orientation {
            case .horizontal:
                constraints.append($0.topAnchor.constraint(equalTo: topAnchor))
                
                if $0.position.isZero {
                    constraints.append($0.centerXAnchor.constraint(equalTo: leadingAnchor))
                } else {
                    let position = NSLayoutConstraint(item: $0, attribute: .centerX, relatedBy: .equal, toItem: line, attribute: .trailing, multiplier: $0.position, constant: 0)
                    constraints.append(position)
                    
                }
            case .vertical:
                constraints.append($0.trailingAnchor.constraint(equalTo: trailingAnchor))
                let convertedPosition = (1 - $0.position)
                if convertedPosition.isZero {
                    constraints.append($0.centerYAnchor.constraint(equalTo: topAnchor))
                } else {
                    let position = NSLayoutConstraint(item: $0, attribute: .centerY, relatedBy: .equal, toItem: line, attribute: .bottom, multiplier: convertedPosition, constant: 0)
                    constraints.append(position)
                    
                }
            }
        }
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TickView: UIView {
    let label = UILabel()
    let tickMarker = UIView()
    let position: CGFloat
    
    init(tick: Tick, orientation: AxisView.orientation) {
        position = tick.position
        super.init(frame: .zero)
        label.text = tick.labelValue
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        tickMarker.backgroundColor = .black
        tickMarker.translatesAutoresizingMaskIntoConstraints = false
        let stack = UIStackView()
        
        let shortSide: NSLayoutDimension
        let longSide: NSLayoutDimension
        switch orientation {
        case .horizontal:
            stack.axis = .vertical
            shortSide = tickMarker.widthAnchor
            longSide = tickMarker.heightAnchor
            stack.addArrangedSubview(tickMarker)
            stack.addArrangedSubview(label)
        case .vertical:
            stack.axis = .horizontal
            shortSide = tickMarker.heightAnchor
            longSide = tickMarker.widthAnchor
            stack.addArrangedSubview(label)
            stack.addArrangedSubview(tickMarker)
        }
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            shortSide.constraint(equalToConstant: 1),
            longSide.constraint(equalToConstant: 5)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
