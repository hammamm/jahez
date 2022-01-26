//
//  UILabel+Extension.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import UIKit

extension UILabel{
    
    func setup(textColor: UIColor, backgroundColor: UIColor = .clear, font: UIFont, adjustSize: AdjustType = .no) -> Void {
        // for all views
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        self.adjustsFontSizeToFitWidth = adjustSize.needAdjust
        self.minimumScaleFactor = adjustSize.scaleFactor
    }
}

enum AdjustType: Equatable {
    case yes(CGFloat)
    case no
    
    var scaleFactor: CGFloat{
        switch self {
            case .yes(let scale): return scale
            case .no: return 0
        }
    }
    
    var needAdjust: Bool{
        self == .yes(0)
    }
    
    static func ==(lhs: AdjustType, rhs: AdjustType) -> Bool {
        switch (lhs, rhs) {
            case (.yes, .yes): return true
            case (.no, .no): return true
            default: return false
        }
    }
}
