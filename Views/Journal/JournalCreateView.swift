import SwiftUI
import PhotosUI

struct JournalCreateView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.tabBarHidden) var tabBarHidden
    
    @State private var title = ""
    @State private var date = Date()
    @State private var hasSelectedDate = false
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
                                TextField("", text: $title)
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 22))
                                    .tracking(-0.32)
                                    .placeholder(when: title.isEmpty) {
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
                            
                            Button(action: {
                                showingDatePicker = true
                            }) {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text(hasSelectedDate ? formatDate(date) : "Select Date")
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(.darkGreen)
                                        .font(.system(size: 20))
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            HStack {
                                Image("treeIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                                TextField("", text: $place)
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 22))
                                    .tracking(-0.32)
                                    .placeholder(when: place.isEmpty) {
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
                                TextEditor(text: $impressions)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color.textFieldBackground)
                                    .cornerRadius(12)
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 22))
                                    .tracking(-0.32)
                            }
                            
                            Button(action: {
                                showingImagePicker = true
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.textFieldBackground)
                                        .frame(height: 150)
                                    
                                    if let selectedImage = selectedImage {
                                        Image(uiImage: selectedImage)
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
                            
                            Button(action: saveEntry) {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.woodBrown)
                                    .cornerRadius(8)
                            }
                            .disabled(title.isEmpty)
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
                    DatePickerSheet(date: $date, isPresented: $showingDatePicker, onDateSelected: {
                        hasSelectedDate = true
                    })
                        .environment(\.tabBarHidden, tabBarHidden)
                        .zIndex(1000)
                }
                
                if showingImagePicker {
                    ImagePicker(selectedImage: $selectedImage)
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
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
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
