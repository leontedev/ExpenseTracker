//
//  ContentView.swift
//  iExpense
//
//  Created by Mihai Leonte on 10/29/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI


class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items) {
                UserDefaults.standard.set(data, forKey: "Items")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([ExpenseItem].self, from: data) {
                items = decodedData
                return
            }
        }
        items = []
    }
}


struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                // id: \.id is not required as ExpenseItem is conforming to the Identifiable protocol
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.footnote)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddExpense.toggle()
                }) {
                    Image(systemName: "plus")
                    
                }
            )
        }.sheet(isPresented: $showingAddExpense, content: {
            AddView(expenses: self.expenses)
        })
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
