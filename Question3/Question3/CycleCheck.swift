//
//  CycleCheck.swift
//  Question3
//
//  Created by Ashish Samanta on 14/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class CycleCheck{
    
    var frontParentIDs = Set<Int>()
    var backParentIDs = Set<Int>()
    var found:Bool = false
    
    
    func checkCycle(_ parentId:Int,_ childId:Int) -> Int{
        
        frontParentIDs.removeAll()
        backParentIDs.removeAll()
        getAncestors(parentId, 1)
        found = false
        getAncestors(cid, 2)
        if(found==true || backParentIDs.contains(parentId) || backParentIDs.contains(childId)){
            return -1
        }
        getDescendants(parentId, 1)
        getDescendants(childId, 2)
        if(found==true || frontParentIDs.contains(parentId) || frontParentIDs.contains(childId)){
            return -1
        }
        return 1
    }
    

    func findAllAncestors(_ node:Int,_ request:Int){
        if request == 1{
            backParentIDs.insert(node)
        }
        else{
            if(backParentIDs.contains(node)){
                found = true
                return
            }
        }
        for eachNode in (Node.dict[node]!).backNodes{
            findAllAncestors(eachNode, request)
        }
    }
    
    func getAncestors(_ node:Int,_ request:Int){
        for eachNode in (Node.dict[node]!).backNodes{
            findAllAncestors(eachNode, request)
        }
    }
    
    func findAllDescendants(_ node:Int,_ request:Int){
        if request == 1{
            frontParentIDs.insert(node)
        }
        else{
            if(frontParentIDs.contains(node)){
                found = true
                return
            }
        }
        for eachNode in (Node.dict[node]!).frontNodes{
            findAllDescendants(eachNode, request)
        }
    }
    
    func getDescendants(_ node:Int,_ request:Int){
        for eachNode in (Node.dict[node]!).frontNodes{
            findAllDescendants(eachNode, request)
        }
    }
}
