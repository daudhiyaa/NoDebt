//
//  ContentView.swift
//  DebtTracker
//
//  Created by Daud on 26/04/24.
//

import SwiftUI

struct SummaryView: View {
    var filterTags: [String] = ["Day", "Week", "Month", "Year"]
    
    let summaries = [
        Summary(
            date: Date(),
            totalNominal: 100000,
            summaries: [
                SummaryItem(
                    activityName: "Activity 1",
                    category: "Category 1",
                    totalNominal: 30000.0,
                    groupName: "Group 1",
                    persons: [
                        Person(name: "Person 1", nominal: 10000.0),
                        Person(name: "Person 2", nominal: 20000.0),
                    ]
                ),
                SummaryItem(
                    activityName: "Activity 2",
                    category: "Category 2",
                    totalNominal: 70000.0,
                    groupName: "Group 2",
                    persons: [
                        Person(name: "Person 3", nominal: 30000.0),
                        Person(name: "Person 4", nominal: 40000.0),
                    ]
                )
            ]
        ),
        Summary(
            date: Date(),
            totalNominal: 100000,
            summaries: [
                SummaryItem(
                    activityName: "Activity 1",
                    category: "Category 1",
                    totalNominal: 30000.0,
                    groupName: "Group 1",
                    persons: [
                        Person(name: "Person 1", nominal: 10000.0),
                        Person(name: "Person 2", nominal: 20000.0),
                    ]
                ),
                SummaryItem(
                    activityName: "Activity 2",
                    category: "Category 2",
                    totalNominal: 70000.0,
                    groupName: "Group 2",
                    persons: [
                        Person(name: "Person 3", nominal: 30000.0),
                        Person(name: "Person 4", nominal: 40000.0),
                    ]
                )
            ]
        ),
    ]
    
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
                
                // SEGMENTED CONTROL => FILTER BY DATE
                Picker("Filter", selection: $filterBy) {
                    ForEach(filterTags, id: \.self) { tag in
                        Text(tag).tag(tag)
                    }
                }.pickerStyle(.segmented)
                
                // SECTION SUMMARY
                ForEach(summaries.indices, id: \.self) {
                    index in
                    Section {
                        ForEach(summaries) { summary in
                            SummaryList(
                                summary: summary.summaries[index]
                            )
                        }
                    } header: {
                        HStack{
                            Text("\(formatDate(date: summaries[index].date))")
                            Spacer()
                            Text(formatToIDR(summaries[index].totalNominal))
                        }
                    }
                }
            })
            .navigationBarTitle("Summary", displayMode: .automatic)
            .navigationBarItems(
                trailing: Button(action: {
                    self.isSheetPresented = true
                }) {
                    Image(systemName: "plus").foregroundColor(.cyan)
                }.popover(isPresented: $isSheetPresented) {
                    NavigationView {
                        FormAddView(isSheetPresented: $isSheetPresented)
                    }
                }
            )
        }
    }
}


#Preview {
    SummaryView()
}
