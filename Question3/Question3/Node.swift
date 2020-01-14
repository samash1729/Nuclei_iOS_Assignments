//
//  Node.swift
//  Question3
//
//  Created by Ashish Samanta on 14/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Node{
    
    static var dict:[Int:Node] = [Int:Node]()
    static var root = Set<Int>()
    
    var frontNodes:[Int] = [Int]()
    var backNodes:[Int] = [Int]()
    var name:String = ""
    var nodeId:Int = -1
    
    init(_ nodeId:Int,_ name:String){
        self.name = name
        self.nodeId = nodeId
    }
}
