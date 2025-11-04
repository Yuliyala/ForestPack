import Foundation
import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var journalEntries: [JournalEntry] = []
    private let dataManager = DataManager.shared
    
    init() {
        loadEntries()
    }
    
    func loadEntries() {
        journalEntries = dataManager.loadJournalEntries()
    }
    
    func saveEntries() {
        dataManager.saveJournalEntries(journalEntries)
    }
    
    func addEntry(_ entry: JournalEntry) {
        journalEntries.insert(entry, at: 0)
        saveEntries()
    }
    
    func updateEntry(_ entry: JournalEntry) {
        if let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries[index] = entry
            saveEntries()
        }
    }
    
    func deleteEntry(_ entry: JournalEntry) {
        journalEntries.removeAll { $0.id == entry.id }
        saveEntries()
    }
}
