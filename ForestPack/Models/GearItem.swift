import Foundation

struct GearItem: Codable, Identifiable {
    let id: UUID
    var name: String
    var isTaken: Bool
    
    init(id: UUID = UUID(), name: String, isTaken: Bool = false) {
        self.id = id
        self.name = name
        self.isTaken = isTaken
    }
}

