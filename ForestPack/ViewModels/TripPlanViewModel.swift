import Foundation
import SwiftUI
import Combine

class TripPlanViewModel: ObservableObject {
    @Published var tripPlans: [TripPlan] = []
    private let dataManager = DataManager.shared
    
    init() {
        loadPlans()
    }
    
    func loadPlans() {
        tripPlans = dataManager.loadTripPlans()
    }
    
    func savePlans() {
        dataManager.saveTripPlans(tripPlans)
    }
    
    func addPlan(_ plan: TripPlan) {
        tripPlans.append(plan)
        savePlans()
    }
    
    func updatePlan(_ plan: TripPlan) {
        if let index = tripPlans.firstIndex(where: { $0.id == plan.id }) {
            tripPlans[index] = plan
            savePlans()
        }
    }
    
    func deletePlan(_ plan: TripPlan) {
        tripPlans.removeAll { $0.id == plan.id }
        savePlans()
    }
}
