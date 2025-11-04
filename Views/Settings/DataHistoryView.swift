import SwiftUI

struct DataHistoryView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    @State private var showingConfirmAlert = false
    
    var body: some View {
        ZStack {
            Color.leafBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                WoodenHeader(title: "Data History", showBackButton: true) {
                    dismiss()
                }
                
                ScrollView {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Statistics & Notes")
                                .foregroundColor(.darkGreen)
                                .font(.system(size: 16))
                            
                            Spacer()
                            
                            Button(action: {
                                showingDeleteAlert = true
                            }) {
                                Text("Clear")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.darkGray)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationBarHidden(true)
        .alert("Delete Data?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("OK", role: .destructive) {
                showingConfirmAlert = true
            }
        } message: {
            Text("Do you want to delete data from app? Are you sure you want to delete your statistics and notes history?")
        }
        .alert("Data Deleted", isPresented: $showingConfirmAlert) {
            Button("OK", role: .cancel) {
                viewModel.clearAllData()
            }
        } message: {
            Text("Data now deleted. You are no longer able to use your statistics and notes history.")
        }
    }
}
