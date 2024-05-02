//
//  DetailList.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import SwiftUI

struct DetailList: View {
    let person: Person
    
    var body: some View {
        NavigationLink(destination: FormUploadPaymentView()) {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.cyan)
                Text(person.name).font(.callout)
                Spacer()
                Text(formatToIDR(person.nominal)).font(.callout)
            }
        }.padding(.vertical, 8)
    }
}

#Preview {
    DetailList(person: Person(name: "Person Name", nominal: 10000))
}
