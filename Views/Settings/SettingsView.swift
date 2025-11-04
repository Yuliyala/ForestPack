import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
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
                        
                        Text("Settings")
                            .font(.forestPack(size: 30))
                            .foregroundColor(.white)
                    }
                    .frame(width: 293, height: 103)
                    .position(x: 49 + 293/2, y: 69)
                    
                    VStack(spacing: 21) {
                        ScrollView {
                            VStack(spacing: 12) {
                                HStack {
                                    Image(systemName: "bell")
                                        .foregroundColor(.darkGreen)
                                        .font(.system(size: 20))
                                    
                                    Text("Notifications")
                                        .foregroundColor(.darkGreen)
                                        .font(.system(size: 16))
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $viewModel.settings.notificationsEnabled)
                                        .onChange(of: viewModel.settings.notificationsEnabled) { _ in
                                            viewModel.saveSettings()
                                        }
                                }
                                .padding()
                                .background(Color.lightGreen)
                                .cornerRadius(8)
                                
                                NavigationLink(destination: DataHistoryView(viewModel: viewModel)) {
                                    SettingsRow(icon: "arrow.right", title: "Data History")
                                }
                                
                                NavigationLink(destination: DeveloperInfoView()) {
                                    SettingsRow(icon: "arrow.right", title: "Developer Info")
                                }
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

struct SettingsRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.darkGreen)
                .font(.system(size: 20))
            
            Text(title)
                .foregroundColor(.darkGreen)
                .font(.system(size: 16))
            
            Spacer()
        }
        .padding()
        .background(Color.lightGreen)
        .cornerRadius(8)
    }
}
