//
//  DetailList.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import SwiftUI

struct DetailList: View {
    var body: some View {
        NavigationLink(destination: DetailView()) {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.cyan)
                Text("Person Name").font(.callout)
                Spacer()
                Text("Nominal").font(.callout)
            }
        }.padding(.vertical, 8)
    }
}

#Preview {
    DetailList()
}
