//
//  UIView+Extension.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import UIKit

extension UIView{
    /// types of constraints
    enum Constraints {
        case top(to: NSLayoutYAxisAnchor,_ constant: CGFloat = 0)
        case bottom(to: NSLayoutYAxisAnchor,_ constant: CGFloat = 0)
        case left(to: NSLayoutXAxisAnchor,_ constant: CGFloat = 0)
        case right(to: NSLayoutXAxisAnchor,_ constant: CGFloat = 0)
        case leading(to: NSLayoutXAxisAnchor,_ constant: CGFloat = 0)
        case trailing(to: NSLayoutXAxisAnchor,_ constant: CGFloat = 0)
        case widthTo(item: NSLayoutDimension, constant: CGFloat = 0)
        case width(toConstant: CGFloat = 0)
        case heightTo(item: NSLayoutDimension, constant: CGFloat = 0)
        case height(toConstant: CGFloat = 0)
        case centerVertically(to: NSLayoutYAxisAnchor, _ constant: CGFloat = 0)
        case centerHorizontally(to: NSLayoutXAxisAnchor, _ constant: CGFloat = 0)
    }
    
    /// setup the view constraints by applying the types you need to setup your view
    /// - Parameter anchors: array of types
    func anchors(_ anchors: [Constraints]) {
        translatesAutoresizingMaskIntoConstraints = false
        anchors.forEach { anchor in
            switch anchor{
                case .top(let to, let constant):
                    topAnchor.constraint(equalTo: to, constant: constant).isActive = true
                case .bottom(let to, let constant):
                    bottomAnchor.constraint(equalTo: to, constant: -constant).isActive = true
                case .left(let to, let constant):
                    leftAnchor.constraint(equalTo: to, constant: constant).isActive = true
                case .right(let to, let constant):
                    rightAnchor.constraint(equalTo: to, constant: -constant).isActive = true
                case .leading(let to, let constant):
                    leadingAnchor.constraint(equalTo: to, constant: constant).isActive = true
                case .trailing(let to, let constant):
                    trailingAnchor.constraint(equalTo: to, constant: -constant).isActive = true
                case .widthTo(let item, let constant):
                    widthAnchor.constraint(equalTo: item, multiplier: 1, constant: constant).isActive = true
                case .width(let toConstant):
                    widthAnchor.constraint(equalToConstant: toConstant).isActive = true
                case .heightTo(let item, let constant):
                    heightAnchor.constraint(equalTo: item, multiplier: 1, constant: constant).isActive = true
                case .height(let toConstant):
                    heightAnchor.constraint(equalToConstant: toConstant).isActive = true
                case .centerVertically(let to, let constant):
                    centerYAnchor.constraint(equalTo: to, constant: constant).isActive = true
                case .centerHorizontally(let to, let constant):
                    centerXAnchor.constraint(equalTo: to, constant: constant).isActive = true
            }
        }
    }
    
    /// to make the view take place of full size of the super view
    /// - Parameters:
    ///   - view: the super view that contains the current view
    ///   - padding: the size you want the padding from each side
    func anchorsToEdges(of view: UIView, padding: CGFloat = 0) {
        anchors([.top(to: view.topAnchor, padding), .leading(to: view.leadingAnchor, padding), .trailing(to: view.trailingAnchor, padding), .bottom(to: view.bottomAnchor, padding)])
    }
    
    /// Multiple of cases to animate any UIView
    ///
    /// - Author: Hammam Abdulaziz.
    enum UIViewAnimation {
        /// Will change the color and animate if the duration > 0
        case changeColor(to: UIColor, duration: TimeInterval)
        /// Will hide the view and reduce the alpha value to 0 with animation if the duration > 0
        case hideView(duration: TimeInterval)
        /// Will show the view and increase the alpha value to 1 with animation if the duration > 0
        case showView(duration: TimeInterval)
    }
    

    
    /// Implementation for all cases in `UIViewAnimation`
    ///
    /// - Parameter animation: UIViewAnimation
    ///
    /// - Author: Hammam Abdulaziz.
    func animate(_ animation: UIViewAnimation) {
        switch animation {
            case .changeColor(let newColor, let duration):
                UIView.animate(withDuration: duration) {
                    self.backgroundColor = newColor
                }
            case .hideView(let duration):
                UIView.animate(withDuration: duration) {
                    self.alpha = 0
                    self.isHidden = true
                }
            case .showView(let duration):
                UIView.animate(withDuration: duration) {
                    self.isHidden = false
                    self.alpha = 1
                }
        }
    }

    func setupBorder(color: UIColor = .lightGray, width: CGFloat = 0.5) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
