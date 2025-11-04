import SwiftUI

struct JournalDetailView: View {
    @State var entry: JournalEntry
    let viewModel: JournalViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingEdit = false
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ZStack {
            Color.leafBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                WoodenHeader(title: "Journal")
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(entry.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.darkGreen)
                        
                        Text("\(entry.date, style: .date)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Text(entry.place)
                            .font(.system(size: 16))
                            .foregroundColor(.darkGreen)
                        
                        Text(entry.impressions)
                            .font(.system(size: 16))
                            .foregroundColor(.darkGreen)
                        
                        if let imageData = entry.imageData,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding()
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            showingEdit = true
                        }) {
                            Text("Edit")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.forestGreen)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            showingDeleteAlert = true
                        }) {
                            Text("Delete")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showingEdit) {
            JournalEditView(entry: $entry, viewModel: viewModel)
        }
        .alert("Delete Entry?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                viewModel.deleteEntry(entry)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this journal entry?")
        }
    }
}

