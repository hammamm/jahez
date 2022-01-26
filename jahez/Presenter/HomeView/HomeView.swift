//
//  ViewController.swift
//  jahez
//
//  Created by hammam abdulaziz on 22/06/1443 AH.
//

import UIKit
import Alamofire

class HomeView: BaseView {

    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantCollectionViewCell.identifier)
        return collectionView
    }()

    private var data: [Restaurant]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        getData()
    }

    private func setupUi() {
        view.addSubview(collectionView)
        collectionView.anchorsToEdges(of: view)
    }
    
    private func getData() {
        Restaurant.getData(delegate: self, { result in
            result.getObject(self, callAgain: nil) { [weak self] object in
                self?.data = object
            }
        })
    }
}

extension HomeView: UICollectionViewDelegate{
    
}

extension HomeView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.identifier, for: indexPath) as? RestaurantCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = data?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.count ?? 0
    }
}
