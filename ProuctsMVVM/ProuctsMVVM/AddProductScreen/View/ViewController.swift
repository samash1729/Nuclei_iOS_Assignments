//
//  ViewController.swift
//  ProuctsMVVM
//
//  Created by Ashish Samanta on 29/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    

    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    var productViewModel:ProductViewModel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productViewModel = ProductViewModel()
    }

    @IBAction func addBtnTapped(_ sender: Any) {
        if let name = nameTextField.text{
            if let type = typeTextField.text{
                if let price = priceTextField.text{
                    if let actualPrice = Float(price){
                        if let quantity = quantityTextField.text{
                            if let actualQuantity = Int(quantity){
                                productViewModel.ViewDidLoad()
                                print("HERE")
                                
                                let response = productViewModel.validateParameters(name: name, type: type, price: actualPrice, quantity: actualQuantity)
                                print(response)
                                switch response{
                                case 1 : showToast(message: "ADDED")
                                case -1 : showToast(message: "One or More Fields Empty")
                                case -2 : showToast(message: "Invalid Type")
                                case -4 : showToast(message: "Price Less Than 0")
                                case -5 : showToast(message: "Quantity Less Than 0")
                                default : print("Shouldnt Happen")
                                }
                            }else{
                                showToast(message: "Quantity Not Int")
                            }
                        }else{
                            showToast(message: "Quantity Set To Nil")
                        }
                    }else{
                        showToast(message: "Price Not Float")
                    }
                }else{
                    showToast(message: "Price Set To Nil")
                }
            }else{
                showToast(message: "Type Set To Nil")
            }
        }else{
            showToast(message: "Name Set To Nil")
        }
        clearData()
    }
    
    func clearData() -> Void{
        nameTextField.text   = ""
        quantityTextField.text = ""
        priceTextField.text = ""
        typeTextField.text = ""
    }
    
    @IBAction func showBtnTapped(_ sender: Any) {
    }
}

