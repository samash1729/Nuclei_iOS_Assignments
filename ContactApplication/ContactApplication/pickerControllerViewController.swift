//
//  pickerControllerViewController.swift
//  ContactApplication
//
//  Created by Ashish Samanta on 23/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class pickerControllerViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var customLabel: UITextField!
    
    var tempLabel:String = "Home"
    
    @IBAction func addBtnCustomLabel(_ sender: Any) {
        
        if let str = customLabel.text{
            if str == ""{
                showToast(message: "EMPTY LABEL FIELD")
            }
            else{
                if ContactController.selector == 1{
                    ViewController.pickerData.append(str)
                    picker.reloadAllComponents()
                    showToast(message: "Label Successfully Added")
                }
                else{
                    ViewController.emailPickerData.append(str)
                    picker.reloadAllComponents()
                    showToast(message: "Label Successfully Added")
                }
            }
        }
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(ContactController.selector == 1){
            return ViewController.pickerData.count
        }
        else{
            return ViewController.emailPickerData.count
        }
    }
 
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if ContactController.selector == 1{
            return ViewController.pickerData[row]
        }
        else{
            return ViewController.emailPickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if ContactController.selector == 1{
            tempLabel = ViewController.pickerData[row]
        }
        else{
            tempLabel = ViewController.emailPickerData[row]
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.dataSource = self
        self.picker.delegate = self
    }
    
    @IBAction func selectLabelTapped(_ sender: Any) {
        
        if ContactController.selector == 1{
            ViewController.changeLabel = tempLabel
        }
        else{
            ViewController.changeEmailLabel = tempLabel
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
