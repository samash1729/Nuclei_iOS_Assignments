//
//  Imported.swift
//  Question1
//
//  Created by Ashish Samanta on 12/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Imported : item,tax {

    func calculate_tax() -> Void{
        
        var tempValue = 0.1*getPrice()
        if(tempValue+getPrice()<=100)
        {
            tempValue += 5
        }
        else if((tempValue+getPrice())>100 && (tempValue+getPrice())<=200)
        {
            tempValue += 10
        }
        else{
            tempValue += 0.05*(tempValue+getPrice())
        }
        setSalesTax(tempValue*(Double(getQuantity())))
        setFinalTax(getSalesTax()+(getPrice()*(Double(getQuantity()))))
    }
    
    override init(name:String,type:itemTypes,quantity:Int,price:Double)
    {
        super.init(name: name,type: type,quantity: quantity,price: price)
        calculate_tax()
    }

}
