import Foundation
import SwiftUI
import Combine

class GearListViewModel: ObservableObject {
    @Published var gearItems: [GearItem] = []
    private let dataManager = DataManager.shared
    
    init() {
        loadItems()
    }
    
    func loadItems() {
        gearItems = dataManager.loadGearItems()
    }
    
    func saveItems() {
        dataManager.saveGearItems(gearItems)
    }
    
    func toggleItem(_ item: GearItem) {
        if let index = gearItems.firstIndex(where: { $0.id == item.id }) {
            gearItems[index].isTaken.toggle()
            saveItems()
        }
    }
    
    func addItem(_ name: String, isTaken: Bool = false) {
        let newItem = GearItem(name: name, isTaken: isTaken)
        gearItems.append(newItem)
        saveItems()
    }
    
    func deleteItem(_ item: GearItem) {
        gearItems.removeAll { $0.id == item.id }
        saveItems()
    }
    
    func deleteAll() {
        gearItems.removeAll()
        saveItems()
    }
}
