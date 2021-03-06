//
//  ProductGridView.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

class ProductGridView: UIViewController {

    var presenter: ProductGridPresenterProtocol?
    var products = [Product]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}

extension ProductGridView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productGridCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "productGridCell",
                                                                  for: indexPath) as! ProductGridCollectionViewCell
        
        presenter?.configure(productGridCell: productGridCell, with: products[indexPath.row])
        
        return productGridCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = presenter?.cellSizeFrom(collectionViewSize: collectionView.size) ?? Size(0, 0)
        
        return CGSize(width: size.width.cgFloatValue, height: size.height.cgFloatValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter?.showProductDetail(forProduct: products[indexPath.row])
    }
}

extension ProductGridView: ProductGridViewProtocol {
    
    func show(products: [Product]) {
        self.products = products
        
        title = presenter?.titleForView(productCount: products.count)
        
        collectionView.reloadData()
    }
}

private extension CGFloat {
    var floatValue: Float {
        return Float(self)
    }
}

private extension Float {
    var cgFloatValue: CGFloat {
        return CGFloat(self)
    }
}

private extension UICollectionView {
    var size: Size {
        return Size(bounds.width.floatValue, bounds.height.floatValue)
    }
}
