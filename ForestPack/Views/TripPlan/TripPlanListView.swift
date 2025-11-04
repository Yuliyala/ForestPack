import SwiftUI

struct TripPlanListView: View {
    @StateObject private var viewModel = TripPlanViewModel()
    @Environment(\.tabBarHidden) var tabBarHidden
    
    var body: some View {
        VStack(spacing: 21) {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.tripPlans) { plan in
                        NavigationLink(destination: TripPlanDetailView(plan: plan, viewModel: viewModel)) {
                            TripPlanRow(plan: plan)
                        }
                    }
                    
                    NavigationLink(destination: 
                        TripPlanCreateView(viewModel: viewModel)
                            .environment(\.tabBarHidden, tabBarHidden)
                    ) {
                        Text("Create")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.woodBrown)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(21)
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal, 33)
        .padding(.bottom, 16)
    }
}

struct TripPlanRow: View {
    let plan: TripPlan
    
    var body: some View {
        HStack {
            Image("tripIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 49, height: 49)
            
            Text(plan.name)
                .foregroundColor(.darkGreen)
                .font(.system(size: 16))
            
            Spacer()
        }
        .padding()
        .background(Color.lightGreen)
        .cornerRadius(8)
        .padding(.horizontal)
    }
}
