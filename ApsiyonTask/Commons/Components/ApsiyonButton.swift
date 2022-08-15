//
//  ApsiyonButton.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import UIKit

/// ApsiyonButton for Case Study.
///
/// ```
/// ApsiyonButton(text: "Add", color: .green, symbol: "plus")
/// ```
/// > if you want manipulate other colors.
///
/// ```
/// ApsiyonButton(text: "Add", color: .green, symbol: "plus", bgColor: .systemGray, borderColor: .yellow, symbolColor: .red)
/// ```
public class ApsiyonButton: UIButton {
    
    private let border = CAShapeLayer()
    private let defaultColor: UIColor = .green
    
    var buttonText: String
    var textColor: UIColor
    var borderColor: UIColor
    var borderWidth: CGFloat
    var cornerRadius: CGFloat
    var bgColor: UIColor
    var sfSymbol: String
    var symbolColor: UIColor
    
    init(
        text: String,
        color: UIColor = .green,
        symbol: String = "",
        bgColor: UIColor? =  nil,
        borderColor: UIColor? = nil,
        symbolColor: UIColor? = nil,
        borderWidth: CGFloat = 3,
        cornerRadius: CGFloat = 10
    ){
        self.buttonText = text
        self.textColor = color
        self.bgColor = bgColor != nil ? bgColor! : .white
        self.borderColor = borderColor != nil ? borderColor! : color
        self.symbolColor = symbolColor != nil ? symbolColor! : color
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.sfSymbol = symbol
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        styleButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        border.lineWidth = borderWidth
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        
        self.layer.addSublayer(border)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }

    private func styleButton() {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: sfSymbol, withConfiguration: configuration)
        
        border.lineDashPattern = [10,10]
        border.strokeColor = borderColor.cgColor
        backgroundColor = bgColor
        imageView?.contentMode = .scaleAspectFit
        imageView?.tintColor = symbolColor
        layer.cornerRadius = cornerRadius
        
        setTitle(buttonText, for: .normal)
        setTitleColor(textColor, for: .normal)
        setImage(image, for: .normal)
    }
}
