//
//  Person.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import SwiftUI

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let nominal: Double
}
