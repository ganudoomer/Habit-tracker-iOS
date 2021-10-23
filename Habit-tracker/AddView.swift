//
//  AddView.swift
//  Habit-tracker
//
//  Created by Sree on 16/10/21.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habits: Habits
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var count: String = ""

    var body: some View {
        NavigationView{
            Form {
                TextField("Title",text:$title)
                TextField("Description",text:$description)
                TextField("Amount",text:$count).keyboardType(.numberPad)
            }.navigationTitle("Add new habit").navigationBarItems(trailing: Button("Save"){
                if let parsedCount = Int(self.count) {
                    let habit = Habit(title: self.title, description: self.description, count: parsedCount)
                    self.habits.items.append(habit)
                }
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits:Habits())
    }
}
