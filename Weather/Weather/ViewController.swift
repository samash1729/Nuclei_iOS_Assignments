//
//  ViewController.swift
//  Weather
//
//  Created by Ashish Samanta on 29/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tabView: UITableView!
    
    let dispatchGroup = DispatchGroup()
    let w:WeatherGetter = WeatherGetter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }

    func dataLoad(){
        tabView.reloadData()
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.temperatures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataModel.days[indexPath.row] + " - >  TEMP : " + String(dataModel.temperatures[indexPath.row]) + " Celsius"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
