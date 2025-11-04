import SwiftUI

struct DatePickerSheet: View {
    @Binding var date: Date
    @Binding var isPresented: Bool
    @Environment(\.tabBarHidden) var tabBarHidden
    var onDateSelected: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("mainPage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Button(action: {
                    isPresented = false
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
                
                ZStack {
                    Image("gearListImg")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Select Date")
                        .font(.forestPack(size: 30))
                        .foregroundColor(.white)
                }
                .frame(width: 293, height: 103)
                .position(x: 49 + 293/2, y: 69)
                
                VStack {
                    DatePicker("Select Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                        .padding()
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding()
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .onAppear {
                tabBarHidden.wrappedValue = true
            }
            .onDisappear {
                onDateSelected?()
            }
        }
    }
}

