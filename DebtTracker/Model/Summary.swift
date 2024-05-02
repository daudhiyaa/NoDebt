//
//  Summary.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import Foundation

struct Summary: Identifiable {
    let id = UUID()
    let date: Date
    let totalNominal: Double
    let summaries: [SummaryItem]
}
