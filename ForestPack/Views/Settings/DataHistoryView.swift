import SwiftUI

struct DataHistoryView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.tabBarHidden) var tabBarHidden
    @State private var showingDeleteAlert = false
    @State private var showingConfirmAlert = false
    
    var body: some View {
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
                    
                    Text("Data History")
                        .font(.forestPack(size: 30))
                        .foregroundColor(.white)
                }
                .frame(width: 293, height: 103)
                .position(x: 49 + 293/2, y: 69)
                
                Button(action: {
                    dismiss()
                }) {
                    ZStack {
                        Color.clear
                            .frame(width: 59, height: 59)
                            .cornerRadius(8)
                        
                        Image("backIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 59, height: 59)
                    }
                }
                .position(x: 49, y: 69)
                
                ScrollView {
                    VStack(spacing: 0) {
                        VStack(spacing: 6) {
                            HStack {
                                Image("treeIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                                
                                Text("Statistics & Notes")
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 22))
                                    .tracking(-0.32)
                                    .lineHeight(21)
                                
                                Spacer()
                                
                                Button(action: {
                                    showingDeleteAlert = true
                                }) {
                                    Text("Clear")
                                        .foregroundColor(.forestGreen)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                }
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 12)
                            .background(Color.textFieldBackground)
                            .cornerRadius(12)
                        }
                        .padding(.top, 28)
                        .padding(.bottom, 28)
                        .padding(.leading, 21)
                        .padding(.trailing, 21)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 33)
                        .padding(.top, 140)
                        .padding(.bottom, 100)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            tabBarHidden.wrappedValue = true
        }
        .onDisappear {
            tabBarHidden.wrappedValue = false
        }
        .alert("You will delete data forever", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Yes", role: .destructive) {
                viewModel.clearAllData()
                showingConfirmAlert = true
            }
        } message: {
            Text("Are you sure you want to delete your statistics and notes history?")
        }
        .alert("Data was deleted", isPresented: $showingConfirmAlert) {
            Button("Ok", role: .cancel) {}
            Button("Leave", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("You are no longer able to see your statistics and notes history.")
        }
    }
}
