//
//  DetailsView.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import UIKit

class DetailsView: UIViewController {

    var data: Restaurant?
    
    private lazy var containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.setup(textColor: .black, font: .bold(18))
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setupBorder()
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.setup(textColor: .black, font: .regular(14))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setupBorder()
        return label
    }()

    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.setup(textColor: .black, font: .regular(14))
        label.textAlignment = .center
        label.setupBorder()
        return label
    }()

    lazy var hoursLabel: UILabel = {
        let label = UILabel()
        label.setup(textColor: .black, font: .regular(14))
        label.textAlignment = .center
        label.setupBorder()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setDataToView()
    }
    
    private func setupUi() {
        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descLabel)
        containerView.addSubview(rateLabel)
        containerView.addSubview(hoursLabel)
        containerView.anchors([.top(to: view.topAnchor), .leading(to: view.leadingAnchor), .trailing(to: view.trailingAnchor)])
        imageView.anchors([.top(to: containerView.topAnchor), .trailing(to: containerView.trailingAnchor), .leading(to: containerView.leadingAnchor), .height(toConstant: view.frame.width / 2)])
        nameLabel.anchors([.leading(to: containerView.leadingAnchor), .top(to: imageView.bottomAnchor)])
        descLabel.anchors([.leading(to: nameLabel.trailingAnchor), .top(to: imageView.bottomAnchor), .trailing(to: containerView.trailingAnchor)])
        rateLabel.anchors([.leading(to: containerView.leadingAnchor), .top(to: descLabel.bottomAnchor)])
        hoursLabel.anchors([.leading(to: rateLabel.trailingAnchor), .top(to: rateLabel.topAnchor), .trailing(to: containerView.trailingAnchor), .widthTo(item: rateLabel.widthAnchor)])
    }
    
    private func setDataToView() {
        navigationItem.title = data?.name
        imageView.loadImage(with: data?.image)
        nameLabel.text = data?.name
        descLabel.text = data?.description
        rateLabel.text = "rating \(data?.rating.description ?? "no rating")"
        hoursLabel.text = data?.hours
    }
}
