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
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("\(summary.activityName) - \(formatDate(date: date))")
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
