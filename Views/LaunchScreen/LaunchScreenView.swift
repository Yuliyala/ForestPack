import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    
    var body: some View {
        if isActive {
            MainTabView()
        } else {
            ZStack {
                Image("loadingPage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(opacity)
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.0)) {
                    opacity = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

