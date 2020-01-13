//
//  Raw.swift
//  Question1
//
//  Created by Ashish Samanta on 12/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Raw : item,tax {
    
    func calculate_tax() -> Void {
        setSalesTax(0.125 * getPrice() * Double(getQuantity()))
        setFinalTax(getSalesTax() + getPrice()*Double(getQuantity()))
    }
    
    override init(name:String,type:itemTypes,quantity:Int,price:Double)
    {
        super.init(name: name,type: type,quantity: quantity,price: price)
        calculate_tax()
    }
    
}
