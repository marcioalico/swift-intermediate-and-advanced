import Foundation


// MARK: - Session model data using enum
enum SessionEnum {
    case keynote(title: String, speaker: String, date: Date, isRecorded: Bool)
    case normal(title: String, speaker: String, date: Date)
    case workshop(title: String, speaker: String, date: Date, isRecorded: Bool)
    case joint(title: String, speakers: [String], date: Date)
}

let keynote = SessionEnum.keynote(title: "WWDC 2022", speaker: "Tim Cook", date: Date(), isRecorded: true)

func displaySession(session: SessionEnum) {
    
    // match the parameter with differents session cases
    switch session {
    case let .keynote(title: title, speaker: speaker, date: date, isRecorded: isRecorded):
        print(title, speaker, date, isRecorded)
    case let .normal(title: title, speaker: speaker, date: date):
        print(title, speaker, date)
    default:
        print("default")
    }
    
    // looking for an specific case
    if case let SessionEnum.keynote(title: title, speaker: speaker, date: date, isRecorded: isRecorded) = session {
        print( "Is key note session! - ", title, date, speaker, isRecorded)
    }
}

displaySession(session: keynote)

// MARK: - Session model data using struct
struct Session {
    let title: String
    let speaker: String
    let date: Date
    let isKeynote: Bool
    let isWorkshop: Bool
    let isRecorded: Bool
    let isNormal: Bool
    var jointSpeakers: [String]?
}

let session = Session(title: "Structs vs Enums",
                      speaker: "Marcio Alico",
                      date: Date(),
                      isKeynote: false,
                      isWorkshop: false,
                      isRecorded: false,
                      isNormal: true,
                      jointSpeakers: nil)

