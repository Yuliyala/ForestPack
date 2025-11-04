import Foundation

struct JournalEntry: Codable, Identifiable {
    let id: UUID
    var title: String
    var date: Date
    var place: String
    var impressions: String
    var imageData: Data?
    
    init(id: UUID = UUID(), title: String, date: Date = Date(), place: String = "", impressions: String = "", imageData: Data? = nil) {
        self.id = id
        self.title = title
        self.date = date
        self.place = place
        self.impressions = impressions
        self.imageData = imageData
    }
}

