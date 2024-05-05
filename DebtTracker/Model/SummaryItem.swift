//
//  Summary.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import Foundation
import SwiftData

@Model
class SummaryItem: Identifiable {
    var id = UUID()
    var activityName: String
    var category: CategoryActivity
    var totalNominal: Double
    var groupName: String
    var isCredit: Bool
    var persons: [Person]
    
    init(id: UUID = UUID(), activityName: String, category: CategoryActivity, totalNominal: Double, groupName: String, isCredit: Bool, persons: [Person]) {
        self.id = id
        self.activityName = activityName
        self.category = category
        self.totalNominal = totalNominal
        self.groupName = groupName
        self.isCredit = isCredit
        self.persons = persons
    }
}
