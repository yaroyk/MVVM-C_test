//
//  UIView+CornerRadius.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import UIKit

extension CACornerMask {
    static var noCorners: CACornerMask { return [] }
    
    static var topLeftCorner: CACornerMask { return .layerMinXMinYCorner }
    static var topRightCorner: CACornerMask { return .layerMaxXMinYCorner }
    static var bottomLeftCorner: CACornerMask { return .layerMinXMaxYCorner }
    static var bottomRightCorner: CACornerMask { return .layerMaxXMaxYCorner }
    
    static var topCorners: CACornerMask { return [.topLeftCorner, .topRightCorner] }
    static var bottomCorners: CACornerMask { return [.bottomLeftCorner, .bottomRightCorner] }
    
    static var leftCorners: CACornerMask { return [.topLeftCorner, .bottomLeftCorner] }
    static var rightCorners: CACornerMask { return [.topRightCorner, .bottomRightCorner] }
    
    static var allCorners: CACornerMask {
        return [
            .topLeftCorner,
            .bottomLeftCorner,
            .topRightCorner,
            .bottomRightCorner,
        ]
    }
}

extension UIView {
    func set(corners: CACornerMask, radius cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = corners
        layer.cornerCurve = .continuous
    }
}
