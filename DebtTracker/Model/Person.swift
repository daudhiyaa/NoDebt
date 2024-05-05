//
//  Person.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import Foundation
import SwiftData

@Model
class Person: Identifiable {
    var id = UUID()
    var name: String
    var nominal: Double
    var isPaid: Bool
    
    init(id: UUID = UUID(), name: String, nominal: Double, isPaid: Bool) {
        self.id = id
        self.name = name
        self.nominal = nominal
        self.isPaid = isPaid
    }
}
