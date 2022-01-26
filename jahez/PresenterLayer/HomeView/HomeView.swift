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
    
    @objc func topRatedSort() {
        data?.sort(by: { $0.rating > $1.rating })
    }
    
    @objc func lowestRatedSort() {
        data?.sort(by: { $0.rating < $1.rating })
    }
        
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
        setupNavigation()
        view.addSubview(collectionView)
        collectionView.anchorsToEdges(of: view)
        navigationItem.title = "jahez"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "top rated", style: .plain, target: self, action: #selector(topRatedSort))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "lowest rated", style: .plain, target: self, action: #selector(lowestRatedSort))
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = DetailsView()
        view.data = data?[indexPath.item]
        navigationController?.pushViewController(view, animated: true)
    }
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
