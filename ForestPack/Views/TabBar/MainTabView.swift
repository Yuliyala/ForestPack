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
        ZStack {
            Group {
                if selectedTab == 0 {
                    GearListView()
                        .hideTabBar($isTabBarHidden)
                } else if selectedTab == 1 {
                    TripPlanListView()
                        .hideTabBar($isTabBarHidden)
                } else if selectedTab == 2 {
                    JournalListView()
                        .hideTabBar($isTabBarHidden)
                } else {
                    SettingsView()
                        .hideTabBar($isTabBarHidden)
                }
            }
            
            VStack {
                Spacer()
                
                if !isTabBarHidden {
                    CustomTabBar(selectedTab: $selectedTab)
                        .padding(.horizontal, 33)
                        .padding(.bottom, 10)
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 16) {
            TabBarButton(
                activeImageName: "hikingIconActive",
                inactiveImageName: "hikingIconInactive",
                isSelected: selectedTab == 0,
                action: { selectedTab = 0 }
            )
            
            TabBarButton(
                activeImageName: "routeIconActive",
                inactiveImageName: "routeIconInactive",
                isSelected: selectedTab == 1,
                action: { selectedTab = 1 }
            )
            
            TabBarButton(
                activeImageName: "editIconActive",
                inactiveImageName: "editIconInactive",
                isSelected: selectedTab == 2,
                action: { selectedTab = 2 }
            )
            
            TabBarButton(
                activeImageName: "settingsIconActive",
                inactiveImageName: "settingsIconInactive",
                isSelected: selectedTab == 3,
                action: { selectedTab = 3 }
            )
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
