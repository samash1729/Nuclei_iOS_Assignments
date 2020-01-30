//
//  Weather.swift
//  WeatherAppDelegateDesign
//
//  Created by Ashish Samanta on 30/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Weather{
    
    var dataStore:[Float] = []
    weak var  delegate:WeatherProtocol?
    
    func weatherGetter(){
        let weatherRequestURL = URL(string:"http://api.openweathermap.org/data/2.5/forecast?id=1261481&cnt=7&APPID=e2cae925022077c632b8530641ffc98f")!
        
        let task = URLSession.shared.dataTask(with: weatherRequestURL) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let user:weatherData = try! JSONDecoder().decode(weatherData.self, from: data)
            var day = 0
            
            while day<7{
                self.dataStore.append(user.list[day].main["temp"]! - 275)
                day += 1
            }
            DispatchQueue.main.async {
                self.callController()
            }
        }
        task.resume()
    }
    
    func callController(){
        delegate?.weatherApiHitDone(self)
    }
    
}
