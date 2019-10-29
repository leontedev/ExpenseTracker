//
//  ContentView.swift
//  iExpense
//
//  Created by Mihai Leonte on 10/29/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    var name: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Hello \(name)!")
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ContentView: View {
    // Sheets
    @State private var showingSheet = false
    
    // ForEach .onDelete
    @State var numbers = [Int]()
    @State var currentNumber = 1
    
    // UserDefaults
    @State var tapCount = UserDefaults.standard.integer(forKey: "Tap") // if not found, returns 0
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }.onDelete(perform: <#T##Optional<(IndexSet) -> Void>##Optional<(IndexSet) -> Void>##(IndexSet) -> Void#>)
                }

                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
                
                Spacer()
                
                Button("Tap count: \(tapCount)") {
                    self.tapCount += 1
                    UserDefaults.standard.set(self.tapCount, forKey: "Tap")
                }
                
                Spacer()
                
                Button("Show Sheet, greet: Leonte") {
                    self.showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    SecondView(name: "Leonte")
                }
            }.navigationBarItems(leading: EditButton())
        }
        
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
