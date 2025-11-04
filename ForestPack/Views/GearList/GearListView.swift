import SwiftUI

struct GearListView: View {
    @StateObject private var viewModel = GearListViewModel()
    @State private var newItemName = ""
    @State private var showingDeleteAlert = false
    @State private var isAddingNewItem = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 21) {
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(viewModel.gearItems) { item in
                        GearItemRow(item: item) {
                            viewModel.toggleItem(item)
                        }
                    }
                    
                    if isAddingNewItem {
                        HStack(spacing: 8) {
                            Button(action: {
                                if !newItemName.isEmpty {
                                    viewModel.addItem(newItemName)
                                    newItemName = ""
                                    isAddingNewItem = false
                                    isTextFieldFocused = false
                                }
                            }) {
                                Image("component1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 39, height: 39)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .disabled(newItemName.isEmpty)
                            
                            TextField("", text: $newItemName)
                                .foregroundColor(.textFieldText)
                                .font(.forestPack(size: 24, weight: .regular))
                                .tracking(-0.32)
                                .placeholder(when: newItemName.isEmpty) {
                                    Text("New item")
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 24, weight: .regular))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                }
                                .focused($isTextFieldFocused)
                        }
                        .padding(.horizontal, 6)
                        .frame(height: 51)
                        .background(Color.textFieldBackground)
                        .cornerRadius(12)
                    }
                }
            }
            
            HStack(alignment: .center) {
                Button(action: {
                    isAddingNewItem = true
                    isTextFieldFocused = true
                }) {
                    Image("addСircle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 62, height: 64)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.leading, -8)
                
                Text("Add item")
                    .foregroundColor(.addItemText)
                    .font(.forestPack(size: 24))
                    .tracking(-0.32)
                    .lineHeight(21)
                
                Spacer()
            }
            
            Button(action: {
                showingDeleteAlert = true
            }) {
                Text("Delete All")
                    .foregroundColor(.white)
                    .font(.forestPack(size: 24))
                    .tracking(-0.32)
                    .lineHeight(21)
                    .frame(height: 63)
                    .frame(minWidth: 138)
                    .background(Color.deleteAllBackground)
                    .cornerRadius(12)
            }
        }
        .padding(21)
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal, 33)
        .padding(.bottom, 16)
        .alert("Delete All Items?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                viewModel.deleteAll()
            }
        } message: {
            Text("Are you sure you want to delete all gear items?")
        }
    }
}

struct GearItemRow: View {
    let item: GearItem
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: 8) {
                Image(item.isTaken ? "component2" : "component1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 39, height: 39)
                
                Text(item.name)
                    .foregroundColor(.textFieldText)
                    .font(.forestPack(size: 24, weight: .regular))
                    .tracking(-0.32)
                    .lineHeight(21)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 6)
            .frame(height: 51)
            .background(Color.textFieldBackground)
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

