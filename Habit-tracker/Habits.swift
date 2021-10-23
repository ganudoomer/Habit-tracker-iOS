//
//  Habits.swift
//  Habit-tracker
//
//  Created by Sree on 18/10/21.
//

import Foundation

struct Habit: Identifiable,Codable {
    var id = UUID()
    let title: String
    let description: String
    var count: Int
}




class Habits : ObservableObject {
    @Published var items = [Habit]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try?
                encoder.encode(items) {
                UserDefaults.standard.set(encoded,forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            //obj.self refer to the type of the object
            if let decoded = try? decoder.decode([Habit].self, from:items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
