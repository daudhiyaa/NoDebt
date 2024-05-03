//
//  CustomListItemView.swift
//  DebtTracker
//
//  Created by Daud on 01/05/24.
//

import SwiftUI

struct SummaryList: View {
    let summary: SummaryItem
    let date: Date
    let isCredit: Bool
    
    var body: some View {
        NavigationLink(destination: DetailView(summary: summary, date: date, isCredit: isCredit)) {
            HStack {
                Image(systemName: "fork.knife.circle")
                    .foregroundColor(.teal)
                VStack(alignment: .leading, content: {
                    Text(summary.activityName).font(.subheadline)
                    Text(summary.category).font(.system(size: 12))
                })
                Spacer()
                VStack(alignment: .trailing, content: {
                    Text(formatToIDR(summary.totalNominal)).font(.callout).foregroundColor(summary.isCredit ? Color.teal : Color.red)
                    Text(summary.groupName).font(.system(size: 12))
                })
            }
        }.padding(.vertical, 8)
    }
}
