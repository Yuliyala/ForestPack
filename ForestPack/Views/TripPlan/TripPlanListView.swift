import SwiftUI

struct TripPlanListView: View {
    @StateObject private var viewModel = TripPlanViewModel()
    @Environment(\.tabBarHidden) var tabBarHidden
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image("mainPage")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    ZStack {
                        Image("gearListImg")
                            .resizable()
                            .scaledToFit()
                        
                        Text("Trip Plan")
                            .font(.forestPack(size: 30))
                            .foregroundColor(.white)
                    }
                    .frame(width: 293, height: 103)
                    .position(x: 49 + 293/2, y: 69)
                    
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
                    .padding(.top, 28)
                    .padding(.bottom, 28)
                    .padding(.leading, 21)
                    .padding(.trailing, 21)
                    .background(Color.white)
                    .cornerRadius(12)
                    .frame(height: 496)
                    .padding(.horizontal, 33)
                    .position(x: geometry.size.width / 2, y: 140 + 496/2)
                }
            }
            .navigationBarHidden(true)
        }
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
