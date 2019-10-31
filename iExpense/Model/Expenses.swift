//
//  Expenses.swift
//  iExpense
//
//  Created by Mihai Leonte on 10/31/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import Foundation

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
