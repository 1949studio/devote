//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Jack Pyo Toke on 19/10/21.
//

import SwiftUI

struct NewTaskItemView: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task: String = ""
    @Binding var isShowing: Bool
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    private var isButtonDisabled: Bool {
        task.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    //MARK: - FUNCTIONS
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task.trimmingCharacters(in: .whitespacesAndNewlines)
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
                
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16){
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(isDarkMode ? Color(UIColor.secondarySystemBackground) : Color(UIColor.tertiarySystemBackground) )
                    .cornerRadius(10)
                
                Button(action: {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                    feedback.notificationOccurred(.success)
                }) {
                    Spacer()
                    Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(isButtonDisabled)
                .onTapGesture {
                    if isButtonDisabled {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .cornerRadius(10)
            } //: VStack
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(isDarkMode ? Color.white : Color(UIColor.secondarySystemBackground))
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        } //: VStack
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .previewDevice("iPhone 13")
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
