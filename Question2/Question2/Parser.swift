//
//  Parser.swift
//  Question2
//
//  Created by Ashish Samanta on 13/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Parser{
    
    private static var rollNumber:Int = -1
    private static var addr:String = ""//,breakResponse:String = ""
    private static var name:String = ""
    private static var age:Int = -1
    private static var num:Int = -1
    
    static func parse(_ dict:[Int:Student]) -> Int{
        
        while(true){
            print("Enter Roll Number")
            if let request = readLine(){
                if Int(request) != nil{
                    rollNumber = Int(request)!
                    if(rollNumber<0)
                    {
                        print("Negative Roll Number!Try Again")
                    }
                    else if(dict.keys.contains(rollNumber)){
                        print("Roll Number Already Present!Try Again")
                    }
                    else{
                        print("Roll Number Set")
                        break
                    }
                    print("Enter 1 To Exit Input Process ?")
                    if let breakResponse = readLine(){
                        if breakResponse == "1"{
                            return -1
                        }
                    }
                }
                else{
                    print("Invalid Roll Number!Try Again")
                }
            }
            else
            {
                print("Roll Number Set to Nil")
            }
        }
        
        while(true){
            print("Enter Name")
            if let request = readLine(){
                name = request
                print("Name Set")
                break
            }
            else{
                print("Name Set to Nil")
            }
            print("Enter 1 To Exit Input Process ?")
            if let breakResponse = readLine(){
                if breakResponse == "1"{
                    return -1
                }
            }
        }
        
        while(true){
            print("Enter Age")
            if let request = readLine(){
                if Int(request) != nil{
                    age = Int(request)!
                    if(age<0 || age>25){
                        print("Age out of Bounds!Try Again")
                    }
                    else{
                        print("Age Set")
                        break
                    }
                    
                }
                else{
                    print("Couldnt Convert To Integer")
                }
            }
            else
            {
                print("Age Set to Nil!Try Again")
            }
            print("Enter 1 To Exit Input Process ?")
            if let breakResponse = readLine(){
                if breakResponse == "1"{
                    return -1
                }
            }
        }
        
        while(true){
            print("Enter Address")
            if let request = readLine(){
                addr = request
                print("Address Set")
                break
            }
            else{
                print("Address Set to Nil!Try Again")
            }
            print("Enter 1 To Exit Input Process ?")
            if let breakResponse = readLine(){
                if breakResponse == "1"{
                    return -1
                }
            }
        }
        
        while(true){
        
            print("Enter Number of Courses To be Taken")
            if let request = readLine(){
                if Int(request) != nil{
                        num = Int(request)!
                        if(num<4 || num>6)
                        {
                            print("Number Entered out of range")
                        }
                        else{
                            print("Number Set")
                            break
                        
                        }
                    }
                else{
                        print("Number Set to Nil")
                }
                print("Enter 1 To Exit Input Process ?")
                if let breakResponse = readLine(){
                    if breakResponse == "1"{
                        return -1
                    }
                }
            }
        
        }
        return 1
    }
    
    
    static func getName() -> String{
        return name
    }
    
    static func getRollNumber() -> Int{
        return rollNumber
    }
    
    static func getAddress() -> String{
        return addr
    }
    
    static func getAge() -> Int{
        return age
    }
    
    static func getNum() -> Int{
        return num
    }
}
