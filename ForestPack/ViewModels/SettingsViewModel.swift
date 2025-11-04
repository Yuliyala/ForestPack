import Foundation
import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    @Published var settings: AppSettings
    private let dataManager = DataManager.shared
    
    init() {
        settings = dataManager.loadSettings()
    }
    
    func saveSettings() {
        dataManager.saveSettings(settings)
    }
    
    func clearAllData() {
        dataManager.clearAllData()
        settings = AppSettings()
    }
}
