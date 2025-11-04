import SwiftUI

struct DeveloperInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.leafBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                WoodenHeader(title: "Developer Info", showBackButton: true) {
                    dismiss()
                }
                
                if let url = URL(string: "https://google.com/") {
                    WebView(url: url)
                        .ignoresSafeArea()
                } else {
                    VStack {
                        Text("Loading...")
                            .foregroundColor(.darkGreen)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
