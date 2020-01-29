//
//  Item_DataViewController.swift
//  Products
//
//  Created by Ashish Samanta on 22/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class Item_DataViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var salesTaxLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var salesTax:Float = 0.0
    var finalPrice:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "NAME :"+ViewController.finalName
        priceLabel.text = "PRICE : "+String(ViewController.finalPrice)
        typeLabel.text = "TYPE : "+ViewController.finaltype
        quantityLabel.text = "QUANTITY : "+String(ViewController.finalQuantity)
        calculateTax(forType: ViewController.finaltype)
        salesTaxLabel.text = "SALES TAX : "+String(salesTax)
        finalPriceLabel.text = "FINAL PRICE : "+String(finalPrice)
        
    }
    
    func calculateTax(forType type:String) -> Void {
        
        switch type{
            case "Raw" :    calculateRawTax()
            case "Manufactured":    calculateManufacturedTax()
            case "Imported":    calculateImportedTax()
            default: print("Should Ever Happen")
        }
    }
    
    func calculateRawTax()->Void{
        salesTax = (0.125 * ViewController.finalPrice*Float(ViewController.finalQuantity))
        finalPrice = (salesTax+ViewController.finalPrice * Float(ViewController.finalQuantity))
    }
    
    func calculateManufacturedTax()->Void{
        let temp = 0.02*(ViewController.finalPrice + 0.125*ViewController.finalPrice)
        salesTax = ((0.125*ViewController.finalPrice+temp)*Float(ViewController.finalQuantity))
        finalPrice = salesTax + ViewController.finalPrice*Float(ViewController.finalQuantity)
    }
    
    func calculateImportedTax()->Void{
        
        var tempValue = 0.1*ViewController.finalPrice
        if(tempValue+ViewController.finalPrice<=100){
            tempValue += 5
        }
        else if (tempValue+ViewController.finalPrice)>100 && (tempValue+ViewController.finalPrice)<=200{
            tempValue += 10
        }
        else{
            tempValue += 0.05*(tempValue+ViewController.finalPrice)
        }
        salesTax = tempValue + Float(ViewController.finalQuantity)
        finalPrice = salesTax + (ViewController.finalPrice)*Float(ViewController.finalQuantity)
    }
    
}
