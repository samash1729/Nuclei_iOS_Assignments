//
//  main.swift
//  Question3
//
//  Created by Ashish Samanta on 14/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

var ans:String = ""
let graphOperator:Operations = Operations()
var pid:Int = -1,cid:Int = -1,nodeId:Int = -1

while(ans != "9"){
    print("Enter 1 To Add Dependency")
    print("Enter 2 To Get Immediate Children")
    print("Enter 3 To Get Immediate Parents")
    print("Enter 4 To Get Ancestors")
    print("Enter 5 To Get Descendants")
    print("Enter 6 To Add a New Node")
    print("Enter 7 To Delete a Node")
    print("Enter 8 To Delete Dependency")
    print("Enter 9 To Exit")
    if let res = readLine(){
        ans = res
        switch ans{
            case "1" :  print("Enter Parent ID")
                        if let res = Int(readLine()!){
                            pid = res
                        }
                        else{
                            print("Couldnt Convert To Integer")
                            break
                        }
                        print("Enter Child ID")
                        if let res = Int(readLine()!){
                            cid = res
                        }
                        else{
                            print("Couldnt Convert To Integer")
                            break
                        }
                        if(graphOperator.add(pid,cid)==1){
                            print("Added")
                        }
                        else{
                            print("Problem Inserting Dependency")
                        }
            case "2" :  print("Enter Node ID")
                        if let res = Int(readLine()!){
                            nodeId = res
                            graphOperator.getImmediateChildren(nodeId)
                        }
                        else{
                            print("Problem Converting To Integer")
                        }
            case "3" :  print("Enter Node ID")
                        if let res = Int(readLine()!){
                            nodeId = res
                            graphOperator.getImmediateParents(nodeId)
                        }
                        else{
                            print("Problem Converting To Integer")
                        }
            case "4" : print("Enter Node ID")
                       if let res = Int(readLine()!){
                            nodeId = res
                            graphOperator.getAncestors(nodeId)
                       }
                       else{
                            print("Problem Converting To Integer")
                       }
            case "5" : print("Enter Node ID")
                       if let res = Int(readLine()!){
                            nodeId = res
                            graphOperator.getDescendants(nodeId)
                       }
                       else{
                            print("Problem Converting To Integer")
                        }
            case "6" : print("Enter Node ID")
                       if let res = Int(readLine()!){
                            nodeId = res
                            graphOperator.addSingleNode(nodeId)
                       }
            case "7" : print("Enter Node ID")
                       if let res = Int(readLine()!){
                            nodeId = res
                            if Node.dict.keys.contains(nodeId) {
                                
                                let temp:Node = Node.dict[nodeId]!
                                if temp.backNodes.count == 0 {
                                    graphOperator.deleteNode(nodeId)
                                }
                                else if temp.frontNodes.count == 0{
                                    for node in temp.backNodes{
                                        (Node.dict[node]!).frontNodes.removeAll{$0 == nodeId}
                                    }
                                    temp.backNodes.removeAll()
                                    temp.frontNodes.removeAll()
                                    Node.dict.removeValue(forKey: nodeId)
                                    if(Node.root.contains(nodeId))
                                    {
                                        Node.root.remove(nodeId)
                                    }
                                }
                                else
                                {
                                    for node in temp.backNodes{
                                        (Node.dict[node]!).frontNodes.removeAll{$0 == nodeId}
                                    }
                                    if(Node.root.contains(nodeId))
                                    {
                                        Node.root.remove(nodeId)
                                    }
                                    graphOperator.deleteNode(nodeId)
                                }
                                
                            }
                            else{
                                print("Node Not Present In Graph")
                            }
                        }
                       else{
                            print("Problem Converting To Integer")
                        }
        case "8" :      print("Enter Parent ID")
                        if let res = Int(readLine()!){
                            pid = res
                        }
                        else{
                            print("Could Not Convert To Integer")
                            break
                        }
                        print("Enter Child ID")
                        if let res = Int(readLine()!){
                            cid = res
                        }
                        else{
                            print("Couldnt Convert To Integer")
                            break;
                        }
                        graphOperator.deleteDependency(pid, cid)
        case "9" :      break;
         default :      print("Invalid Entry")
        }
    }
    else{
        print("Value Entered Set To Nil")
    }
}
print("Terminating")


