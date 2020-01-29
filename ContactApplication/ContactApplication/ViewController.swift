//
//  ViewController.swift
//  ContactApplication
//
//  Created by Ashish Samanta on 23/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit



var sectionTitles:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

var sectionDictionary:[String:[String]] = ["A":[],"B":[],"C":[],"D":[],"E":[],"F":[],"G":[],"H":[],"I":[],"J":[],"K":[],"L":[],"M":[],"N":[],"O":[],"P":[],"Q":[],"R":[],"S":[],"T":[],"U":[],"V":[],"W":[],"X":[],"Y":[],"Z":[]]


class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionDictionary[sectionTitles[section]]!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        let arr = sectionDictionary[sectionTitles[indexPath.section]]!
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String{
            return String(sectionTitles[section])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let cell = tabView.cellForRow(at: indexPath){
                if let value = cell.textLabel?.text{
                    for (index,contactNode) in ViewController.contactList.enumerated(){
                        if String(contactNode.firstName+" "+contactNode.lastName) == value{
                            ViewController.contactList.remove(at: index)
                            sectionDictionary = ["A":[],"B":[],"C":[],"D":[],"E":[],"F":[],"G":[],"H":[],"I":[],"J":[],"K":[],"L":[],"M":[],"N":[],"O":[],"P":[],"Q":[],"R":[],"S":[],"T":[],"U":[],"V":[],"W":[],"X":[],"Y":[],"Z":[]]
                            for contactNode in ViewController.contactList{
                                sectionDictionary[String(contactNode.firstName.prefix(1))]?.append(contactNode.firstName + " " + contactNode.lastName)
                            }
                            tabView.deleteRows(at:[indexPath],
                                               with: .fade)
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "DISPLAY", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Display Action")
            success(true)
        })
        modifyAction.image = UIImage(named: "hammer")
        modifyAction.backgroundColor = .blue
        
        if let cell = tabView.cellForRow(at: indexPath){
            if let str = cell.textLabel?.text{
                for contactNode in ViewController.contactList{
                    if String(contactNode.firstName+" "+contactNode.lastName) == str{
                        ViewController.displayContact.firstName = contactNode.firstName
                        ViewController.displayContact.lastName = contactNode.lastName
                        ViewController.displayContact.companyName = contactNode.companyName
                        ViewController.displayContact.phoneNumbers = contactNode.phoneNumbers
                        ViewController.displayContact.emailIds = contactNode.emailIds
                        print(ViewController.displayContact.phoneNumbers.count)
                        print(contactNode.phoneNumbers)
                        let addContactViewControlle = storyboard?.instantiateViewController(withIdentifier: "DisplayContact") as? DisplayContact
                    self.navigationController?.pushViewController(addContactViewControlle!, animated: true)
                    }
                }
            }
        }
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                if let cell = tabView.cellForRow(at: indexPath as IndexPath){
                    if let str = cell.textLabel?.text{
                        ViewController.editContactReference = str
                    }
                }
    }
    
    static var editContactReference:String = ""
    
    static var changeLabel:String = ""
    
    static var saveRow:IndexPath?
    
    static var displayContact:Contact = Contact()
    
    static var contactList:[Contact] = []
    
    static var pickerData:[String] = ["Home","Work","iPhone","Mobile","Main","Home Fax","Work Fax","Other"]
    
    static var emailPickerData:[String] = ["Home","Work","Personal","Other"]
    static var changeEmailLabel:String = ""
    
    static var editOption:Bool = false
    
    
    static var emailTypes:[String] = []
    
    static var phoneTypes:[String] = []

    @IBOutlet weak var tabView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sortAllValues()
         tabView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func sortAllValues() -> Void{
        
        for key in sectionTitles{
            let str:[String] = sectionDictionary[key]!
            sectionDictionary[key] = nil
            sectionDictionary[key] = str.sorted(by: >)
            print(str.sorted())
        }
        tabView.reloadData()
    }

    @IBAction func addContact(_ sender: Any) {
        let addContactViewControlle = storyboard?.instantiateViewController(withIdentifier: "ContactController") as? ContactController
        self.navigationController?.pushViewController(addContactViewControlle!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(ViewController.contactList.count)
        ViewController.editOption = false
        ViewController.emailTypes.removeAll()
        ViewController.phoneTypes.removeAll()
        
        sectionDictionary = ["A":[],"B":[],"C":[],"D":[],"E":[],"F":[],"G":[],"H":[],"I":[],"J":[],"K":[],"L":[],"M":[],"N":[],"O":[],"P":[],"Q":[],"R":[],"S":[],"T":[],"U":[],"V":[],"W":[],"X":[],"Y":[],"Z":[]]
        for contactNode in ViewController.contactList{
            sectionDictionary[String(contactNode.firstName.prefix(1))]?.append(contactNode.firstName + " " + contactNode.lastName)
        }
        tabView.reloadData()
    }
    
    @IBAction func editContact(_ sender: Any) {
        for contactNode in ViewController.contactList{
            if String(contactNode.firstName+" "+contactNode.lastName) == ViewController.editContactReference{
                var i:Int = 0
                for node in contactNode.phoneNumbers{
                    ViewController.phoneTypes.append(node.type)
                    ContactController.phoneNumbers[i] = node.number
                    i+=1
                }
                i=0
                for node in contactNode.emailIds{
                    ViewController.emailTypes.append(node.type)
                    ContactController.emailIds[i] =  node.id
                    i+=1
                }
                ContactController.fname = contactNode.firstName
                ContactController.lname = contactNode.lastName
                ContactController.cname = contactNode.companyName
                ViewController.editOption = true
                let addContactViewControlle = storyboard?.instantiateViewController(withIdentifier: "ContactController") as? ContactController
                self.navigationController?.pushViewController(addContactViewControlle!, animated: true)
                
            }
        }
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

