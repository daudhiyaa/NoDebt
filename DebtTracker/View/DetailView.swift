//
//  DetailView.swift
//  DebtTracker
//
//  Created by Daud on 29/04/24.
//

import SwiftUI

struct DetailView: View {
    let summary: SummaryItem
    let date: Date
    let isCredit: Bool
    
    var body: some View {
        List(content: {
            Section {
                ForEach(summary.persons.indices, id: \.self) { index in
                    DetailList(person: summary.persons[index], isCredit: isCredit)
                }
            } header: {
                HStack(content: {
                    VStack(alignment: .leading,content: {
                        Text(summary.groupName)
                            .foregroundColor(.black)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("\(summary.activityName) - \(formatDate(date: date))")
                            .foregroundColor(.black)
                            .font(.caption2)
                    })
                    Spacer()
                    Text(formatToIDR(summary.totalNominal))
                        .font(.body)
                        .foregroundColor(summary.isCredit ? Color.teal : Color.red)
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
                isCredit: false,
                persons: [
                    Person(name: "Person 3", nominal: 30000.0, isPaid: false),
                    Person(name: "Person 4", nominal: 40000.0, isPaid: true),
                ]
            )
        ),
        date: Date(),
        isCredit: false
    )
}
