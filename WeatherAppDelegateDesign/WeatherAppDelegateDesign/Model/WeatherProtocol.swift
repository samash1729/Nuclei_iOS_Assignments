//
//  WeatherProtocol.swift
//  WeatherAppDelegateDesign
//
//  Created by Ashish Samanta on 30/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

protocol WeatherProtocol : class{
    func weatherApiHitDone(_ sender: Weather) -> Void 
}
