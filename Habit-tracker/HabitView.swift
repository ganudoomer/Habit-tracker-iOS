//
//  HabitView.swift
//  Habit-tracker
//
//  Created by Sree on 16/10/21.
//

import SwiftUI

struct HabitView: View {
    @State var habit : Habit
    @Environment(\.presentationMode) var presentationMode
    @State  var count: Int = 0
    @ObservedObject var habits: Habits
    
    var body: some View {
        NavigationView{
            Form {
                Text(habit.description)
                Stepper("Count:  \(count)", value: $count )
            }
            .navigationBarItems(trailing: HStack{
                Button(action: {
                    print("Hello")
                    let index = searchIndexWithId(id: habit.id, array: habits.items)
                    self.habits.items[index ?? 0].count = count
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Save")
                }
            } )
            .navigationTitle(habit.title)
        }.onReceive(habits.$items) { items in
           let index = searchIndexWithId(id: habit.id, array: items)
            count = items[index ?? 0].count
        }
    
    }
    func searchIndexWithId(id: UUID, array: [Habit]) -> Int? {
      return array.firstIndex { $0.id == id }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habit: Habit(title: "Hello", description: "Heyyy", count: 2),habits: Habits())
    }
}
