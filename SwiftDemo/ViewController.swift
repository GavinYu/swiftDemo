//
//  ViewController.swift
//  SwiftDemo
//
//  Created by yek on 15/10/16.
//  Copyright © 2015年 Jenny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //控制流
        var optionalString: String? = "hello"
        optionalString == nil
        var optionalName: String? = nil
        var greeting = "hello!"
        if let name = optionalName {
            greeting = "hello, \(name)"
        }
        
        print(optionalString,optionalName,greeting)
        
        let value = "red pepper"
        switch value {
        case "celery":
            print("celery")
        case "cucumber", "watercress":
            print("cucumber,watercress")
        case let x where x.hasSuffix("pepper"):
            print("it is a spicy \(x)")
        default:
            print("it is default")
        }
        
        //函数和闭包
        //函数
        func sumof(numbers:Int...) -> Int {
            var sum = 0
            for number in numbers{
                sum += number
            }
            
            return sum/numbers.count
        }
        
        
        print(sumof(1,3,5,7,9))
        
        //闭包
        var names = ["Swift", "Arial", "Soga", "Donary"]
        func backwards(firstString: String, secondString: String) -> Bool {
            return firstString > secondString // 升序排序
        }
        
        var reversed = sort(names, backwards)
        
        var reversed = sort({ (firstString: String, secondString: String) -> Bool in
            return firstString > secondString
        })
        print(reversed)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

