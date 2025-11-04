import SwiftUI

struct TabBarHiddenKey: EnvironmentKey {
    static var defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var tabBarHidden: Binding<Bool> {
        get { self[TabBarHiddenKey.self] }
        set { self[TabBarHiddenKey.self] = newValue }
    }
}

extension View {
    func hideTabBar(_ hidden: Binding<Bool>) -> some View {
        self.environment(\.tabBarHidden, hidden)
    }
}

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var isTabBarHidden = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    Image("gearListImg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 293, height: 103)
                    
                    if selectedTab == 2 {
                        VStack(spacing: 0) {
                            Text("Hiking")
                                .font(.forestPack(size: 30))
                                .foregroundColor(.white)
                            Text("Journal")
                                .font(.forestPack(size: 30))
                                .foregroundColor(.white)
                        }
                    } else {
                        Text(currentTabTitle)
                            .font(.forestPack(size: 30))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 16)
                
                Group {
                    switch selectedTab {
                    case 0: GearListView()
                    case 1: TripPlanListView()
                    case 2: JournalListView()
                    default: SettingsView()
                    }
                }
                .hideTabBar($isTabBarHidden)
                
                Spacer(minLength: 0)
                
                if !isTabBarHidden {
                    CustomTabBar(selectedTab: $selectedTab)
                        .padding(.horizontal, 33)
                        .padding(.bottom, 10)
                }
            }
            .background(
                Image("mainPage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
    
    private var currentTabTitle: String {
        switch selectedTab {
        case 0: return "Gear List"
        case 1: return "Trip Plan"
        case 2: return "Hiking Journal"
        case 3: return "Settings"
        default: return ""
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    let tabs: [(active: String, inactive: String)] = [
        ("hikingIconActive", "hikingIconInactive"),
        ("routeIconActive", "routeIconInactive"),
        ("editIconActive", "editIconInactive"),
        ("settingsIconActive", "settingsIconInactive")
    ]
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<tabs.count, id: \.self) { index in
                TabBarButton(
                    activeImageName: tabs[index].active,
                    inactiveImageName: tabs[index].inactive,
                    isSelected: selectedTab == index,
                    action: { selectedTab = index }
                )
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 73)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.yellowAccent, lineWidth: 1)
        )
    }
}

struct TabBarButton: View {
    let activeImageName: String
    let inactiveImageName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(isSelected ? activeImageName : inactiveImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 47, height: 47)
        }
    }
}
