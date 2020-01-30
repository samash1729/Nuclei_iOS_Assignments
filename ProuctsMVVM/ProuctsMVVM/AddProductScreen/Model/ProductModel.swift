//
//  ProductModel.swift
//  ProuctsMVVM
//
//  Created by Ashish Samanta on 29/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

public class ProductModel {
    
    static var ProductArray:[ProductModel] = []
    
    enum ProductType{
        case Raw
        case Imported
        case Manufactured
    }
    
    var name:String?
    var type:ProductType?
    var price:Float?
    var quantity:Int?
    var salesTax:Float?
    var finalPrice:Float?
    
}
