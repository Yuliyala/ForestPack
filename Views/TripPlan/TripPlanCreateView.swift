import SwiftUI

struct TripPlanCreateView: View {
    @ObservedObject var viewModel: TripPlanViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.tabBarHidden) var tabBarHidden
    
    @State private var name = ""
    @State private var date = Date()
    @State private var hasSelectedDate = false
    @State private var goal = ""
    @State private var route = ""
    @State private var participants = ""
    @State private var duration = ""
    @State private var notes = ""
    @State private var showingDatePicker = false
    @State private var showingDurationPicker = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, goal, route, participants, notes
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
                    
                    Text("Enter Name")
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
                .position(x: 49 , y: 69)
                
                ScrollView {
                    VStack(spacing: 0) {
                        VStack(spacing: 21) {
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
                                TextField("", text: $goal)
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 22))
                                    .tracking(-0.32)
                                    .placeholder(when: goal.isEmpty) {
                                        Text("Enter Goal")
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
                            
                            HStack {
                                Image("treeIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                                TextField("", text: $route)
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 22))
                                    .tracking(-0.32)
                                    .placeholder(when: route.isEmpty) {
                                        Text("Enter Route")
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
                            
                            HStack {
                                Image("treeIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                                TextField("", text: $participants)
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 22))
                                    .tracking(-0.32)
                                    .placeholder(when: participants.isEmpty) {
                                        Text("Add Participants")
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
                                showingDurationPicker = true
                            }) {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text(duration.isEmpty ? "Duration" : duration)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.darkGreen)
                                        .font(.system(size: 16))
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text("Add Text")
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                }
                                TextEditor(text: $notes)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color.textFieldBackground)
                                    .cornerRadius(12)
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 22))
                                    .tracking(-0.32)
                            }
                            
                            Button(action: savePlan) {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.woodBrown)
                                    .cornerRadius(8)
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
                    DatePickerSheet(date: $date, isPresented: $showingDatePicker, onDateSelected: {
                        hasSelectedDate = true
                    })
                        .environment(\.tabBarHidden, tabBarHidden)
                        .zIndex(1000)
                }
                
                if showingDurationPicker {
                    DurationPickerSheet(duration: $duration, isPresented: $showingDurationPicker)
                        .environment(\.tabBarHidden, tabBarHidden)
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
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func savePlan() {
        let newPlan = TripPlan(
            name: name,
            date: date,
            goal: goal,
            route: route,
            participants: participants,
            duration: duration,
            notes: notes
        )
        viewModel.addPlan(newPlan)
        dismiss()
    }
}


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
                .position(x: 49 , y: 69)
                
                ZStack {
                    Image("gearListImg")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Enter Name")
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

struct DurationPickerSheet: View {
    @Binding var duration: String
    @Binding var isPresented: Bool
    @Environment(\.tabBarHidden) var tabBarHidden
    @State private var selectedOption: String = ""
    
    let options = ["1 day", "2 days", "3 days", "4 days", "Enter your own"]
    
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
                .position(x: 49 , y: 69)
                
                ZStack {
                    Image("gearListImg")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Duration")
                        .font(.forestPack(size: 30))
                        .foregroundColor(.white)
                }
                .frame(width: 293, height: 103)
                .position(x: 49 + 293/2, y: 69)
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 6) {
                            ForEach(options, id: \.self) { option in
                                Button(action: {
                                    if option == "Enter your own" {
                                        selectedOption = option
                                        duration = ""
                                    } else {
                                        selectedOption = option
                                        duration = option
                                    }
                                }) {
                                    Text(option)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 24, weight: .regular))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 70)
                                        .background((selectedOption == option && (duration == option || (option == "Enter your own" && duration != ""))) ? Color.orange : Color.textFieldBackground)
                                        .cornerRadius(12)
                                }
                            }
                            
                            if selectedOption == "Enter your own" {
                                TextField("Enter duration", text: $duration)
                                    .foregroundColor(.textFieldText)
                                    .font(.forestPack(size: 24))
                                    .padding()
                                    .frame(height: 70)
                                    .background(Color.textFieldBackground)
                                    .cornerRadius(12)
                            }
                            
                            if selectedOption != "" {
                                Button(action: {
                                    isPresented = false
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
                        .padding(.bottom, 100)
                        .padding(.leading, 21)
                        .padding(.trailing, 21)
                    }
                }
                .background(Color.white)
                .cornerRadius(12)
                .frame(height: 496)
                .padding(.horizontal, 33)
                .position(x: geometry.size.width / 2, y: 140 + 496/2)
            }
            .onAppear {
                tabBarHidden.wrappedValue = true
            }
        }
    }
}
