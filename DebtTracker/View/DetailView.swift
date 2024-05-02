//
//  DetailView.swift
//  DebtTracker
//
//  Created by Daud on 29/04/24.
//

import SwiftUI

struct DetailView: View {
    var items = ["Category 1", "Category 2", "Category 3", "Category 4", "Category 5"]
    
    var body: some View {
        Form(content: {
            ForEach(0..<2) { index in
                Section {
                    List {
                        ForEach(items, id: \.self) { item in
                            DetailList()
                        }
                    }
                } header: {
                    HStack(content: {
                        VStack(alignment: .leading,content: {
                            Text("Tanggal").font(.headline)
                            Text("Richeese - Wed, 24 Apr 24").font(.caption2)
                        })
                        Spacer()
                        Text("Nominal")
                    })
                }
            }
        }).navigationBarTitle("Detail", displayMode: .inline)
    }
}

#Preview {
    DetailView()
}
