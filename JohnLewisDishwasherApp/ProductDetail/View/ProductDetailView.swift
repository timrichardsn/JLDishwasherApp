//
//  ProductDetailView.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

class ProductDetailView: UIViewController {
    var presenter: ProductDetailViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override var traitCollection: UITraitCollection {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            if UIDevice.current.orientation.isPortrait {
                return UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
            } else if UIDevice.current.orientation.isLandscape {
                return UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
            }
        }
        
        return super.traitCollection
    }
}

extension ProductDetailView: ProductDetailViewProtocol {

}
