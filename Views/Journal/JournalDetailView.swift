import SwiftUI

struct JournalDetailView: View {
    @State var entry: JournalEntry
    let viewModel: JournalViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.tabBarHidden) var tabBarHidden
    
    @State private var isEditing = false
    @State private var editedTitle: String = ""
    @State private var editedDate: Date = Date()
    @State private var editedPlace: String = ""
    @State private var editedImpressions: String = ""
    @State private var editedImage: UIImage?
    @State private var showingDatePicker = false
    @State private var showingImagePicker = false
    @State private var showingDeleteAlert = false
    
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
                    
                    Text(entry.title)
                        .font(.forestPack(size: 30))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 293, height: 103)
                .position(x: 49 + 293/2, y: 69)
                
                Button(action: {
                    if isEditing {
                        isEditing = false
                        editedTitle = entry.title
                        editedDate = entry.date
                        editedPlace = entry.place
                        editedImpressions = entry.impressions
                        if let imageData = entry.imageData {
                            editedImage = UIImage(data: imageData)
                        }
                    } else {
                        dismiss()
                    }
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
                            if isEditing {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    TextField("", text: $editedTitle)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .placeholder(when: editedTitle.isEmpty) {
                                            Text("Enter Title")
                                                .foregroundColor(.textFieldText)
                                                .font(.forestPack(size: 22))
                                                .tracking(-0.32)
                                                .lineHeight(21)
                                        }
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            } else {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text(entry.title.isEmpty ? "Title" : entry.title)
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
                            
                            Button(action: {
                                if isEditing {
                                    showingDatePicker = true
                                }
                            }) {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text(formatDate(isEditing ? editedDate : entry.date))
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                    Spacer()
                                    if isEditing {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.darkGreen)
                                            .font(.system(size: 20))
                                    }
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .disabled(!isEditing)
                            
                            if isEditing {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    TextField("", text: $editedPlace)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .placeholder(when: editedPlace.isEmpty) {
                                            Text("Enter Place")
                                                .foregroundColor(.textFieldText)
                                                .font(.forestPack(size: 22))
                                                .tracking(-0.32)
                                                .lineHeight(21)
                                        }
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            } else {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text(entry.place.isEmpty ? "Place" : entry.place)
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
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text("Share Your Impressions")
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                }
                                if isEditing {
                                    TextEditor(text: $editedImpressions)
                                        .frame(height: 100)
                                        .padding(8)
                                        .background(Color.textFieldBackground)
                                        .cornerRadius(12)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                } else {
                                    Text(entry.impressions.isEmpty ? "Share Your Impressions" : entry.impressions)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(12)
                                        .background(Color.textFieldBackground)
                                        .cornerRadius(12)
                                }
                            }
                            
                            if isEditing {
                                Button(action: {
                                    showingImagePicker = true
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.textFieldBackground)
                                            .frame(height: 150)
                                        
                                        if let editedImage = editedImage {
                                            Image(uiImage: editedImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 150)
                                                .cornerRadius(12)
                                        } else if let imageData = entry.imageData,
                                                  let uiImage = UIImage(data: imageData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 150)
                                                .cornerRadius(12)
                                        } else {
                                            Image(systemName: "plus")
                                                .font(.system(size: 40))
                                                .foregroundColor(.darkGreen)
                                        }
                                    }
                                }
                            } else {
                                if let imageData = entry.imageData,
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .cornerRadius(12)
                                }
                            }
                            
                            if !isEditing {
                                HStack(spacing: 12) {
                                    Button(action: {
                                        isEditing = true
                                        editedTitle = entry.title
                                        editedDate = entry.date
                                        editedPlace = entry.place
                                        editedImpressions = entry.impressions
                                        if let imageData = entry.imageData {
                                            editedImage = UIImage(data: imageData)
                                        }
                                    }) {
                                        Text("Edit")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .semibold))
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.darkGray)
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
                                            .background(Color.woodBrown)
                                            .cornerRadius(8)
                                    }
                                }
                            } else {
                                Button(action: {
                                    saveChanges()
                                    isEditing = false
                                }) {
                                    Text("Save")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.woodBrown)
                                        .cornerRadius(8)
                                }
                            }
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
                
                if showingDatePicker {
                    DatePickerSheet(date: $editedDate, isPresented: $showingDatePicker, onDateSelected: {
                    })
                        .environment(\.tabBarHidden, tabBarHidden)
                        .zIndex(1000)
                }
                
                if showingImagePicker {
                    ImagePicker(selectedImage: $editedImage)
                        .zIndex(1000)
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
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func saveChanges() {
        let imageData = editedImage?.jpegData(compressionQuality: 0.8)
        entry.title = editedTitle
        entry.date = editedDate
        entry.place = editedPlace
        entry.impressions = editedImpressions
        entry.imageData = imageData
        viewModel.updateEntry(entry)
    }
}
