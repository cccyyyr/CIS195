//Exercise 0
/*
 Name: Cathy Chen
 PennKey: 13385532
 App number: 1
 I'm mostly looking forward to building my own project at the end of the course!
 */
//Exercise 1

let foo: Int = 42
let fooStr: String? = String(42)
print ("My number is \(fooStr!)")

if let actual: String = fooStr{
    print ("My number is \(actual)")
} else {
    print ("My number is nil")
}
let actual = fooStr ?? "42"
print ("My number is \(actual)")

// Exercise 2
let target = "cis195 is fun"
var arr = [Character]()
for character in "cis195 is fun" {
    arr.append(character)
}
var newString = String(arr)
newString.append("!")
print(newString)
var peopleDict = [String:Int]()
peopleDict["Kevin"] = 20
peopleDict["Emily"] = 30
peopleDict["Lily"] = 40
dump(peopleDict)
var myInfo = ("Cathy", 2023)
print(myInfo)

// Exercise 3
peopleDict.forEach({ (name, year) in
    if year >= 21 {
        print("My friend \(name) is not under 21")
    } else {
        print("My friend \(name) is under 21")
    }
})

for i in 1...10 {
    print(i)
}
for char in "cis195"{
    print(char)
}

// Exercise 4

func sumAndDiff(_ num1: Int, _ num2: Int) -> (sum: Int, diff: Int){
    return (num1 + num2, abs(num1 - num2))
}
 
typealias Course = String
typealias PennId = Int

func enroll(in course: Course, using pennId: PennId){
    print ("Enrolled \(pennId) in \(course)")
}
let newCourse = "CIS195"
let myPennId = 13385532
enroll(in: newCourse, using: myPennId)

// Exercises 5 and 6
struct Rectangle{
    var length = 0
    var width = 0
    var area: Int{
        return length * width
    }
    var simpleDescription: String?{
        didSet {
            print(self.simpleDescription!)
        }
    }
}

var myRect = Rectangle(length: 10, width: 5)

typealias School = String
typealias Major = String

class Student {
    var name: String
    var school: School?
    var major: Major = "undeclared"
    init(name: String, school: School, major: Major){
        self.name = name
        self.major = major
        self.school = school
    }
    init(name: String){
        self.name = name
    }
}
var me = Student(name: "Cathy", school: "SEAS", major: "CS")
var babyQuaker = Student(name: "Cathy")
let majorList = ["CS", "NETS","EE", "MATH"]
babyQuaker.major = majorList.randomElement()!

myRect.simpleDescription = "This is my rectangle"
print(myRect.area)

