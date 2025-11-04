import SwiftUI
import PhotosUI

struct JournalCreateView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var date = Date()
    @State private var place = ""
    @State private var impressions = ""
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingDatePicker = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case title, place, impressions
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.leafBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 16) {
                            CustomTextField(placeholder: "Enter Title", text: $title)
                                .focused($focusedField, equals: .title)
                            
                            Button(action: {
                                showingDatePicker = true
                            }) {
                                HStack {
                                    Image(systemName: "tree.fill")
                                        .foregroundColor(.darkGreen)
                                    Text("Select Date")
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(.darkGreen)
                                }
                                .padding()
                                .background(Color.lightGreen)
                                .cornerRadius(8)
                            }
                            
                            CustomTextField(placeholder: "Enter Place", text: $place)
                                .focused($focusedField, equals: .place)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "tree.fill")
                                        .foregroundColor(.darkGreen)
                                    Text("Share Your Impressions")
                                        .foregroundColor(.darkGreen)
                                }
                                TextEditor(text: $impressions)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color.lightGreen)
                                    .cornerRadius(8)
                                    .focused($focusedField, equals: .impressions)
                            }
                            
                            Button(action: {
                                showingImagePicker = true
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.lightGreen)
                                        .frame(height: 150)
                                    
                                    if let selectedImage = selectedImage {
                                        Image(uiImage: selectedImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 150)
                                            .cornerRadius(8)
                                    } else {
                                        Image(systemName: "plus")
                                            .font(.system(size: 40))
                                            .foregroundColor(.darkGreen)
                                    }
                                }
                            }
                            
                            Button(action: saveEntry) {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.forestGreen)
                                    .cornerRadius(8)
                            }
                            .disabled(title.isEmpty)
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding()
                    
                    if focusedField != nil {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .keyboardDismissButton()
            .sheet(isPresented: $showingDatePicker) {
                DatePickerSheet(date: $date, isPresented: $showingDatePicker)
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
    
    private func saveEntry() {
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        let newEntry = JournalEntry(
            title: title,
            date: date,
            place: place,
            impressions: impressions,
            imageData: imageData
        )
        viewModel.addEntry(newEntry)
        dismiss()
    }
}

struct JournalEditView: View {
    @Binding var entry: JournalEntry
    let viewModel: JournalViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String
    @State private var date: Date
    @State private var place: String
    @State private var impressions: String
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingDatePicker = false
    @FocusState private var focusedField: JournalCreateView.Field?
    
    init(entry: Binding<JournalEntry>, viewModel: JournalViewModel) {
        self._entry = entry
        self.viewModel = viewModel
        _title = State(initialValue: entry.wrappedValue.title)
        _date = State(initialValue: entry.wrappedValue.date)
        _place = State(initialValue: entry.wrappedValue.place)
        _impressions = State(initialValue: entry.wrappedValue.impressions)
        if let imageData = entry.wrappedValue.imageData {
            _selectedImage = State(initialValue: UIImage(data: imageData))
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.leafBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 16) {
                            CustomTextField(placeholder: "Enter Title", text: $title)
                                .focused($focusedField, equals: .title)
                            
                            Button(action: {
                                showingDatePicker = true
                            }) {
                                HStack {
                                    Image(systemName: "tree.fill")
                                        .foregroundColor(.darkGreen)
                                    Text("Select Date")
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(.darkGreen)
                                }
                                .padding()
                                .background(Color.lightGreen)
                                .cornerRadius(8)
                            }
                            
                            CustomTextField(placeholder: "Enter Place", text: $place)
                                .focused($focusedField, equals: .place)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "tree.fill")
                                        .foregroundColor(.darkGreen)
                                    Text("Share Your Impressions")
                                        .foregroundColor(.darkGreen)
                                }
                                TextEditor(text: $impressions)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color.lightGreen)
                                    .cornerRadius(8)
                                    .focused($focusedField, equals: .impressions)
                            }
                            
                            Button(action: {
                                showingImagePicker = true
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.lightGreen)
                                        .frame(height: 150)
                                    
                                    if let selectedImage = selectedImage {
                                        Image(uiImage: selectedImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 150)
                                            .cornerRadius(8)
                                    } else {
                                        Image(systemName: "plus")
                                            .font(.system(size: 40))
                                            .foregroundColor(.darkGreen)
                                    }
                                }
                            }
                            
                            Button(action: saveEntry) {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.forestGreen)
                                    .cornerRadius(8)
                            }
                            .disabled(title.isEmpty)
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding()
                }
            }
            .navigationTitle("Edit Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingDatePicker) {
                DatePickerSheet(date: $date, isPresented: $showingDatePicker)
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
    
    private func saveEntry() {
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        entry.title = title
        entry.date = date
        entry.place = place
        entry.impressions = impressions
        entry.imageData = imageData
        viewModel.updateEntry(entry)
        dismiss()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}
