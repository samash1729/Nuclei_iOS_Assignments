//
//  parser.swift
//  Question1
//
//  Created by Ashish Samanta on 12/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class parser{
    

    private static var name:String = "",type:itemTypes = itemTypes.Raw
    private static var quantity:Int = 0
    private static var price:Double = 0.0

    private static var namePos:Int = -1,typePos:Int = -1,quantityPos:Int = -1,pricePos:Int = -1

    static func extract(_ item:[Character],_ pos:Int)->String
    {
        var char_parser:Int = pos
    
        var result:String = ""
        while(item[char_parser] != "-" && item[char_parser] != "$")
        {
            result += String(item[char_parser])
            char_parser += 1
        }
        return result.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }

    static func set_positions( _ item : [Character] ) -> Int
    {
        typePos = -1
        namePos = -1
        quantityPos = -1
        pricePos = -1
        for (index,value) in item.enumerated() {
            if(value == "-")
            {
                switch item [ index + 1 ] {
                case "n" :  namePos = index + 5
                case "t" :  typePos = index + 5
                case "p" : pricePos = index + 6
                case "q" : quantityPos = index + 9
                default : return -1
                }
            }
        }
        if(typePos == -1)
        {
            return -1
        }
        return 1
    }

    static func parse(_ request:String) -> Int{
    
        var item = request.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        item += "$"
    
        let char_item:[Character] = Array(item)
    
        if(set_positions(char_item)==1)
        {
            if(namePos == -1)
            {
                name = "NA"
                print("Name Not Provided")
            }
            else
            {
                name = extract(char_item,namePos)
                if(name=="")
                {
                    print("Name field Empty")
                    return -1
                }
            }
        
            if(typePos == -1)
            {
                print("Cant Go Ahead With Program")
                return -1
            }
            else{
                let temp:String = extract(char_item,typePos)
                if(!(temp=="Raw" || temp=="Manufactured" || temp=="Imported"))
                {
                    print("TYPE : "+temp+" "+String(typePos))
                    print("Type Not of any appropriate category")
                    return -1
                }
                switch temp{
                    case "Raw" : type = itemTypes.Raw
                    case "Manufactured" : type = itemTypes.Manufactured
                    case "Imported" : type = itemTypes.Imported
                    default : print("Should Ever Happen")
                }
            }
        
            if(quantityPos == -1)
            {
                quantity = 0
                print("Quantity Not Provided")
            }
            else{
            
                if let num_int = Int(extract(char_item,quantityPos))
                {
                    if(num_int<0)
                    {
                        print("Quantity Negative")
                        return -1
                    }
                    quantity = num_int
                }
                else{
                    print("Problem Converting to Integer")
                    return -1
                }
            }
        
        
            if(pricePos == -1)
            {
                price = 0.0
                print("Price Not Provided")
            }
            else
            {
                if let num = Double(extract(char_item, pricePos))
                {
                    if(num<0)
                    {
                        print("Price Negative")
                        return -1
                    }
                    price = num
                }
                else{
                    print("Problem Converting to Double")
                    return -1
                }
            }
            return 1
        }
        else{
            print("Problems with input Try Again!")
        }
        return -1
}
    
    static func getType()->itemTypes{
        return type
    }
    
    static func getPrice()->Double{
        return price
    }
    
    static func getName()->String{
        return name
    }
    
    static func getQuantity()->Int{
        return quantity
    }

}
