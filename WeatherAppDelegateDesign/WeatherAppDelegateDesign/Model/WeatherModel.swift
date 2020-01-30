//
//  WeatherModel.swift
//  WeatherAppDelegateDesign
//
//  Created by Ashish Samanta on 30/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

struct weatherDataModel{
    static var days:[String] = ["Thursday","Friday","Saturday","Sunday","Monday","Tuesday","Wednesday"]
    
    static var temp:[Float] = [-100,-100,-100,-100,-100,-100,-100]
}

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
