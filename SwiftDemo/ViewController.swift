//
//  ViewController.swift
//  SwiftDemo
//
//  Created by yek on 15/10/16.
//  Copyright © 2015年 Jenny. All rights reserved.
//

import UIKit

//运算符函数
struct Vector2D {
    var x = 0.0, y = 0.0
}

func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}
//组合赋值运算符
func += (inout left: Vector2D, right: Vector2D) {
    left = left + right
}
//比较运算符
func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x && left.y == right.y)
}

func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}

//自定义运算符
prefix operator +++ {}
prefix func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}

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

//扩展
extension Double { //扩展计算型属性
    var km: Double { return self * 1_000.0 }
    var  m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

extension Rect { //扩展构造器
    init(center: Point, size: Size) {
        let originX = center.x - size.width/2
        let originY = center.y - size.height/2
        self.init(origin: Point(x: originX, y: originY), size:size)
    }
}

extension Int { //扩展方法
    func repetitions(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
}

extension Int { //扩展修改实例方法
    mutating func square() {
        self = self * self
    }
}

extension Int { //扩展下标
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0...digitIndex { //???有疑问
            decimalBase *= 10
        }
        
        return (self / decimalBase) % 10
    }
}

extension Character { //扩展嵌套类型
    enum Kind {
        case Vowel, Consonant, Other
    }
    
    var kind: Kind {
        switch String(self).lowercaseString {
        case "a", "e", "i", "o", "u":
            return .Vowel
            
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m","n", "p", "q", "r", "s", "t", "v", "w", "x", "y","z":
            return .Consonant
            
        default:
            return .Other
        }
    }
}

//协议
protocol FullyNamed {
    var fullyName: String {get}
}

class Startship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullyName:String{
        return (prefix != nil ? prefix! + " " : " ") + name
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
        
        //类型转换示例
        typeChangeFunction()
        
        //类型嵌套示例
        typeNestingFunction()
        
        //扩展示例
        extensionFunction()
        
        //运算符函数
        let vector = Vector2D(x: 3.0, y: 1.0)
        let otherVector = Vector2D(x: 2.0, y: 4.0)
        let combinedVector = vector + otherVector
        let alsoPositive = -otherVector
        print("运算符函数的值是：\(combinedVector), 前置运算符：\(alsoPositive)")
        //组合赋值运算符
        var original = Vector2D(x: 3.0, y: 5.0)
        let vectorToAdd = Vector2D(x: 5.0, y: 3.0)
        original += vectorToAdd
        print("组合赋值运算符：\(original)")
        //比较运算符
        let twoThree = Vector2D(x: 2.0, y: 3.0)
        let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
        if twoThree == anotherTwoThree {
            print("这两个常量是相等的")
        }
        //自定义运算符
        var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
        let afterDoubing = +++toBeDoubled
        print("自定义运算符是：\(afterDoubing)")
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
    
    //类型转换
    class MediaItem {
        var name: String
        init(name: String) {
            self.name = name
        }
    }
    
    class Movie: MediaItem {
        var director: String
        init(name: String, director: String) {
            self.director = director
            super.init(name: name)
        }
    }
    
    class Song: MediaItem {
        var artist: String
        init(name: String, artist:String) {
            self.artist = artist
            super.init(name: name)
        }
    }
    
    func typeChangeFunction() {
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        
        for item in library {
            print("item is type:\(item)")
            if let movie = item as? Movie {
                print("Movie: '\(movie.name)', dir: \(movie.director)")
            } else if let song = item as? Song {
                print("Song: '\(song.name)', by \(song.artist)")
            }
        }
    }
    
    //类型嵌套实例(扑克游戏：二十一点)
    struct BlackjackCard {
        //嵌套定义枚举类型Suit：扑克花色
        enum Suit: Character {
            case Spades = "♠", Hearts = "♥", Diamonds = "♦", Clubs = "♣"
        }
        //嵌套定义枚举类型Ranks:扑克13张牌
        enum Ranks: Int {
            case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
            case Jack, Queen, King, Ace
            struct Values {
                let first: Int, second: Int?
            }
            var values: Values { //计算属性
                switch self {
                case .Ace:
                    return Values(first: 1, second: 11)
                    
                case .Jack, .Queen, .King:
                    return Values(first: 10, second: nil)
                    
                default:
                    return Values(first: self.rawValue, second: nil)
                }
            }
        }
        
        //BlackjackCard 的属性和方法
        let rank: Ranks, suit: Suit
        var description: String {  //计算属性
            var output = "suit is \(suit.rawValue)"
            output += " value is \(rank.values.first)"
            if let second = rank.values.second {
                output += " or \(second)"
            }
            
            return output
        }
    }
    
    //类型嵌套示例函数
    func typeNestingFunction() {
        let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
        print("theAceOfSpades is: \(theAceOfSpades.description)")
    }
    
    //扩展示例函数
    func extensionFunction() {
        let oneInch = 25.4.km
        let threeFeet = 3.ft
        print("扩展计算型属性：\(oneInch, threeFeet)")
        
        let centerRect = Rect (center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
        print("扩展构造器：原点：(\(centerRect.origin.x),\(centerRect.origin.y)), 大小是：(\(centerRect.size.width),\(centerRect.size.height))")
        
        3.repetitions{
            print("扩展方法：Hello, world!")
        }
        
        var someInt = 3
        someInt.square()
        print("扩展修改实例方法：",someInt)
        
        print("扩展下标：", 746381295[0])
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



