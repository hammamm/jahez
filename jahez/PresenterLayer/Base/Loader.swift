//
//  Loader.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import UIKit

class Loader: UIView {
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        alpha = 0
        animate(.showView(duration: 0.4))
    }
    
    func start() {
        addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicator.startAnimating()
        setup()
    }
    
    
    func stop() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.animate(.hideView(duration: 0.2))
            self.removeFromSuperview()
        }
    }
}
