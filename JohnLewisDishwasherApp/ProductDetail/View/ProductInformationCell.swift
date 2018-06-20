//
//  ProductInformationCell.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

class ProductInformationCell: UITableViewCell {

    @IBOutlet weak var productCodeLabel: UILabel!
    @IBOutlet weak var productInformationLabel: UILabel!
    
    func configure(product: Product) {
        
        productCodeLabel.text = product.productCodeDisplayString
        
        if let attributedString = product.productInformationAttributedString {
            productInformationLabel.attributedText = attributedString
        } else {
            productInformationLabel.text = ""
        }
    }
}
