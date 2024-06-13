//
//  Person.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import Foundation

struct Person: Codable {
    var id = UUID()
    var name: String
    var nominal: Double
    var isPaid: Bool
}
