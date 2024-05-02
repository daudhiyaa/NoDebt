//
//  CustomListItemView.swift
//  DebtTracker
//
//  Created by Daud on 01/05/24.
//

import SwiftUI

struct SummaryList: View {
    var activityName: String = "Activity Name"
    var title: String
    var nominal: String = "Nominal"
    var personName: String = "Person Name"
    
    var body: some View {
        NavigationLink(destination: DetailView()) {
            HStack {
                Image(systemName: "fork.knife.circle")
                    .foregroundColor(.cyan)
                VStack(alignment: .leading, content: {
                    Text(activityName).font(.subheadline)
                    Text(title).font(.system(size: 12))
                })
                Spacer()
                VStack(alignment: .trailing, content: {
                    Text(nominal).font(.callout)
                    Text(personName).font(.system(size: 12))
                })
            }
        }.padding(.vertical, 8)
    }
}
