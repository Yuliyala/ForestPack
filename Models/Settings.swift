import Foundation

struct AppSettings: Codable {
    var notificationsEnabled: Bool
    
    init(notificationsEnabled: Bool = true) {
        self.notificationsEnabled = notificationsEnabled
    }
}

