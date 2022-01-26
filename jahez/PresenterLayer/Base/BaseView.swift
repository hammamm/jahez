//
//  BaseView.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import UIKit

/// UIView used as loader
///
/// - Author: Hammam Abdulaziz
var loadingView: Loader = { Loader(frame: CGRect(x: 0, y: 0, width: 80, height: 80)) }()

class BaseView: UIViewController {
    func loading(_ start: Bool) {
        DispatchQueue.main.async {
            if start{
                self.view.addSubview(loadingView)
                loadingView.layer.zPosition = 1
                loadingView.anchorsToEdges(of: self.view)
                loadingView.start()
            }else{
                loadingView.stop()
            }
        }
    }
    
    func setupNavigation() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                              NSAttributedString.Key.font: UIFont.bold(17)
        ]
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .accent
        appearance.titleTextAttributes = textAttributes
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        tabBarController?.tabBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .accent
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
}
