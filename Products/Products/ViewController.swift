//
//  ViewController.swift
//  Products
//
//  Created by Ashish Samanta on 22/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    static var finalName:String = ""
    static var finaltype:String = ""
    static var finalPrice:Float = 0.0
    static var finalQuantity:Int = 0
    
    var name:String = ""
    var type:String = "Raw"
    var price:Float = 0.0
    var quantity:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func showBtnTapped(_ sender: Any) {
        
        let addContactViewController = storyboard?.instantiateViewController(withIdentifier: "TableControllerTableViewController") as! TableControllerTableViewController
    self.navigationController?.pushViewController(addContactViewController, animated: true)
        
        
    }
    
    @IBOutlet weak var productName: UITextField!
    
    @IBOutlet weak var productType: UITextField!
    
    
    @IBOutlet weak var productPrice: UITextField!
    
    @IBOutlet weak var productQuantity: UITextField!
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        
        if let tempName = productName.text{
            if(tempName == ""){
                showToast(message: "ONE OR MORE VALUES EMPTY")
                clearData()
                return
            }
            name = tempName
        }else{
            showToast(message: "NAME VALUE SET TO NIL")
            clearData()
            return
        }
        
        if let tempType = productType.text{
            switch tempType{
                case "Raw" : type = "Raw"
                case "Manufactured" : type = "Manufactured"
                case "Imported" : type = "Imported"
                default: showToast(message: "INVALID TYPE")
                         clearData()
                         return
            }
        }else{
            showToast(message: "TYPE VALUE SET TO NIL")
            clearData()
            return
        }
        
        if let tempPrice = productPrice.text{
            if let somePrice = Float(tempPrice){
                if somePrice > 0{
                    price = somePrice
                }else{
                    showToast(message: "PRICE NEGATIVE")
                    clearData()
                    return
                }
            }else{
                showToast(message: "COULDNT CONVERT TO FLOAT")
                clearData()
                return
            }
        }
        else{
            showToast(message: "PRICE VALUE SET TO NIL")
            clearData()
            return
        }
        
        if let tempQuantity = productQuantity.text{
            if let someQuantity = Int(tempQuantity){
                if someQuantity > 0{
                    quantity = someQuantity
                }else{
                    showToast(message: "QUANTITY NEGATIVE")
                    clearData()
                    return
                }
            }else{
                showToast(message: "COULDNT CONVERT TO INTEGER")
                clearData()
                return
            }
        }
        else{
            showToast(message: "QUANTITY VALUE SET TO NIL")
            clearData()
            return
        }
        
        saveData(forName: name, forType: type, forPrice: price, forQuantity: quantity)
        
    }
    
    
    
    func saveData(forName name:String,forType type:String,forPrice price:Float,forQuantity quantity:Int) -> Void{
        
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
        
        do {
            try managedContext.save()
            showToast(message: "SAVE SUCCESSFUL")
            clearData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func clearData() -> Void{
        productName.text = ""
        productType.text = ""
        productPrice.text = ""
        productQuantity.text = ""
    }
    
    
}


extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/3 - 75, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    
} }

