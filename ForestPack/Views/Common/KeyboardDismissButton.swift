import SwiftUI

struct KeyboardDismissButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.forestGreen)
                        .cornerRadius(8)
                    }
                }
            }
    }
}

extension View {
    func keyboardDismissButton() -> some View {
        modifier(KeyboardDismissButton())
    }
}
