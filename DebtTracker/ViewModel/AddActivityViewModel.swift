//
//  AddActivityViewModel.swift
//  DebtTracker
//
//  Created by Daud on 14/06/24.
//

import SwiftUI
import Combine
import SwiftData

class AddActivityViewModel: ObservableObject {
    @Environment(\.modelContext) var context
    
    @Query private var summaries: [Summary]
    
    var listOfPersons: [Person] = []
    var totalNominal: Double = 0.0
    
    func addActivity(
        activityName: String,
        date: Date,
        groupName: String,
        isCredit: Bool,
        category: CategoryActivity?,
        friendsName: [String],
        nominals: [String]
    ) {
        for (friend, nominal) in zip(friendsName, nominals) {
            listOfPersons.append(
                Person(
                    name: friend,
                    nominal: Double(nominal)!,
                    isPaid: false
                )
            )
            
            totalNominal += Double(nominal)!
        }
        
        totalNominal *= isCredit ? -1 : 1
        
        let newSummaryItem = SummaryItem(
            activityName: activityName,
            category: CategoryActivity(title: category!.title, icon: category!.icon),
            totalNominal: totalNominal,
            groupName: groupName,
            isCredit: isCredit,
            persons: listOfPersons
        )
        
        var isFound = false
        for summary in summaries {
            if formatDate(date: date) == formatDate(date: summary.date) {
                summary.totalNominal += newSummaryItem.totalNominal
                summary.summaries.append(newSummaryItem)
                
                isFound = true
                try? context.save()
                break
            }
        }
        
        if !isFound {
            context.insert(
                Summary(
                    date: date,
                    totalNominal: newSummaryItem.totalNominal,
                    summaries: [newSummaryItem]
                )
            )
        }
    }
}
