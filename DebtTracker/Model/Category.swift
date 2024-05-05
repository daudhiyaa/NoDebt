//
//  Card.swift
//  DebtTracker
//
//  Created by Daud on 01/05/24.
//

import Foundation
import SwiftData

@Model
class CategoryActivity: Identifiable {
    var id: String
    var title: String
    var icon: String
    
    init(title: String, icon: String) {
        self.id = UUID().uuidString
        self.title = title
        self.icon = icon
    }
}
