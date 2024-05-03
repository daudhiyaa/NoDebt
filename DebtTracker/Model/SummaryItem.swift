//
//  Summary.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import SwiftUI

struct SummaryItem: Identifiable {
    let id = UUID()
    let activityName: String
    let category: String
    let totalNominal: Double
    let groupName: String
    let isCredit: Bool
    let persons: [Person]
}
