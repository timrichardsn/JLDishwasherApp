//
//  ProductGridView.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

class ProductGridView: UICollectionViewController {

    var presenter: ProductGridPresenterProtocol?
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
}

extension ProductGridView: ProductGridViewProtocol {
    
    func reloadData() {
        collectionView?.reloadData()
    }
}
