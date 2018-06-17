//
//  ProductGridRouter.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

class ProductGridRouter: ProductGridRouterProtocol {
    
    static func createProductGridModule() -> UIViewController {
        
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsNavigationController")
        
        return navigationController
    }
    
    
}
