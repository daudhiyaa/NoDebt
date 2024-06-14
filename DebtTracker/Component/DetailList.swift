//
//  DetailList.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import SwiftUI

struct DetailList: View {
    let person: Person
    let isCredit: Bool
    
    var body: some View {
        NavigationLink(destination: FormUploadPayment(person: person)) {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(person.isPaid ? Color.teal : Color.gray.opacity(0.5))
                Text(person.name).font(.callout)
                Spacer()
                Text(formatToIDR(person.nominal))
                    .foregroundStyle(isCredit ? Color.teal : Color.red)
                    .font(.callout)
            }
        }.padding(.vertical, 8)
    }
}

#Preview {
    DetailList(
        person: Person(name: "Person Name", nominal: 10000, isPaid: false),
        isCredit: false
    )
}
