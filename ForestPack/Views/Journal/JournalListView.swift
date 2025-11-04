import SwiftUI

struct JournalListView: View {
    @StateObject private var viewModel = JournalViewModel()
    @State private var showingCreate = false
    
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
                        
                        VStack(spacing: 0) {
                            Text("Hiking")
                                .font(.forestPack(size: 30))
                                .foregroundColor(.white)
                            Text("Journal")
                                .font(.forestPack(size: 30))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 293, height: 103)
                    .position(x: 49 + 293/2, y: 69)
                    
                    VStack(spacing: 6) {
                        ScrollView {
                            VStack(spacing: 6) {
                                ForEach(viewModel.journalEntries) { entry in
                                    NavigationLink(destination: JournalDetailView(entry: entry, viewModel: viewModel)) {
                                        JournalRow(entry: entry)
                                    }
                                }
                                
                                Button(action: {
                                    showingCreate = true
                                }) {
                                    Text("Create")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.woodBrown)
                                        .cornerRadius(8)
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
            .navigationDestination(isPresented: $showingCreate) {
                JournalCreateView(viewModel: viewModel)
            }
        }
    }
}

struct JournalRow: View {
    let entry: JournalEntry
    
    var body: some View {
        HStack(spacing: 12) {
            if let imageData = entry.imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.lightGreen)
                    .frame(width: 60, height: 60)
            }
            
            Text(entry.title)
                .foregroundColor(.textFieldText)
                .font(.forestPack(size: 22))
                .tracking(-0.32)
                .lineHeight(21)
            
            Spacer()
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 12)
        .background(Color.textFieldBackground)
        .cornerRadius(12)
    }
}
