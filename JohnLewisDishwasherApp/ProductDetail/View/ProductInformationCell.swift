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
    
    func configure(productCode: String?, productInformation: String?) {
        productCodeLabel.text = productCode
        productInformationLabel.text = productInformation
    }
    
}
