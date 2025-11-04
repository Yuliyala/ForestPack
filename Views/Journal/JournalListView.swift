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
                            Text("Journal")
                                .font(.forestPack(size: 30))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 293, height: 103)
                    .position(x: 49 + 293/2, y: 69)
                    
                    VStack(spacing: 21) {
                        ScrollView {
                            VStack(spacing: 12) {
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
                                        .background(Color.forestGreen)
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
            .sheet(isPresented: $showingCreate) {
                JournalCreateView(viewModel: viewModel)
            }
        }
    }
}

struct JournalRow: View {
    let entry: JournalEntry
    
    var body: some View {
        HStack {
            Image(systemName: "mountain.2.fill")
                .foregroundColor(.darkGreen)
                .font(.system(size: 24))
            
            Text(entry.title)
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
