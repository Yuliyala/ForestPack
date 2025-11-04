import SwiftUI

struct WoodenHeader: View {
    var title: String
    var showBackButton: Bool = false
    var onBack: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.woodBrown)
                .overlay(
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.brown.opacity(0.3),
                                    Color.woodBrown,
                                    Color.brown.opacity(0.3)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
            
            HStack {
                if showBackButton {
                    Button(action: {
                        onBack?()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .padding(.leading)
                }
                
                Spacer()
                
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                if showBackButton {
                    Spacer()
                        .frame(width: 44)
                }
            }
        }
        .frame(height: 60)
    }
}

