import Foundation

// ---------------------------------------------------- //
// MARK: - Simple Protocols implementation

// ---------------------------------------------------- //

protocol AirlineTicket {
    var name: String { get }
    var departure: Date? { get set }
    var arrival: Date? { get set }
}

struct Economy: AirlineTicket {
    let name = "ECON"
    var departure: Date?
    var arrival: Date?
}

struct Business: AirlineTicket {
    let name = "BUS"
    var departure: Date?
    var arrival: Date?
}

struct First: AirlineTicket {
    let name = "FIRST"
    var departure: Date?
    var arrival: Date?
}

class CheckoutService {
    
    var tickets: [AirlineTicket]
    
    init(tickets: [AirlineTicket]) {
        self.tickets = tickets
    }
    
    func addTicket(_ ticket: AirlineTicket) {
        self.tickets.append(ticket)
    }
    
    func proccessTickets() {
        tickets.forEach {
            print($0)
        }
    }
}

let economyTickets = [Economy(departure: Date(), arrival: Date())]
let service = CheckoutService(tickets: economyTickets)

service.addTicket(First(departure: Date(), arrival: Date()))
service.proccessTickets()

// ---------------------------------------------------- //
// MARK: - Generics for Protocols
/// associatedtype are generics but which are living inside a protocol.
// ---------------------------------------------------- //

protocol Parser {
    associatedtype Input
    associatedtype Output
    
    func parse(input: Input) -> Output
}

class TextFileParser: Parser {
    func parse(input: String) -> String {
        return ""
    }
}

class HtmlParser: Parser {
    func parse(input: String) -> [String] {
        return []
    }
}

class JsonParser: Parser {
    typealias Input = String
    typealias Output = [String : String]
    
    func parse(input: Input) -> Output {
        return [:]
    }
}

// We have to use generics to recibe as a param a Parser because of its associated types
// if we want to limit what input can be, use where
func runParser<P: Parser>(parser: P, input: [P.Input]) where P.Input == JsonParser {
    input.forEach {
        _ = parser.parse(input: $0)
    }
}

// ---------------------------------------------------- //
// MARK: - Extensions for Protocols
/// Default implementarion to the functions in the protocol
// ---------------------------------------------------- //

extension Parser {
    func parse(input: String) -> [String] {
        return ["<html> </html>", "<p></p>"]
    }
}

// At this point is not required to implement the parse func in XhtmlParser
// because of the implementation inside the Parser extension.
class XhtmlParser: Parser {
    
}

// ---------------------------------------------------- //
// MARK: - Inheritance in Protocols
///
// ---------------------------------------------------- //

struct Course {
    let name: String
    let courseNumber: String
    let creditHours: Int
}

// Student protocol & Extension (default impl)
protocol Student {
    var courses: [Course] { get set }
    mutating func enroll(_ course: Course)
}

extension Student {
    mutating func enroll(_ course: Course) {
        self.courses.append(course)
    }
}

// VerifiedStudent protocol & Extension (default impl)
protocol VerifiedStudent: Student {
    func verify() -> Bool
}

extension VerifiedStudent {
    func verify() -> Bool {
        return true
    }
    
    mutating func enroll(_ course: Course) {
        if verify() {
            self.courses.append(course)
        }
    }
}

struct InternationalStudent: VerifiedStudent {
    // As the Student and VerifiedStudent protocols has default implementations
    // of their funcs in the extensions, we only have to implement the courses variable.
    var courses: [Course] = []
}

var student = InternationalStudent()
student.enroll(Course(name: "Logic", courseNumber: "421", creditHours: 90))

// ---------------------------------------------------- //
// MARK: - Protocol composition
/// A constraint can be used in a protocol to be sure that all classes or structs
/// thar implements a protocol, must also conform other protocol.
/// Is made with the syntax:
/// ** protocol ProtocolName where Self: OtherProtocol
// ---------------------------------------------------- //

protocol LocalStudent where Self: Student {
    func getAddress() -> String?
}

extension LocalStudent {
    func enroll(_ course: Course) {
        if let address = getAddress() {
            print("Send mail to student's house: \(address)")
        }
    }
    
    func getAddress() -> String? {
        return "123 Fake Street"
    }
}

struct Person: Student, LocalStudent {
    var courses: [Course]
}
