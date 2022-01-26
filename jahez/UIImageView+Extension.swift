//
//  UIImageView+Extension.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import Kingfisher
import UIKit

extension UIImageView{
    func loadImage(with url: String?, defaultImage: UIImage? = nil) {
        guard let url = url, let imageUrl = URL(string: url) else {
            self.image = defaultImage
            return
        }
        kf.setImage(with: imageUrl, placeholder: defaultImage)
    }
}
