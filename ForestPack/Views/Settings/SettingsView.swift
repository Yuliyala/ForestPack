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
                    
                    VStack(spacing: 6) {
                        ScrollView {
                            VStack(spacing: 6) {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    
                                    Text("Notifications")
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        viewModel.settings.notificationsEnabled.toggle()
                                        viewModel.saveSettings()
                                    }) {
                                        Image(viewModel.settings.notificationsEnabled ? "switchActive" : "switchInactive")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 51, height: 31)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                                
                                NavigationLink(destination: DataHistoryView(viewModel: viewModel)) {
                                    HStack {
                                        Image("treeIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 42, height: 42)
                                        
                                        Text("Data History")
                                            .foregroundColor(.textFieldText)
                                            .font(.forestPack(size: 22))
                                            .tracking(-0.32)
                                            .lineHeight(21)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.darkGreen)
                                            .font(.system(size: 16))
                                    }
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 12)
                                    .background(Color.textFieldBackground)
                                    .cornerRadius(12)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                NavigationLink(destination: DeveloperInfoView()) {
                                    HStack {
                                        Image("treeIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 42, height: 42)
                                        
                                        Text("Developer Info")
                                            .foregroundColor(.textFieldText)
                                            .font(.forestPack(size: 22))
                                            .tracking(-0.32)
                                            .lineHeight(21)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.darkGreen)
                                            .font(.system(size: 16))
                                    }
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 12)
                                    .background(Color.textFieldBackground)
                                    .cornerRadius(12)
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

