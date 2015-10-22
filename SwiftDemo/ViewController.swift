//
//  ViewController.swift
//  SwiftDemo
//
//  Created by yek on 15/10/16.
//  Copyright © 2015年 Jenny. All rights reserved.
//

import UIKit

//对象和类
class Person {
    var name: String = ""
    var age: Int = 1
    
    init(name:String){
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with name:\(self.name),age: \(age)"
    }
}

//计算属性
struct Point { //原点
    var x = 0.0, y = 0.0
}

struct Size { //大小
    var width = 0.0, height = 0.0
}

struct Rect {//中心点
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            let centerX = origin.x + size.width/2
            let centerY = origin.y + size.height/2
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter){
            origin.x = newCenter.x - size.width/2
            origin.y = newCenter.y - size.height/2
        }
    }
    
}

class ViewController: UIViewController {
    //枚举和结构体
    enum Rank: Int{
        case Ace = 1
        case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King
        
        func get_name() -> String{
            switch self {
            case .Ace:
                return "ace"
                
            case .Jack:
                return "jack"
                
            case .Queen:
                return "queen"
                
            case .King:
                return "king"
                
            default:
                return "defaultValue"
            }
        }
        
    }
    
    //类型属性
    struct AudioChannel {
        static let thresholdLevel = 10
        static var maxInputLevelForAllChannel = 0
        var currentLevel: Int = 0 {
            didSet{
                if currentLevel > AudioChannel.thresholdLevel {
                    currentLevel = AudioChannel.thresholdLevel //将新电平值设置为上限阀值
                }
                
                if currentLevel > AudioChannel.maxInputLevelForAllChannel {
                    AudioChannel.maxInputLevelForAllChannel = currentLevel //存储当前电平值作为新的最大输入电平
                }
            }
        }
    }
    
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
        var names = ["Swift", "Arial", "Soga", "Donary"];
        names.sortInPlace();
        let results = names.sort({(firstString:String,secondString:String) -> Bool in return firstString>secondString})
        let sortResult = names.sort(<)
        print("排序后：\(names),\(results),\(sortResult)")
        
        
        let myPerson = Person(name: "Gavin")
        print("age is: \(myPerson.simpleDescription())")
        
        //枚举
        let ace = Rank.King
        print("枚举：\(ace.get_name()), \(Rank.Eight)")
        
        //元组
        let http404Error = (404, "Not Found")
        let (statusCode, statusMessage) = http404Error
        print("The status code is \(statusCode), the status message is \(statusMessage)")
        
        //可选和隐式解析可选的区别
        let possibleString: String? = "A optional string"
        print(possibleString!)
        let assumedString: String! = "A implicitly unwrapped optional string"
        print(assumedString)
        
        var emptyArray = [Int]()
        //字典
        var emptyDictionary = Dictionary<String,Float>()
        emptyArray = [1,3,5,9]
        emptyDictionary = ["first":5.8, "second":6.8]
        
        var firstForLoop = 0
        for i in 0...3{
            firstForLoop += i
        }
        
        var secondForLoop = 0
        let arrayCount = emptyArray.count
        for j in 0..<arrayCount {
            secondForLoop += emptyArray[j]
        }
        
        print("firstForLoop值：\(firstForLoop) secondeForLoop值：\(secondForLoop)")
        
        //数组的遍历
        for (index, value) in names.enumerate() {
            print("Item \(index+1): \(value)")
        }
        
        let deviceMac = UIDevice.currentDevice().identifierForVendor?.UUIDString
        print("设备的MAC: \(deviceMac)")
        
        let count = 3_000_000_000_000
        let countedThings = "stars in the Milky Way"
        var naturalCount: String
        switch count {
        case 0:
            naturalCount = "no of"
        case 1...3:
            naturalCount = "a few"
        case 4...9:
            naturalCount = "several"
        case 10...99:
            naturalCount = "tens of"
        case 100...999:
            naturalCount = "hundreds of"
        case 1000...999_999:
            naturalCount = "thousands of"
        default:
            naturalCount = "millions and millions of"
        }
        
