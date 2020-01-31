//
//  ViewController.swift
//  WeatherAppObserverDesign
//
//  Created by Ashish Samanta on 31/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabView: UITableView!
    let val:Weather = Weather()
    let w:Weather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.dataSource = self
        tabView.delegate = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishLoading), name: Notification.Name(rawValue: "com.WeatherAppObserverDesign.tableLoadNotificationID"), object: val )
        val.weatherGetter()
    }

    @objc func didFinishLoading(){
        weatherDataModel.temp = val.dataStore
        sleep(1)
        tabView.reloadData()
    }

}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataModel.temp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = weatherDataModel.days[indexPath.row] + " - >  TEMP : " + String(weatherDataModel.temp[indexPath.row]) + " Celsius"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
