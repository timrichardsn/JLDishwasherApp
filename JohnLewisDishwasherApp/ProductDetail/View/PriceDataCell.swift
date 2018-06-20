//
//  PriceDataCell.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 20/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

class PriceDataCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var specialOfferLabel: UILabel!
    @IBOutlet weak var guaranteeLabel: UILabel!
    
    func configure(product: Product?) {
        
        priceLabel.text = product?.priceString ?? ""
        specialOfferLabel.text = product?.displaySpecialOffer ?? ""
        guaranteeLabel.text = product?.guaranteeInformation?.first ?? ""
    }
}
