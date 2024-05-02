//
//  ContentView.swift
//  DebtTracker
//
//  Created by Daud on 26/04/24.
//

import SwiftUI

struct SummaryView: View {
    var filterTags: [String] = ["Day", "Week", "Month", "Year"]
    var items = ["Category 1", "Category 2", "Category 3", "Category 4", "Category 5"]
    
    @State var inputName: String = ""
    @State var rating:Int = 0
    @State var filterBy: String = "Day"
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationStack {
            List(content: {
                HStack(content: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.cyan)
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading, content: {
                            Text("Credit")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                            Text("Nominal")
                                .foregroundColor(.white)
                        })
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.8))
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading, content: {
                            Text("Debit")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                            Text("Nominal")
                                .foregroundColor(.white)
                        })
                    }
                })
                
                Picker("Filter", selection: $filterBy) {
                    ForEach(filterTags, id: \.self) { tag in
                        Text(tag).tag(tag)
                    }
                }.pickerStyle(.segmented)
                
                ForEach(0..<2) { index in
                    Section {
                            ForEach(items, id: \.self) { item in
                                SummaryList(title: item)
                            }
                    } header: {
                        HStack(content: {
                            Text("Tanggal")
                            Spacer()
                            Text("Nominal")
                        })
                    }
                }
                
            })
            .navigationBarTitle("Summary", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                self.isSheetPresented = true
            }) {
                Image(systemName: "plus").foregroundColor(.cyan)
            }.popover(isPresented: $isSheetPresented) {
                NavigationView {
                    FormAddView(isSheetPresented: $isSheetPresented)
                }
            })
        }
    }
}


#Preview {
    SummaryView()
}
