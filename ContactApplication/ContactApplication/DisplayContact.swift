//
//  DisplayContact.swift
//  ContactApplication
//
//  Created by Ashish Samanta on 27/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class DisplayContact: UIViewController{
    
    @IBOutlet weak var cname: UILabel!
    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var emailTable: UITableView!
    @IBOutlet weak var tabView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.dataSource = self
        tabView.delegate = self
        emailTable.dataSource = self
        emailTable.delegate = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        emailTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tabView.tableFooterView = UIView()
        emailTable.tableFooterView = UIView()
        fname.text = "FIRST NAME : " + ViewController.displayContact.firstName
        lname.text = "LAST NAME : " + ViewController.displayContact.lastName
        cname.text = "COMPANY NAME : " + ViewController.displayContact.companyName
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}


extension DisplayContact : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tabView{
            return ViewController.displayContact.phoneNumbers.count
        }
        if tableView == self.emailTable{
            return ViewController.displayContact.emailIds.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.emailTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
            cell.textLabel?.text = ViewController.displayContact.emailIds[indexPath.row].type+" : " + ViewController.displayContact.emailIds[indexPath.row].id
            return cell
            
        }
        if tableView == self.tabView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
            cell.textLabel?.text = ViewController.displayContact.phoneNumbers[indexPath.row].type+" : " + ViewController.displayContact.phoneNumbers[indexPath.row].number
            return cell
        }
        let cell = UITableViewCell.init()
        return cell
    }
    
}
