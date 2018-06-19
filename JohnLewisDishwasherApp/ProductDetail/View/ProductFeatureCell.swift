//
//  ProductFeatureCell.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

class ProductFeatureCell: UITableViewCell {

    @IBOutlet weak var featureName: UILabel!
    @IBOutlet weak var featureValue: UILabel!
    
    func configure(name: String?, value: String?) {
        featureName.text = name ?? ""
        featureValue.text = value ?? ""
    }
    
}
