//
//  ProductDetailPresenter.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation

class ProductDetailPresenter: ProductDetailViewPresenterProtocol {
    
    private var _isLandscape: Bool?
    
    weak var view: ProductDetailViewProtocol?
    var router: ProductDetailRouterProtocol?
    var interactor: ProductDetailInteractorProtocol?
    var product: Product?
    
    var isLandscape: Bool? {
        set {
            let oldValue = _isLandscape
            _isLandscape = newValue
            if oldValue != newValue {
                view?.refresh()
            }
        }
        get {
            return _isLandscape
        }
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        OrientationLocker.lockOrientation(.all)
    }
}
