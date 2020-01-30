//
//  ProductViewModel.swift
//  ProuctsMVVM
//
//  Created by Ashish Samanta on 29/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ProductViewModel{
    
    private var dataModel:ProductModel! = nil
    
    func ViewDidLoad(){
        dataModel = ProductModel()
    }
    
    func validateParameters(name:String,type:String,price:Float,quantity:Int) -> Int
    {
        if name == "" {
            return -1
        }
        dataModel.name = name
        if type == "" {
            return -1
        }
        else{
            switch type{
            case "Raw" : dataModel.type = ProductModel.ProductType.Raw
            case "Manufactured" : dataModel.type = ProductModel.ProductType.Manufactured
            case "Imported": dataModel.type = ProductModel.ProductType.Imported
            default : return -2
            }
        }
        
        print("PRICE "+String(price))
        if(price < 0) {
            return -4
        }
        dataModel.price = price
        print("QUANTITY "+String(quantity))
        if(quantity < 0) {
            return -5
        }
        dataModel.quantity = quantity
        setTaxes(dataModel)
        saveData(forName: dataModel.name!, forType: type, forPrice: dataModel.price!, forQuantity: dataModel.quantity!, salesTax: dataModel.salesTax!, finalPrice: dataModel.finalPrice!)
        return 1
    }
    
    func setTaxes(_ dataModel:ProductModel){
        switch dataModel.type!{
        case .Raw : calculateRawTax(dataModel)
        case .Manufactured : calculateManufacturedTax(dataModel)
        case .Imported : calculateImportedTax(dataModel)
        }
    }
    
    func calculateRawTax(_ dataModel:ProductModel){
        dataModel.salesTax = (0.125 * dataModel.price! * Float(dataModel.quantity!))
        dataModel.finalPrice = dataModel.salesTax! + (dataModel.price! * Float(dataModel.quantity!))
    }
    
    func calculateManufacturedTax(_ dataModel:ProductModel){
        dataModel.salesTax = (0.125 * dataModel.price! + 0.02*(dataModel.price! + 0.125*dataModel.price!)) * Float(dataModel.quantity!)
        dataModel.finalPrice! = dataModel.salesTax! + dataModel.price! * Float(dataModel.quantity!)
    }
    
    func calculateImportedTax(_ dataModel:ProductModel){
        dataModel.salesTax = 0.2 * dataModel.price! * Float(dataModel.quantity!)
        dataModel.finalPrice = dataModel.salesTax! + (dataModel.price! * Float(dataModel.price!))
    }
    
    func saveData(forName name:String,forType type:String,forPrice price:Float,forQuantity quantity:Int,salesTax:Float,finalPrice:Float) -> Void{
        
        guard let appDelegate = UIApplication.shared.delegate as! AppDelegate? else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
        
        let product = NSManagedObject(entity: entity, insertInto: managedContext)
        
        product.setValue(name,forKeyPath:"name")
        product.setValue(type, forKeyPath: "type")
        product.setValue(price, forKeyPath: "price")
        product.setValue(quantity, forKeyPath: "quantity")
        product.setValue(salesTax,forKeyPath:"salesTax")
        product.setValue(finalPrice,forKeyPath:"finalPrice")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

