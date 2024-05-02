//
//  DetailView.swift
//  DebtTracker
//
//  Created by Daud on 29/04/24.
//

import SwiftUI

struct DetailView: View {
    var items = ["Category 1", "Category 2", "Category 3", "Category 4", "Category 5"]
    let summary: SummaryItem
    
    var body: some View {
        List(content: {
            Section {
                ForEach(summary.persons.indices, id: \.self) { index in
                    DetailList(person: summary.persons[index])
                }
            } header: {
                HStack(content: {
                    VStack(alignment: .leading,content: {
                        Text(summary.groupName)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("\(summary.activityName) - Wed, 24 Apr 24")
                            .font(.caption2)
                    })
                    Spacer()
                    Text(formatToIDR(summary.totalNominal))
                })
            }
        }).navigationBarTitle("Detail", displayMode: .inline)
    }
}

#Preview {
    DetailView(
        summary: (
            SummaryItem(
                activityName: "Activity 1",
                category: "Category 1",
                totalNominal: 70000.0,
                groupName: "Group 1",
                persons: [
                    Person(name: "Person 3", nominal: 30000.0),
                    Person(name: "Person 4", nominal: 40000.0),
                ]
            )
        )
    )
}