        print("There are \(naturalCount) \(countedThings).")
        
        let somePoint = (0, 0)
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
            fallthrough
        case (_, 0):
            print("(somePoint.0), 0) is on the x-axis")
            
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
            
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
                
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
        
        var someInt = 8
        var otherInt = 29
        swapTwoValue(&someInt, second: &otherInt)
         print("交换后：first值为：\(someInt),second值为：\(otherInt)")
        
        let containsAVee = containsCharacter("asdfghjkl", charToFind: "k")
        if containsAVee == true {
            print("it is have \"k\" ")
        }
        
        var currentValue = -4
        let mvoeNearerToZero = chooseStepFunction(currentValue>0)
        while currentValue != 0 {
            print("\(currentValue)")
            currentValue = mvoeNearerToZero(currentValue)
        }
        print("zero!")
        
        traillingFunction()
        
        //捕获
        let incrementByTen = makeIncrementor(forIncrement: 10)
        let alsoIncrementByTen = incrementByTen
        print("捕获的结果是：\(incrementByTen()), \(alsoIncrementByTen())")
        
        //计算属性
        var square = Rect (origin: Point(x: 0.0, y: 0.0), size:Size(width: 10.0, height: 10.0))
        square.center = Point(x: 15.0, y: 15.0)
        print("新的原点是：\(square.origin)")
        
        //类型属性
        var leftChannel = AudioChannel()
        var rightChannel = AudioChannel()
        
        leftChannel.currentLevel = 8
        rightChannel.currentLevel = 12
        print("左声道：\(leftChannel.currentLevel),\(AudioChannel.maxInputLevelForAllChannel), 右声道：\(rightChannel.currentLevel),\(AudioChannel.maxInputLevelForAllChannel)")
        
        //变异
        var somePoints = Points(x: 2.0, y: 2.0)
        somePoints.moveByX(2.0, y: 2.0)
        print("变异后的坐标：\(somePoints.x),\(somePoints.y)")
        
        //附属脚本（只读）
        let threeTimesTable = TimesTable(multiplier: 3)
        print("3的8倍是：\(threeTimesTable[8])")
        
    }
    
    //inout形参
    func swapTwoValue(inout first:Int, inout second:Int){
        let temp = first
        first = second
        second = temp
    }
    
    //外部形参
    func containsCharacter(sourceString:String, charToFind:Character) -> Bool {
        for char in sourceString.characters{
            if char == charToFind {
                return true
            }
        }
        
        return false
    }
    
    //嵌套函数
    func chooseStepFunction(backwards:Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        
        return backwards ? stepBackward : stepForward
    }
    
    //Trailling 闭包
    func traillingFunction(){
        let digitNames = [0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",5:"Five",6:"Six",7:"Seven",8:"Eight",9:"Nine"]
        let numbers = [16, 58, 510]
        
        let strings = numbers.map{
            (var number) -> String in
            var output = ""
            while number > 0 {
                output = digitNames[number%10]! + output
                number /= 10
            }
            
            return output
        }
        
        print("结果是：\(strings)")
    }
    
    //捕获
    func makeIncrementor(forIncrement amount:Int) -> () -> Int {
        var runningTotal = 0
        func incrementor() -> Int {
            runningTotal += amount
            return runningTotal
        }
        
        return incrementor
    }
    
    //变异
    struct Points {
        var x = 0.0, y = 0.0
        mutating func moveByX(deltaX:Double, y deltaY:Double) {
            x += deltaX
            y += deltaY
        }
    }
    
    //附属脚本（读写，只读）
    struct TimesTable {
        let multiplier: Int
        subscript(index: Int) -> Int {
            return multiplier * index //返回传入整数的N倍
        }
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    
}



