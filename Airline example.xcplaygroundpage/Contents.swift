
struct Economy {
    let departure: String
    let arrival: String
}

struct FirstClass {
    let departure: String
    let arrival: String
    let meal: Bool
}

struct Business {
    let departure: String
    let arrival: String
    let meal: Bool
    let chargingPorts: Bool
}

struct International {
    let departure: String
    let arrival: String
    let meal: Bool
    let chargingPorts: Bool
    let baggageAllowed: Bool
}

enum Ticket {
    case economy(Economy)
    case firstClass(FirstClass)
    case business(Business)
    case international(International)
}

let ticket = Ticket.business(Business(departure: "Houston",
                                      arrival: "Denver",
                                      meal: true,
                                      chargingPorts: true))

func checkIn(_ ticket: Ticket) {
    switch ticket {
    case .economy(let economy):
        print(economy)
    case .firstClass(let firstClass):
        print(firstClass)
    case .business(let business):
        print(business)
    case .international(let international):
        print(international)
    }
}

checkIn(ticket)
