//
//  ProductGridCollectionViewCell.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 18/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductGridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func configure(with product: Product) {
        productTitle.text = product.title
        productPrice.text = product.priceString
        
        let url = URL(string: "https:\(product.imageUrl)")
        productImage.af_setImage(withURL: url!)
    }
}
