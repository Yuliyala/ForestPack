import Foundation

struct TripPlan: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var date: Date
    var goal: String
    var route: String
    var participants: String
    var duration: String
    var notes: String
    
    init(id: UUID = UUID(), name: String, date: Date = Date(), goal: String = "", route: String = "", participants: String = "", duration: String = "", notes: String = "") {
        self.id = id
        self.name = name
        self.date = date
        self.goal = goal
        self.route = route
        self.participants = participants
        self.duration = duration
        self.notes = notes
    }
    
    static func == (lhs: TripPlan, rhs: TripPlan) -> Bool {
        lhs.id == rhs.id
    }
}
