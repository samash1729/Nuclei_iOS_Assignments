//
//  SortTypes.swift
//  Question2
//
//  Created by Ashish Samanta on 13/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class SortTypes{
    
    static func sortByName(_ dataStore: inout [Student],_ sortDirection:String) -> Void{
        
        if(sortByDirection=="1")
        {
            dataStore.sort{
                
                if $0.getName() == $1.getName(){
                    return $0.getRollNumber() > $1.getRollNumber()
                }
                else
                {
                    return $0.getName() > $1.getName()
                }
            }
        }
        else{
            dataStore.sort{
                
                if $0.getName() == $1.getName(){
                    return $0.getRollNumber() < $1.getRollNumber()
                }
                else
                {
                    return $0.getName() < $1.getName()
                }
            }
        }
    }
    
    static func sortByRollNumber(_ dataStore: inout [Student],_ sortDirection:String) -> Void{
        if(sortByDirection == "1"){
            dataStore.sort(by:{ $0.getRollNumber() > $1.getRollNumber() })
        }
        else{
            dataStore.sort(by:{ $0.getRollNumber() < $1.getRollNumber() })
        }
    }
    
    static func sortByAge(_ dataStore: inout [Student],_ sortDirection:String) -> Void{
        
        if(sortByDirection=="1")
        {
            dataStore.sort{
                
                if $0.getAge() == $1.getAge(){
                    return $0.getRollNumber() > $1.getRollNumber()
                }
                else
                {
                    return $0.getAge() > $1.getAge()
                }
            }
        }
        else{
            dataStore.sort{
                
                if $0.getAge() == $1.getAge(){
                    return $0.getRollNumber() < $1.getRollNumber()
                }
                else
                {
                    return $0.getAge() < $1.getAge()
                }
            }
        }
    }
}
