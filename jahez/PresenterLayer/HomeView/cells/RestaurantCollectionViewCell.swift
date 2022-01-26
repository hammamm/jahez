//
//  RestaurantCollectionViewCell.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RestaurantCollectionViewCell"
    
    var data: Restaurant?{
        didSet{
            imageView.loadImage(with: data?.image)
            nameLabel.text = data?.name
            rateLabel.text = "rating: \(data?.rating.description ?? "no rating")"
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.setup(textColor: .black, font: .bold(18))
        return label
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.setup(textColor: .black, font: .regular(14))
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(imageView)
        contentView.addSubview(rateLabel)
        imageView.anchors([.leading(to: contentView.leadingAnchor, 8), .top(to: contentView.topAnchor, 8), .bottom(to: contentView.bottomAnchor, 8), .height(toConstant: 100), .width(toConstant: 100)])
        contentView.addSubview(nameLabel)
        nameLabel.anchors([.leading(to: imageView.trailingAnchor, 8), .top(to: imageView.topAnchor), .bottom(to: imageView.bottomAnchor)])
        rateLabel.anchors([.leading(to: nameLabel.trailingAnchor, 8), .top(to: imageView.topAnchor), .bottom(to: imageView.bottomAnchor), .trailing(to: contentView.trailingAnchor, 8)])
    }
}
