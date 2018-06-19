//
//  ProductDetailRouter.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

class ProductDetailRouter: ProductDetailRouterProtocol {
    
    static func createProductDetailModule(for product: Product) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailView")
    }
}
