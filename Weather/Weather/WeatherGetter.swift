//
//  WeatherGetter.swift
//  Weather
//
//  Created by Ashish Samanta on 29/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation
import UIKit


struct weatherData : Codable{
    var cod : String
    var message : Int
    var cnt : Int
    var list : [list]
}

struct list : Codable{
    var dt : Int32
    var main : [String:Float]
}

class WeatherGetter {
    
    private let openWeatherMapBaseURL = "api.openweathermap.org/data/2.5/forecast?id=1261481&cnt=7"
    private let openWeatherMapAPIKey = "e2cae925022077c632b8530641ffc98f"
    
    func getWeather(_ vc:ViewController){
        
        let weatherRequestURL = URL(string:"http://api.openweathermap.org/data/2.5/forecast?id=1261481&cnt=7&APPID=e2cae925022077c632b8530641ffc98f")!
        
        let task = URLSession.shared.dataTask(with: weatherRequestURL) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let user:weatherData = try! JSONDecoder().decode(weatherData.self, from: data)
//            print(user.list[0].main["temp"])

            var day = 0

            while day<7{
                dataModel.temperatures.append(user.list[day].main["temp"]!)
                day += 1
            }
            DispatchQueue.main.async {
                vc.dataLoad()
            }
        }
        task.resume()
    }
}
