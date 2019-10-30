//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Mihai Leonte on 10/30/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
