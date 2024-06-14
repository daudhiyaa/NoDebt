//
//  AddCategoryViewModel.swift
//  DebtTracker
//
//  Created by Daud on 14/06/24.
//

import SwiftUI
import Combine
import SwiftData

class AddCategoryViewModel: ObservableObject {
    @Environment(\.modelContext) var context
    
    func addCategory(title: String, icon: String) {
        context.insert(CategoryActivity(
            title: title, icon: icon
        ))
    }
}
