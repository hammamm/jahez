//
//  UIFont+Extension.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import UIKit

extension UIFont{
    static func light(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .light)
    }

    static func regular(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .regular)
    }

    static func bold(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
