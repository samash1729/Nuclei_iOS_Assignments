//
//  Course.swift
//  Question2
//
//  Created by Ashish Samanta on 13/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Course{
    
    private var num:Int = -1
    private static var maxset:Set<String> = ["A","B","C","D","E","F"]
    private var courseSet:Set<String> = Set<String>()

    
    func assign_course(_ num:Int) -> Void{
        courseSet.removeAll()
        self.num = num
        for counter in 1...num{
            while(true){
                print("Enter Subject Number "+String(counter))
                if let res = readLine(){
                    if(courseSet.contains(res))
                    {
                        print("String Already Present!Try Again")
                    }
                    else
                    {
                        if(Course.maxset.contains(res)){
                            print("Added")
                            courseSet.insert(res)
                            break
                        }
                        else{
                            print("Course Not Offered")
                        }
                    }
                }
                else
                {
                    print("No Value Entered")
                }
            }
        }
    }
    
    func printCourses() -> Void{
        for course in courseSet{
            print(course,separator: " ")
        }
    }
}
