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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear()
    }
}

extension ProductGridView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.productCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productGridCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "productGridCell",
                                                                  for: indexPath) as! ProductGridCollectionViewCell
        
        if let product = presenter?.product(at: indexPath) {
            productGridCell.configure(with: product)
        }
        
        return productGridCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = presenter?.cellSizeFrom(collectionViewSize: collectionView.size, at: indexPath) ?? Size(0, 0)
        
        return CGSize(width: size.width.cgFloatValue, height: size.height.cgFloatValue)
    }
}


extension ProductGridView: ProductGridViewProtocol {
    
    func reloadData() {
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
