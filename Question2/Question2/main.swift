//
//  main.swift
//  Question2
//
//  Created by Ashish Samanta on 13/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation


var dataStore:[Student] = [Student]()
var ans:String = ""
var dict:[Int:Student] = [Int:Student]()

var sortByVariable:String = ""
var sortByDirection:String = ""
var rollNumberDelete:Int = -1

while(ans != "4"){
    print("Enter 1 to Add Student")
    print("Enter 2 to Display Data")
    print("Enter 3 to Delete Student")
    print("Enter 4 to Exit")
    
    if let request = readLine(){
        ans = request
        switch ans{
        case "1" : if(Parser.parse(dict) == 1){
                    let stud:Student = Student(rollNumber: Parser.getRollNumber(), name: Parser.getName(), addr: Parser.getAddress(), age: Parser.getAge(), numCourse: Parser.getNum())
                    dataStore.append(stud)
                    dict[Parser.getRollNumber()] = stud
                    print("Inserted")
                    }
                    else{
                        print("Problem in Input Process")
                    }
        case "2" :  print("Enter 1 To Sort By Name")
                    print("Enter 2 To Sort By Age")
                    print("Enter 3 To Sort By Roll Number")
                    if let sortRes = readLine(){
                        sortByVariable = sortRes
                        print("Enter 1 To Sort By Descending Order")
                        if let directionRes = readLine(){
                            sortByDirection = directionRes
                        }
                        switch sortByVariable{
                        
                        case "1" : SortTypes.sortByName(&dataStore, sortByDirection)
                        case "2" : SortTypes.sortByAge(&dataStore, sortByDirection)
                        case "3" : SortTypes.sortByRollNumber(&dataStore, sortByDirection)
                        default : print("Invalid Sort by Entry")
                    }
                }
                for student in dataStore{
                    print(student.getName(),String(student.getAge()),String(student.getRollNumber()),student.getAddress())
                    student.printCourses()
                }
        case "3" : print("Enter Roll Number To Be Deleted")
                   if let res = readLine(){
                        if Int(res) != nil{
                            rollNumberDelete = Int(res)!
                            if(dict.keys.contains(rollNumberDelete)){
                                let referenceVariable:Student = dict[rollNumberDelete]!
                                dataStore = dataStore.filter({$0 !== referenceVariable})
                                print("Deleted")
                            }
                            else{
                                print("Roll Number Not Present in Database")
                            }
                        }
                        else
                        {
                            print("Couldnt Convert String to Int")
                        }
                    }
        default : break;
        }
    }
    else{
        print("Value Set to Nil")
    }
}
print("Terminating")

