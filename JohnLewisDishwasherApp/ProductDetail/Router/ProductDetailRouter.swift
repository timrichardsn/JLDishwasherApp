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
        
        let productDetailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailView") as! ProductDetailView
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()
        
        productDetailView.presenter = presenter
        
        presenter.view = productDetailView
        presenter.product = product
        presenter.router = router
        
        return productDetailView
    }
}