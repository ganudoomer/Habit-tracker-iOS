//
//  ContentView.swift
//  Habit-tracker
//
//  Created by Sree on 16/10/21.
//

import SwiftUI




struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var showAddItem: Bool = false
    @State private var showHabitView: Bool = false
    @State private var count = 0
    @State private var onSelected = UUID()
    var body: some View {
        NavigationView{
            List{
                ForEach(habits.items) { habit in
                    HStack{
                        Group{
                        Image(systemName: "book.fill").foregroundColor(.blue)
                        VStack(alignment:.leading){
                            Text("\(habit.title)").font(.headline)
                        }
                        Spacer()
                        Text("\(habit.count)")
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.red)
                        }
                        }.onTapGesture {
                            self.onSelected  = habit.id
                            self.showHabitView.toggle()
                            
                        }.sheet(isPresented: $showHabitView, content: {
                        let index = self.searchIndexWithId(id: onSelected, array: habits.items)
                        HabitView(habit: habits.items[index ?? 0],habits:self.habits)
                    })
                  
                }
            }.navigationBarItems(trailing: HStack{
                Button(action: {
                    self.showAddItem.toggle()
                }){
                    Image(systemName:"plus")
                }
                
            } )
            .navigationTitle("iTrack it").toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }.sheet(isPresented: $showAddItem, content: {
            AddView(habits: self
                        .habits)
        })
       
    }
    func remvoeItems(at offSets: IndexSet){
        habits.items.remove(atOffsets: offSets)
    }

    func searchIndexWithId(id: UUID, array: [Habit]) -> Int? {
      return array.firstIndex { $0.id == id }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
