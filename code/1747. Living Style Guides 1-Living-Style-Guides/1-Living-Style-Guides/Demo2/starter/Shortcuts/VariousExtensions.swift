extension SpacetimeFontSize: StyleGuideViewable {
  
  public var view: UIView {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: self.value)
    label.text = "\(self.value) pt"
    return label
  }
}

extension SpacetimeLabelStyle: StyleGuideViewable {
  public var view: UIView {
    let label = SpacetimeBaseLabel()
    label.labelStyle = self
    label.numberOfLines = 0
    label.text =
    """
    Font: \(label.font.fontName)
    Size: \(label.font.pointSize) pt
    Color: \(self.textColor.itemName)
    """
    
    return label
  }
}

extension SpacetimeButtonStyle: StyleGuideViewable {
  
  public var view: UIView {
    let buttonsStack = UIStackView()
    buttonsStack.axis = .vertical
    buttonsStack.distribution = .fillEqually
    buttonsStack.spacing = 4
    
    let states: [UIControlState] = [
      .normal,
      .highlighted,
      .selected,
      ]
    
    for state in states {
      let button = SpacetimeBaseButton()
      button.buttonStyle = self
      
      button.setTitle("Normal", for: .normal)
      button.setTitle("Highlighted", for: .highlighted)
      button.setTitle("Selected", for: .selected)
      
      switch state {
      case .selected:
        button.isSelected = true
      case .highlighted:
        button.isHighlighted = true
      default:
        break
      }
      
      buttonsStack.addArrangedSubview(button)
    }
    
    return buttonsStack
  }
}

