//
//  Manufactured.swift
//  Question1
//
//  Created by Ashish Samanta on 12/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Manufactured : item,tax{
    
    func calculate_tax() -> Void{
        
        let temp = 0.02*(getPrice() + 0.125*getPrice())
        setSalesTax((0.125*getPrice() + temp)*(Double(getQuantity())))
        setFinalTax(getSalesTax() + getPrice()*Double(getQuantity()))
    }
    
    override init(name:String,type:itemTypes,quantity:Int,price:Double)
    {
        super.init(name: name,type: type,quantity: quantity,price: price)
        calculate_tax()
    }
}

