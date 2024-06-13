//
//  DebtTrackerApp.swift
//  DebtTracker
//
//  Created by Daud on 26/04/24.
//

import SwiftUI
import SwiftData

@main
struct DebtTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            SummaryView()
        }
        .modelContainer(for: [CategoryActivity.self, Summary.self, SummaryItem.self])
    }
}
