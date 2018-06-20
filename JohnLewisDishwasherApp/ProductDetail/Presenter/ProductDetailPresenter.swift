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
    
    let numberOfSections: Int = 3
    
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
    
    func numberOfRows(inSection section: Int) -> Int {
        
        if section == 0 {
            return isLandscape == true ? 1 : 2
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return product?.attributes?.count ?? 0
        }
        
        return 0
    }
    
    func heightForCellAt(row: Int, section: Int) -> Int? {
        
        // Need more descriptive references here, i.e. if section == sectionForFeatures etc
        if section == 0 {
            
            if row == 0 {
                return 500
            }
            
        } else if section == 2 {
            return 60
        }
        
        return nil
    }
    
    func titleForHeaderIn(section: Int) -> String? {
        if section == 1 {
            return "Product information"
        } else if section == 2 {
            return "Product specification"
        }
        
        return nil
    }
    
    func heightForHeaderIn(section: Int) -> Int? {
        if section == 0 {
            return nil
        }
        
        return 100
    }
}
