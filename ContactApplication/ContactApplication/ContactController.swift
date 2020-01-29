//
//  ContactController.swift
//  ContactApplication
//
//  Created by Ashish Samanta on 25/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class ContactController: UIViewController , UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var companyName: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lastName: UITextField!
    static var selector:Int = 1
    
    static var phoneNumbers:[String] = ["","","","",""]
    
    static var emailIds:[String] = ["","","","",""]
    
    static var fname:String = ""
    
    static var lname:String = ""
    
    static var cname:String = ""
    
    @IBOutlet weak var emailTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tabView{
            return ViewController.phoneTypes.count
        }
        
        if tableView == self.emailTable{
            return ViewController.emailTypes.count
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.emailTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellCustomTableViewCell",for: indexPath) as! CellCustomTableViewCell
            
            cell.mybtn.setTitle(ViewController.emailTypes[indexPath.row], for: .normal)
            
            if ContactController.emailIds[indexPath.row] != ""{
               cell.myPlaintext.text = ContactController.emailIds[indexPath.row]
            }
            else{
                cell.myPlaintext.attributedPlaceholder = NSAttributedString(string:ViewController.emailTypes[indexPath.row]+" ID",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            }
            
            cell.buttonDelegate = self
            cell.index = indexPath
            cell.selector = 2
            return cell
            
        }
        if tableView == self.tabView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellCustomTableViewCell",for: indexPath) as! CellCustomTableViewCell
            
            cell.mybtn.setTitle(ViewController.phoneTypes[indexPath.row], for: .normal)
            
            if ContactController.phoneNumbers[indexPath.row] != ""{
                cell.myPlaintext.text = ContactController.phoneNumbers[indexPath.row]
            }
            else{
                cell.myPlaintext.attributedPlaceholder = NSAttributedString(string:ViewController.phoneTypes[indexPath.row]+" NUMBER",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            }

            cell.buttonDelegate = self
            cell.index = indexPath
            cell.selector = 1
            return cell
        }
        let cell = UITableViewCell.init()
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(ContactController.phoneNumbers)
        
        if(ContactController.fname != ""){
           firstName.text = ContactController.fname
        }
        else{
            firstName.attributedPlaceholder = NSAttributedString(string:"FIRST NAME",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
        if(ContactController.lname != ""){
            lastName.text = ContactController.lname
        }
        else{
            lastName.attributedPlaceholder = NSAttributedString(string:"LAST NAME",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
        if(ContactController.cname != ""){
            companyName.text = ContactController.cname
        }
        else{
            companyName.attributedPlaceholder = NSAttributedString(string:"COMPANY NAME",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
        
        tabView.reloadData()
        emailTable.reloadData()
        
        print("*******")
        print(ViewController.phoneTypes.count)
        print(ViewController.emailTypes.count)
        print(ContactController.phoneNumbers.count)
        print(ContactController.emailIds.count)
        
        if ViewController.changeLabel != ""{
            tabView.reloadData()
            if let saverow = ViewController.saveRow{
                let temp:CellCustomTableViewCell = tabView.cellForRow(at: saverow) as! CellCustomTableViewCell
                temp.mybtn.setTitle(ViewController.changeLabel, for: .normal)
                ViewController.phoneTypes[saverow.row] = ViewController.changeLabel
                ViewController.changeLabel = ""
                return
            }
        }
        if ViewController.changeEmailLabel != ""{
            if let saverow = ViewController.saveRow{
                let temp:CellCustomTableViewCell = emailTable.cellForRow(at: saverow) as! CellCustomTableViewCell
                temp.mybtn.setTitle(ViewController.changeEmailLabel, for: .normal)
                ViewController.emailTypes[saverow.row] = ViewController.changeEmailLabel
                ViewController.changeEmailLabel = ""
                return
            }
        }
        tabView.reloadData()
        emailTable.reloadData()
    }
    
    @objc func incCount(index: IndexPath,select:Int){
        ViewController.saveRow = index
        ContactController.selector = select
        
            var i:Int = 0
        
        if let fname = firstName.text{
            if fname != ""{
                ContactController.fname = fname
            }
        }
        if let lname = lastName.text{
            if lname != ""{
                ContactController.lname = lname
            }
        }
        if let cname = companyName.text{
            if cname != ""{
                ContactController.cname = cname
            }
        }
            for cell in tabView.visibleCells {
                if let customCell = cell as? CellCustomTableViewCell {
                        ContactController.phoneNumbers[i] = customCell.myPlaintext.text!
                        i += 1
                }
            }
        
        
            var j:Int = 0
            for cell in emailTable.visibleCells {
                if let customCell = cell as? CellCustomTableViewCell {
                    ContactController.emailIds[j] = customCell.myPlaintext.text!
                    j += 1
                }
            }
        
        let addContactViewControlle = storyboard?.instantiateViewController(withIdentifier: "pickerControllerViewController") as? pickerControllerViewController
        self.navigationController?.pushViewController(addContactViewControlle!, animated: true)
    }
    
    @IBOutlet weak var tabView: UITableView!
    
    @IBAction func addPhone(_ sender: Any) {
        if ViewController.phoneTypes.count == 5{
            showToast(message: "Cannot Add More Phone Numbers")
            return
        }
        ViewController.phoneTypes.append("Home")
        tabView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.dataSource = self
        tabView.delegate = self
        emailTable.dataSource = self
        emailTable.delegate = self
        tabView.register(UINib(nibName: "CellCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CellCustomTableViewCell")
        tabView.tableFooterView = UIView()
        emailTable.register(UINib(nibName: "CellCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CellCustomTableViewCell")
        emailTable.tableFooterView = UIView()
        emailTable.reloadData()
        tabView.reloadData()
    }

    @IBAction func addEmail(_ sender: Any) {
        if ViewController.emailTypes.count == 5{
            showToast(message: "Cannot Add More Emails")
            return
        }
        ViewController.emailTypes.append("Personal")
        emailTable.reloadData()
    }
    @IBAction func addContact(_ sender: Any) {
        
        guard validations() == true else{
            return
        }
        
        if ViewController.editOption == true{
            for contactNode in ViewController.contactList{
                if contactNode.firstName == ContactController.fname && contactNode.lastName == ContactController.lname{
                    let num = contactNode.phoneNumbers.count
                    var i:Int = 0
                    for cell in tabView.visibleCells{
                        if let customCell = cell as? CellCustomTableViewCell{
                            if i<num{
                                if contactNode.phoneNumbers[i].type != customCell.mybtn.title(for: .normal){
                                    contactNode.phoneNumbers[i].type = customCell.mybtn.title(for: .normal)!
                                }
                                if contactNode.phoneNumbers[i].number != customCell.myPlaintext.text!{
                                    contactNode.phoneNumbers[i].number = customCell.myPlaintext.text!
                                }
                                i+=1
                                continue
                            }
                            let typen = customCell.mybtn.title(for: .normal)
                            let numbern = customCell.myPlaintext.text!
                            contactNode.phoneNumbers.append((type:typen!,number: numbern))
                            i+=1
                        }
                    }
                    i=0
                    let emailNum = contactNode.emailIds.count
                    for cell in emailTable.visibleCells{
                        if let customCell = cell as? CellCustomTableViewCell{
                            if i<emailNum{
                                if contactNode.emailIds[i].type != customCell.mybtn.title(for: .normal){
                                    contactNode.emailIds[i].type = customCell.mybtn.title(for: .normal)!
                                }
                                if contactNode.emailIds[i].id != customCell.myPlaintext.text{
                                    contactNode.emailIds[i].id = customCell.myPlaintext.text!
                                }
                                i+=1
                                continue
                            }
                            let typen = customCell.mybtn.title(for: .normal)
                            let numbern = customCell.myPlaintext.text!
                            contactNode.emailIds.append((type:typen!,id: numbern))
                            i+=1
                        }
                    }
                }
            }
            
            ContactController.emailIds = ["","","","",""]
            ContactController.phoneNumbers = ["","","","",""]
            ViewController.emailTypes.removeAll()
            ViewController.phoneTypes.removeAll()
            ContactController.fname = ""
            ContactController.lname = ""
            ContactController.cname = ""
            ViewController.editOption = false
            self.navigationController?.popViewController(animated: true)
            
            
            
        }
        else{
        let contact:Contact = Contact()
        
        if let firstName = firstName.text{
            if firstName == ""{
                showToast(message: "ONE OR MORE FIELDS EMPTY")
                return
            }
            else{
                contact.firstName = firstName
            }
        }
        else{
            showToast(message: "ONE OR MORE FIELDS NIL")
            return
        }
        
        if let lastName = lastName.text{
            if lastName == ""{
                showToast(message: "ONE MORE FIELDS EMPTY")
                return
            }
            contact.lastName = lastName
        }
        else{
            showToast(message: "ONE OR MORE FIELDS NIL")
            return
        }
        
        if let companyName = companyName.text{
            if companyName == ""{
                showToast(message: "ONE OR MORE FIELDS EMPTY")
                return
            }
            contact.companyName = companyName
        }
        else{
            showToast(message: "ONE OR MORE FIELDS NIL")
            return
        }
        
        if tabView.visibleCells.count < 1{
            showToast(message: "NO PHONE NUMBERS")
            return
        }
        var checkCell:Bool = false
        for cell in tabView.visibleCells{
            if let customCell = cell as? CellCustomTableViewCell{
                if let checkValue = customCell.myPlaintext.text{
                    if checkValue != ""{
                        checkCell = true
                        let str = customCell.mybtn.title(for: .normal)!
                        contact.phoneNumbers.append((type:str,number:checkValue))
                    }
                }
            }
        }
        if checkCell == false{
            showToast(message: "No Phone Numbers")
            return
        }
        checkCell = false
        
        for cell in emailTable.visibleCells{
            if let customCell = cell as? CellCustomTableViewCell{
                if let checkValue = customCell.myPlaintext.text{
                    if checkValue != ""{
                        checkCell = true
                        let str = customCell.mybtn.title(for: .normal)!
                        contact.emailIds.append((type:str,id:checkValue))
                    }
                }
            }
        }
        if checkCell == false{
            showToast(message: "No Email IDs")
            return
        }
        
        ViewController.contactList.append(contact)
        showToast(message: "CONTACT ADDED")
        print(ViewController.contactList.first!.companyName)
        ContactController.emailIds = ["","","","",""]
        ContactController.phoneNumbers = ["","","","",""]
        ViewController.emailTypes.removeAll()
        ViewController.phoneTypes.removeAll()
        ContactController.fname = ""
        ContactController.lname = ""
        ContactController.cname = ""
        self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        ContactController.emailIds = ["","","","",""]
        ContactController.phoneNumbers = ["","","","",""]
        ViewController.emailTypes.removeAll()
        ViewController.phoneTypes.removeAll()
        ContactController.fname = ""
        ContactController.lname = ""
        ContactController.cname = ""
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func loadImage(_ sender: Any) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
//            let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
//            print(imageURL)
        }
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func validations() -> Bool{
        let letters = CharacterSet.letters
        
        guard firstName.text != nil else{
            showToast(message: "FIRST NAME NIL")
            return false
        }
        
        guard lastName.text != nil else{
            showToast(message: "LAST NAME NIL")
            return false
        }
        
        guard companyName.text != nil else{
            showToast(message: "COMPANY NAME NIL")
            return false
        }
        
        if let fname = firstName.text{
            if fname == ""{
                showToast(message: "FIRST NAME EMPTY")
                return false
            }
            else{
                
                for token in fname.unicodeScalars{
                    if letters.contains(token){
                        continue
                    }
                    else{
                        showToast(message: "FIRST NAME NOT ALL LETTERS")
                        firstName.text = ""
                        return false
                    }
                }
            }
        }
        
        if let lname = lastName.text{
            if lname == ""{
                showToast(message: "LAST NAME EMPTY")
                return false
            }
            else{
                for token in lname.unicodeScalars{
                    if letters.contains(token){
                        continue
                    }
                    else{
                        showToast(message: "LAST NAME NOT ALL LETTERS")
                        lastName.text = ""
                        return false
                    }
                }
            }
        }
        
        if let cname = companyName.text{
            if cname == ""{
                showToast(message: "COMPANY NAME EMPTY")
                return false
            }
            else{
                for token in cname.unicodeScalars{
                    if letters.contains(token){
                        continue
                    }
                    else{
                        showToast(message: "COMPANY NAME NOT ALL LETTERS")
                        companyName.text = ""
                        return false
                    }
                }
            }
        }
        
        for cell in tabView.visibleCells{
            if let customCell = cell as? CellCustomTableViewCell{
                if let checkValue = customCell.myPlaintext.text{
                    
                    if checkValue.count != 10{
                        showToast(message: "LENGTH > or < 10")
                        customCell.myPlaintext.text = ""
                        return false
                    }
                    if checkValue != ""{
                        for digit in checkValue.unicodeScalars{
                            if letters.contains(digit){
                                showToast(message: "PHONE NUMBER CONTAINS LETTERS")
                                customCell.myPlaintext.text = ""
                                return false
                            }
                        }
                    }
                }
            }
        }
        
        for cell in emailTable.visibleCells{
            if let customCell = cell as? CellCustomTableViewCell{
                if let checkValue = customCell.myPlaintext.text{
                    if checkValue != ""{
                        if checkValue.contains("@") && checkValue.contains("."){
                        
                            if checkValue.prefix(1) == "@" || checkValue.prefix(1)=="."{
                                showToast(message: "Invalid Email")
                                customCell.myPlaintext.text = ""
                                return false
                            }
                        }
                        else{
                            showToast(message: "Invalid Email")
                            customCell.myPlaintext.text = ""
                            return false
                        }
                    }
                }
            }
        }
        
        return true
    }
}
