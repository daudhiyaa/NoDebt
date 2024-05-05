//
//  Summary.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import Foundation
import SwiftData

@Model
class Summary: Identifiable {
    var id: String
    var date: Date
    var totalNominal: Double
    var summaries: [SummaryItem]
    
    init(date: Date, totalNominal: Double, summaries: [SummaryItem]) {
        self.id = UUID().uuidString
        self.date = date
        self.totalNominal = totalNominal
        self.summaries = summaries
    }
}
