import SwiftUI

struct TripPlanDetailView: View {
    @State var plan: TripPlan
    let viewModel: TripPlanViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.tabBarHidden) var tabBarHidden
    
    @State private var isEditing = false
    @State private var editedName: String = ""
    @State private var editedDate: Date = Date()
    @State private var editedGoal: String = ""
    @State private var editedRoute: String = ""
    @State private var editedParticipants: String = ""
    @State private var editedDuration: String = ""
    @State private var editedNotes: String = ""
    @State private var showingDatePicker = false
    @State private var showingDurationPicker = false
    
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
                    
                    Text(isEditing ? editedName : plan.name)
                        .font(.forestPack(size: 30))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 293, height: 103)
                .position(x: 49 + 293/2, y: 69)
                
                Button(action: {
                    if isEditing {
                        isEditing = false
                        editedName = plan.name
                        editedDate = plan.date
                        editedGoal = plan.goal
                        editedRoute = plan.route
                        editedParticipants = plan.participants
                        editedDuration = plan.duration
                        editedNotes = plan.notes
                    } else {
                        dismiss()
                    }
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
                            if isEditing {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    TextField("", text: $editedName)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .placeholder(when: editedName.isEmpty) {
                                            Text("Enter Name")
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
                            }
                            
                            Button(action: {
                                if isEditing {
                                    showingDatePicker = true
                                }
                            }) {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text(formatDate(isEditing ? editedDate : plan.date))
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                    Spacer()
                                    if isEditing {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.darkGreen)
                                            .font(.system(size: 20))
                                    }
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .disabled(!isEditing)
                            
                            if isEditing {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    TextField("", text: $editedGoal)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .placeholder(when: editedGoal.isEmpty) {
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
                            } else {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text(plan.goal.isEmpty ? "Goal" : plan.goal)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                    Spacer()
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            }
                            
                            if isEditing {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    TextField("", text: $editedRoute)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .placeholder(when: editedRoute.isEmpty) {
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
                            } else {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text(plan.route.isEmpty ? "Route" : plan.route)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                    Spacer()
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            }
                            
                            if isEditing {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    TextField("", text: $editedParticipants)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .placeholder(when: editedParticipants.isEmpty) {
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
                            } else {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text(plan.participants.isEmpty ? "Participants" : plan.participants)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                    Spacer()
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            }
                            
                            Button(action: {
                                if isEditing {
                                    showingDurationPicker = true
                                }
                            }) {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text((isEditing ? editedDuration : plan.duration).isEmpty ? "Duration" : (isEditing ? editedDuration : plan.duration))
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                    Spacer()
                                    if isEditing {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.darkGreen)
                                            .font(.system(size: 16))
                                    }
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color.textFieldBackground)
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .disabled(!isEditing)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image("treeIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42, height: 42)
                                    Text("Notes")
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                }
                                if isEditing {
                                    TextEditor(text: $editedNotes)
                                        .frame(height: 100)
                                        .padding(8)
                                        .background(Color.textFieldBackground)
                                        .cornerRadius(12)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                } else {
                                    Text(plan.notes.isEmpty ? "Notes" : plan.notes)
                                        .foregroundColor(.textFieldText)
                                        .font(.forestPack(size: 22))
                                        .tracking(-0.32)
                                        .lineHeight(21)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(12)
                                        .background(Color.textFieldBackground)
                                        .cornerRadius(12)
                                }
                            }
                            
                            if !isEditing {
                                HStack(spacing: 12) {
                                    Button(action: {
                                        isEditing = true
                                        editedName = plan.name
                                        editedDate = plan.date
                                        editedGoal = plan.goal
                                        editedRoute = plan.route
                                        editedParticipants = plan.participants
                                        editedDuration = plan.duration
                                        editedNotes = plan.notes
                                    }) {
                                        Text("Edit")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .semibold))
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.darkGray)
                                            .cornerRadius(8)
                                    }
                                    
                                    Button(action: {
                                        viewModel.deletePlan(plan)
                                        dismiss()
                                    }) {
                                        Text("Delete")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .semibold))
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.woodBrown)
                                            .cornerRadius(8)
                                    }
                                }
                            } else {
                                Button(action: {
                                    saveChanges()
                                    isEditing = false
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
                    DatePickerSheet(date: $editedDate, isPresented: $showingDatePicker, onDateSelected: {
                    })
                        .environment(\.tabBarHidden, tabBarHidden)
                        .zIndex(1000)
                }
                
                if showingDurationPicker {
                    DurationPickerSheet(duration: $editedDuration, isPresented: $showingDurationPicker)
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
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func saveChanges() {
        plan.name = editedName
        plan.date = editedDate
        plan.goal = editedGoal
        plan.route = editedRoute
        plan.participants = editedParticipants
        plan.duration = editedDuration
        plan.notes = editedNotes
        viewModel.updatePlan(plan)
    }
}
