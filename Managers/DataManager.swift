import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let gearItemsKey = "gearItems"
    private let tripPlansKey = "tripPlans"
    private let journalEntriesKey = "journalEntries"
    private let settingsKey = "appSettings"
    
    private init() {}
    
    func saveGearItems(_ items: [GearItem]) {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: gearItemsKey)
        }
    }
    
    func loadGearItems() -> [GearItem] {
        if let data = UserDefaults.standard.data(forKey: gearItemsKey),
           let items = try? JSONDecoder().decode([GearItem].self, from: data) {
            return items
        }
        return defaultGearItems()
    }
    
    func saveTripPlans(_ plans: [TripPlan]) {
        if let encoded = try? JSONEncoder().encode(plans) {
            UserDefaults.standard.set(encoded, forKey: tripPlansKey)
        }
    }
    
    func loadTripPlans() -> [TripPlan] {
        if let data = UserDefaults.standard.data(forKey: tripPlansKey),
           let plans = try? JSONDecoder().decode([TripPlan].self, from: data) {
            return plans
        }
        return []
    }
    
    func saveJournalEntries(_ entries: [JournalEntry]) {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: journalEntriesKey)
        }
    }
    
    func loadJournalEntries() -> [JournalEntry] {
        if let data = UserDefaults.standard.data(forKey: journalEntriesKey),
           let entries = try? JSONDecoder().decode([JournalEntry].self, from: data) {
            return entries
        }
        return []
    }
    
    func saveSettings(_ settings: AppSettings) {
        if let encoded = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encoded, forKey: settingsKey)
        }
    }
    
    func loadSettings() -> AppSettings {
        if let data = UserDefaults.standard.data(forKey: settingsKey),
           let settings = try? JSONDecoder().decode(AppSettings.self, from: data) {
            return settings
        }
        return AppSettings()
    }
    
    func clearAllData() {
        UserDefaults.standard.removeObject(forKey: gearItemsKey)
        UserDefaults.standard.removeObject(forKey: tripPlansKey)
        UserDefaults.standard.removeObject(forKey: journalEntriesKey)
        UserDefaults.standard.removeObject(forKey: settingsKey)
    }
    
    private func defaultGearItems() -> [GearItem] {
        return [
            GearItem(name: "Food & Beverage", isTaken: false),
            GearItem(name: "First Aid Kit", isTaken: false),
            GearItem(name: "Flashlight", isTaken: false),
            GearItem(name: "Clothing", isTaken: false),
            GearItem(name: "Sleeping bag", isTaken: false)
        ]
    }
}
