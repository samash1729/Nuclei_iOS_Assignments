//
//  main.swift
//  Question1
//
//  Created by Ashish Samanta on 11/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

var ans:Int = 1
var res:String = ""
var result:Int = -2
var dataStore = [item]()
while(ans != 3)
{
    print("Enter 1 to Insert Object")
    print("Enter 2 to Display All Objects")
    print("Enter 3 to Exit")
    if let request = readLine(){
        
        if Int(request) != nil{
            ans = Int(request)!
            switch ans{
                case 1 : print("Enter String Request")
                         res = readLine()!
                         result = parser.parse(res)
                         if(result == -1){
                            print("Error Parsing String.Try Again!")
                         }
                         else{
                             switch parser.getType(){
                             case itemTypes.Raw : dataStore.append(Raw(name: parser.getName(), type: parser.getType(), quantity: parser.getQuantity(), price: parser.getPrice()))
                             case itemTypes.Manufactured : dataStore.append(Manufactured(name: parser.getName(), type: parser.getType(), quantity: parser.getQuantity(), price: parser.getPrice()))
                             case itemTypes.Imported : dataStore.append(Imported(name: parser.getName(), type: parser.getType(), quantity: parser.getQuantity(), price: parser.getPrice()))
                            }
                         }
            case 2 :    print("PRINTING")
                        for item in dataStore{
                            print("************************************************")
                            print("NAME : "+item.getName())
                            print("TYPE : "+item.getType())
                            print("PRICE PER : "+String(item.getPrice()))
                            print("QUANTITY : "+String(item.getQuantity()))
                            print("SALES TAX : "+String(item.getSalesTax()))
                            print("FINAL PRICE : "+String(item.getFinalTax()))
                            print("*************************************************")
                        }
            case 3 : print("Terminating")
                
            default : print("Invalid Entry")
            }
        }
        else{
            print("Request Entered Invalid")
        }
        
    }
    else{
        print("String Request Empty")
    }
}
