//
//  Student.swift
//  Question2
//
//  Created by Ashish Samanta on 13/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Student{
    
    private var rollNumber:Int = -1
    private var name:String = ""
    private var addr:String = ""
    private var age:Int = -1
    private var course:Course = Course()
    
    init(rollNumber:Int,name:String,addr:String,age:Int,numCourse:Int){
        self.rollNumber = rollNumber
        self.name = name
        self.addr = addr
        self.age = age
        course.assign_course(numCourse)
    }
    
    func getName() -> String{
        return name
    }
    
    func printCourses() -> Void{
        course.printCourses()
    }
    
    func getRollNumber() -> Int{
        return rollNumber
    }
    
    func getAddress() -> String{
        return addr
    }
    
    func getAge() -> Int{
        return age
    }
}
