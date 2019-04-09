import UIKit
/*:
1. Создать структуру “Описание файла” содержащую свойства:
- путь к файлу
- имя файла
- максимальный размер файла на диске
- путь к папке, содержащей этот файл
- тип файла (скрытый или нет)
- содержимое файла (можно просто симулировать контент)

Главная задача - это использовать правильные свойства там, где нужно, чтобы не пришлось хранить одни и те же данные в разных местах и т.д. и т.п.
*/


struct FileDescriprion {
    
    static var fileCount = 0
    static let maxSize = 256
    
    enum Visibility : String {
        case hidden, visible
    }
    
    var type : Visibility
    
    var fileName : String {
        didSet {
            if type == .hidden {
                fileName = "hidden"
            }
        }
    }
    
    let macHD = "macHD/"
    
    var pathToFile : String {
        get {
            return folder + "/" + fileName
        }
        set {
            let components = newValue.components(separatedBy: "/")
            if components.count > 0 {
                folder = components[0]
            }
            if components.count > 1 {
                fileName = components.last!
            }
        }
    }
    
    var folder : String {
        didSet{
            folder = macHD + folder
        }
    }
    
    var size : Int {
        willSet {
            if newValue > FileDescriprion.maxSize {
                print("File is too big")
            }
        }
        didSet {
            if size > FileDescriprion.maxSize {
                size = oldValue
            }
        }
    }
}


var myFile = FileDescriprion(type: .visible, fileName: "swift.playground", folder: "Swift", size: 200)
myFile.folder = "Swift"
myFile.folder
myFile.folder = "Desktop"
myFile.folder
myFile.type = .visible
myFile.fileName = "Swift"
myFile.fileName
myFile.pathToFile
myFile.size = 512
myFile.size


/*:
2. Создайте энум, который будет представлять некую цветовую гамму. Этот энум должен быть типа Int и как raw значение должен иметь соответствующее 3 байтное представление цвета. Добавьте в этот энум 3 свойства типа: количество цветов в гамме, начальный цвет и конечный цвет.
*/
enum Rainbow : Int  {
    static let colorsCount = 7
    static let firstColor = Rainbow.red
    static let lastColor = Rainbow.violet
    
    case red = 0xFF0000
    case orange = 0xFF7700
    case yellow = 0xFFFF00
    case green = 0x00FF09
    case blue = 0x00FFEF
    case darkBlue = 0x0900FF
    case violet = 0xFF00DE
}

/*:
3. Создайте класс человек, который будет содержать имя, фамилию, возраст, рост и вес. Добавьте несколько свойств непосредственно этому классу чтобы контролировать:
- минимальный и максимальный возраст каждого объекта
- минимальную и максимальную длину имени и фамилии
- минимально возможный рост и вес
- самое интересное, создайте свойство, которое будет содержать количество созданных объектов этого класса
*/
let error = "Invalid data"

class Human {
    
    static var maxAge = 150
    static var maxNameLength = 1...20
    static var maxHeight = 1...300
    static var maxWeight = 1...200
    static var humanCount = 0
    
    var firstName: String {
        didSet {
            if !Human.maxNameLength.contains(firstName.count) {
                firstName = oldValue
                print(error)
            }
        }
    }
    var lastName: String {
        didSet {
            if !Human.maxNameLength.contains(lastName.count) {
                lastName = oldValue
                print(error)
            }
        }
        
    }
    
    var fullName: String {
        get {
            return firstName + " " + lastName
        }
        set {
            let full = newValue.components(separatedBy: " ")
            firstName = full.first!
            lastName = full.last!
        }
    }
    
    var age : Int {
        didSet {
            if age > Human.maxAge {
                age = oldValue
            }
        }
    }
    
    var height : Int {
        didSet {
            if !Human.maxHeight.contains(height) {
                print(error)
                height = oldValue
            }
        }
    }
    
    var weight : Int {
        didSet {
            if !Human.maxWeight.contains(weight) {
                print(error)
                weight = oldValue
            }
        }
    }
    
    lazy var storyAbout = "My name is \(fullName), I'm \(age) years old, my weight is \(weight) and my height is \(height)"
    
    init(firstName : String, lastName: String, age : Int, weight: Int, height: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.weight = weight
        self.height = height
        
        Human.humanCount += 1
    }
}

let man = Human(firstName: "Alex", lastName: "Ivanov", age: 40, weight: 70, height: 170)
print(man.fullName)
man.firstName = "Dima"
man.lastName = "Petrov"
man.weight = 500
man.height = 1000

print(man.weight)
print(man.height)
print(man.fullName)
print(man.storyAbout)
print(Human.humanCount)
