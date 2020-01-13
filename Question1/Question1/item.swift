//
//  item.swift
//  Question1
//
//  Created by Ashish Samanta on 12/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class item{
    
    private var name:String = "",type:itemTypes = itemTypes.Raw
    private var quantity:Int = 0
    private var price:Double = 0.0,salesTax:Double = 0.0,finalTax:Double = 0.0
    
    init(name:String,type:itemTypes,quantity:Int,price:Double)
    {
        self.name = name
        self.type = type
        self.price = price
        self.quantity = quantity
    }
    
    func getPrice()->Double{
        return price
    }
    
    func getQuantity()->Int{
        return quantity
    }
    
    func setSalesTax(_ salesTax:Double){
        self.salesTax = salesTax
    }
    
    func getFinalTax()->Double{
        return finalTax
    }
    
    func setFinalTax(_ finalTax:Double){
        self.finalTax = finalTax
    }
    
    func getSalesTax()->Double{
        return salesTax
    }
    
    func getName()->String{
        return name
    }
    
    func getType()->String{
        switch type{
            case itemTypes.Raw : return "Raw"
            case itemTypes.Manufactured: return "Manufactured"
            case itemTypes.Imported : return "Imported"
        }
    }
}
