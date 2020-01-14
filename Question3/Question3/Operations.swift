//
//  Operations.swift
//  Question3
//
//  Created by Ashish Samanta on 14/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Operations{
    
    var pname:String = ""
    var cname:String = ""
    var cycleCheck:CycleCheck = CycleCheck()
    
    func add(_ pid:Int,_ cid:Int) ->Int{
        
        if !Node.dict.keys.contains(pid) && !Node.dict.keys.contains(cid){
            print("Enter Parent Name")
            if let res = readLine(){
                pname = res
            }
            else{
                print("Value Entered Set To Nil!Try Again")
                return 0
            }
            print("Enter Child Name")
            if let res = readLine(){
                cname = res
            }
            else{
                print("Value Entered Set to Nil")
            }
            let pnode:Node = Node(pid, pname)
            let cnode:Node = Node(cid,cname)
            pnode.frontNodes.append(cid)
            cnode.backNodes.append(pid)
            Node.dict[pnode.nodeId] = pnode
            Node.dict[cnode.nodeId] = cnode
            Node.root.insert(pid)
            return 1
        }
        else if Node.dict.keys.contains(pid) && !Node.dict.keys.contains(cid){
            print("Enter Child Name")
            if let res = readLine(){
                cname = res
                let cnode:Node = Node(cid,cname)
                let pnode:Node = Node.dict[pid]!
                pnode.frontNodes.append(cid)
                cnode.backNodes.append(pid)
                Node.dict[cid] = cnode
                return 1
            }
            else{
                print("Value Set To Nil")
            }
        }
        else if !Node.dict.keys.contains(pid) && Node.dict.keys.contains(cid){
            print("Enter Parent Name")
            if let res = readLine(){
                pname = res
                let pnode = Node(pid,pname)
                let cnode = Node.dict[cid]!
                pnode.frontNodes.append(cid)
                cnode.backNodes.append(pid)
                Node.root.insert(pid)
                Node.dict[pid] = pnode
                if(Node.root.contains(cid)){
                    Node.root.remove(cid)
                }
                return 1
            }
        }
        else{
            if((Node.dict[pid]!).frontNodes.contains(cid) && (Node.dict[cid]!).backNodes.contains(pid))
            {
                print("Link Already Present")
            }
            else
            {
                if(cycleCheck.checkCycle(pid,cid)==1){
                    (Node.dict[pid]!).frontNodes.append(cid)
                    (Node.dict[cid]!).backNodes.append(pid)
                    return 1
                }
                else{
                    print("This Can Create A Cycle! Request Rejected.")
                }
            }
        }
    return 0
    }
    
    func getImmediateChildren(_ nodeId:Int) -> Void{
        if(Node.dict.keys.contains(nodeId)){
            let temp = Node.dict[nodeId]!
            if(temp.frontNodes.count>0){
                print("Printing Children")
                for node in temp.frontNodes{
                    print((Node.dict[node]!).name,(Node.dict[node]!).nodeId)
                }
            }
            else{
                print("No Children Present")
            }
        }
        else{
            print("Node Not Present in Graph")
        }
    }
    
    func getImmediateParents(_ nodeId:Int) -> Void{
        if(Node.dict.keys.contains(nodeId)){
            let temp = Node.dict[nodeId]!
            if(temp.backNodes.count>0){
                print("Printing Parents")
                for node in temp.backNodes{
                    print((Node.dict[node]!).name,(Node.dict[node]!).nodeId)
                }
            }
            else{
                print("No Parents Present")
            }
        }
        else{
            print("Node Not Present in Graph")
        }
    }

    private func findAllDescendants(_ nodeId:Int){
        let temp = Node.dict[nodeId]!
        print(temp.name,temp.nodeId)
        for node in temp.frontNodes{
            findAllDescendants(node)
        }
    }
    
    func getDescendants(_ nodeId:Int){
        if(Node.dict.keys.contains(nodeId)){
            let temp = Node.dict[nodeId]!
            if(temp.frontNodes.count>0)
            {
                print("Printing Descendants")
                for node in temp.frontNodes{
                    findAllDescendants(node)
                }
            }
            else{
                print("No Children Present")
            }
        }
        else{
            print("Node Not Present in Graph")
        }
    }
    
    private func findAllAncestors(_ nodeId:Int)->Void{
        let temp = Node.dict[nodeId]!
        print(temp.name,temp.nodeId)
        for node in temp.backNodes{
            findAllAncestors(node)
        }
    }
    
    func getAncestors(_ nodeId:Int){
        if(Node.dict.keys.contains(nodeId)){
            let temp = Node.dict[nodeId]!
            if(temp.backNodes.count>0){
                print("Printing Ancestors")
                for node in temp.backNodes{
                    findAllAncestors(node)
                }
            }
            else{
                print("No Parent Present")
            }
        }
        else{
            print("Node Not Present in Graph")
        }
    }
    
    func addSingleNode(_ nodeId:Int) -> Void{
        if(Node.dict.keys.contains(nodeId)){
            print("Node Already Present in Graph")
        }
        else{
            print("Enter Node Name")
            if let res = readLine(){
                pname = res
                let pnode = Node(nodeId,pname)
                Node.root.insert(nodeId)
                Node.dict[nodeId] = pnode
                print("Added")
            }
            else{
                print("Value Set To Nil(Single Node Case)")
            }
        }
    }
    
    func deleteNode(_ nodeId:Int) -> Void{
        let temp = Node.dict[nodeId]!
        for node in temp.frontNodes{
            deleteNode(node)
        }
        temp.frontNodes.removeAll()
        temp.backNodes.removeAll()
        
        Node.dict.removeValue(forKey: temp.nodeId)
    }
    
    func deleteDependency(_ pid:Int,_ cid:Int) -> Void{
        if(!Node.dict.keys.contains(pid) || !Node.dict.keys.contains(cid)){
            print("Any One Of The Nodes Not Present")
            return
        }
        let pnode:Node = Node.dict[pid]!
        let cnode:Node = Node.dict[cid]!
        
        if(pnode.frontNodes.contains(cid) && cnode.backNodes.contains(pid)){
            
        }
        else if pnode.backNodes.contains(cid) && cnode.frontNodes.contains(pid){
            pnode.backNodes.removeAll{$0 == cid}
            cnode.frontNodes.removeAll{$0 == pid}
            pnode.frontNodes.append(cid)
            cnode.backNodes.append(pid)
        }
        else
        {
            print("Link Not Proper!")
            return
        }
        
        if pnode.backNodes.count == 0{
            if pnode.frontNodes.count == 1{
                deleteNode(pid)
            }
            else{
                pnode.frontNodes.removeAll{ $0 == cid}
                deleteNode(cid)
            }
        }
        else{
            if pnode.frontNodes.count == 1{
                for node in pnode.backNodes{
                    ((Node.dict[node])!).frontNodes.removeAll{ $0 == pid}
                }
                deleteNode(pid)
            }
            else{
                pnode.frontNodes.removeAll{ $0 == cid}
                deleteNode(cid)
            }
        }
        print("Deleted")
    }
}
