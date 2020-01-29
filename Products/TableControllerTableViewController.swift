//
//  TableControllerTableViewController.swift
//  Products
//
//  Created by Ashish Samanta on 22/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class TableControllerTableViewController: UITableViewController {
    
    @IBOutlet var tabView: UITableView!
    
    var products:[NSManagedObject] = []
    let dispatchGroup = DispatchGroup()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.tableFooterView = UIView()
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Item")
        
        dispatchGroup.enter()
        
            DispatchQueue.global(qos: .background).async{[weak self] in
            guard let self = self else{
                return
            }
            do {

                self.products = try managedContext.fetch(fetchRequest)
                self.dispatchGroup.leave()
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        
        dispatchGroup.notify(queue: .main){
            self.tabView.reloadData()
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ViewController.finaltype = (products[indexPath.row].value(forKey: "type") as! String)
        ViewController.finalName = (products[indexPath.row].value(forKey: "name") as! String)
        ViewController.finalPrice = (products[indexPath.row].value(forKey: "price") as! Float)
        ViewController.finalQuantity = (products[indexPath.row].value(forKey: "quantity") as! Int)
        
        let addContactViewController = storyboard?.instantiateViewController(withIdentifier: "Item_DataViewController") as! Item_DataViewController
        self.navigationController?.pushViewController(addContactViewController, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let thisItem = products[indexPath.row]
        
        cell.textLabel?.text = (thisItem.value(forKeyPath: "name") as! String)
        
        return cell
    }
    

}
