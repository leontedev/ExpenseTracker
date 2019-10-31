//
//  ContentView.swift
//  iExpense
//
//  Created by Mihai Leonte on 10/29/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI

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
                        
                        ItemAmount(item: item)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
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

struct ItemAmount: View {
    var item: ExpenseItem
    
    var body: some View {
        Text("$\(item.amount)")
            .foregroundColor(item.amount < 10 ? .gray : .black)
            .font(item.amount > 100 ? .headline : .body)
    }
}
