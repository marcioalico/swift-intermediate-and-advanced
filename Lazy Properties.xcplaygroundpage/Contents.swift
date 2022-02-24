import Foundation

// MARK: - When use lazy properties?

// Any time you have a case where:
/// - you need to initialize something only once (example: LocationManager en CoreLocation).
/// - the initialization of that property will take some time

// Lazy properties are only initialized when you're trying to access them.

enum Level {
    case easy
    case medium
    case hard
}

struct Exam {
    var level: Level
    
    // MARK: - private(set)
    // can only be initialized or assigned within the exam struct
    lazy private(set) var questions: [String] = {
        // simulate api request time
        sleep(5)
        
        switch level {
        case .easy:
            return ["",""]
        case .medium:
            return ["",""]
        case .hard:
            return ["",""]
        }
    }()
}

// He must declare exam as a mutable (var) because when you acces to the lazy property, it will be initialized
var exam = Exam(level: .easy)

print(exam.questions)
print("Waiting for 1 second ...")
sleep(1)
print(exam.questions)
