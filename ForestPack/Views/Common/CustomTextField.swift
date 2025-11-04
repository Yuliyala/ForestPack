import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack {
            Image(systemName: "tree.fill")
                .foregroundColor(.darkGreen)
                .font(.system(size: 14))
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
        }
        .padding()
        .background(Color.lightGreen)
        .cornerRadius(8)
        .foregroundColor(.darkGreen)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

