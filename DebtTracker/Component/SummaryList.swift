//
//  CustomListItemView.swift
//  DebtTracker
//
//  Created by Daud on 01/05/24.
//

import SwiftUI

struct SummaryList: View {
    let summary: SummaryItem
    
    var body: some View {
        NavigationLink(destination: DetailView(summary: summary)) {
            HStack {
                Image(systemName: "fork.knife.circle")
                    .foregroundColor(.cyan)
                VStack(alignment: .leading, content: {
                    Text(summary.activityName).font(.subheadline)
                    Text(summary.category).font(.system(size: 12))
                })
                Spacer()
                VStack(alignment: .trailing, content: {
                    Text(formatToIDR(summary.totalNominal)).font(.callout)
                    Text(summary.groupName).font(.system(size: 12))
                })
            }
        }.padding(.vertical, 8)
    }
}
