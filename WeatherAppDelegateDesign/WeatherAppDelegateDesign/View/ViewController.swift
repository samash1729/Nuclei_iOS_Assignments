//
//  ViewController.swift
//  WeatherAppDelegateDesign
//
//  Created by Ashish Samanta on 30/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherProtocol{
    

    @IBOutlet weak var tabView: UITableView!
    var w:Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        w = Weather()
        w?.delegate = self
        w?.weatherGetter()
    }
    
    func weatherApiHitDone(_ sender : Weather) {
        weatherDataModel.temp = sender.dataStore
        sleep(2)
        tabView.reloadData()
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataModel.temp.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = weatherDataModel.days[indexPath.row] + " - >  TEMP : " + String(weatherDataModel.temp[indexPath.row]) + " Celsius"
        return cell
    }
    
    
}

