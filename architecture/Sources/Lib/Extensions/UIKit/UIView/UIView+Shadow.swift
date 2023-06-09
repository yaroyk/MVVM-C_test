//
//  UIView+Shadow.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import UIKit

extension UIView {
    func addShadow(offsetHeight: Int = 0, offsetWidth: Int = 0, color: UIColor, radius: CGFloat, opacity: Float = 1) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize.init(width: offsetWidth, height: offsetHeight)
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func addShadowAndCornerRadius(offsetHeight: Int, offsetWidth: Int, color: UIColor, shadowRadius: CGFloat, cornerRadius: CGFloat, masksToBounds: Bool = false) {
        layer.masksToBounds = masksToBounds
        layer.shadowOffset = CGSize.init(width: offsetWidth, height: offsetHeight)
        layer.shadowColor = color.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 1
        layer.cornerRadius = cornerRadius
    }
}
