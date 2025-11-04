import SwiftUI

struct DeveloperInfoView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.tabBarHidden) var tabBarHidden
    
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
                    
                    Text("Developer Info")
                        .font(.forestPack(size: 30))
                        .foregroundColor(.white)
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
                        VStack(alignment: .leading, spacing: 0) {
                            if let url = URL(string: "https://google.com/") {
                                WebView(url: url)
                                    .frame(height: 400)
                            } else {
                                Text("ForestPack is crafted by an outdoors-obsessed team of designers and engineers who hike, camp, and test features on real trails. Our goal is simple: help you prepare smarter and enjoy nature with less friction. We focus on a calm, practical experience—clear checklists, quick trip planning, and notes you'll actually use later. Privacy matters: your data stays on your device unless you choose to back it up. No invasive tracking, no clutter.")
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 22))
                                    .tracking(-0.32)
                                    .lineHeight(21)
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
}
