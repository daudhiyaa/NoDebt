//
//  ContentView.swift
//  DebtTracker
//
//  Created by Daud on 26/04/24.
//

import SwiftUI

struct SummaryView: View {
    let filterTags: [String] = ["Day", "Week", "Month", "Year"]
    
    let summariesData = [
        Summary(
            date: Date(),
            totalNominal: 100000,
            summaries: [
                SummaryItem(
                    activityName: "Activity 1",
                    category: "Category 1",
                    totalNominal: 30000.0,
                    groupName: "Group 1",
                    isCredit: true,
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
                    isCredit: false,
                    persons: [
                        Person(name: "Person 3", nominal: 30000.0),
                        Person(name: "Person 4", nominal: 40000.0),
                    ]
                ),
                SummaryItem(
                    activityName: "Activity 3",
                    category: "Category 3",
                    totalNominal: 140000.0,
                    groupName: "Group 3",
                    isCredit: true,
                    persons: [
                        Person(name: "Person 5", nominal: 30000.0),
                        Person(name: "Person 6", nominal: 40000.0),
                        Person(name: "Person 5", nominal: 30000.0),
                        Person(name: "Person 6", nominal: 40000.0),
                    ]
                )
            ]
        ),
        Summary(
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            totalNominal: 100000,
            summaries: [
                SummaryItem(
                    activityName: "Activity 1",
                    category: "Category 1",
                    totalNominal: 30000.0,
                    groupName: "Group 4",
                    isCredit: false,
                    persons: [
                        Person(name: "Person 1", nominal: 10000.0),
                        Person(name: "Person 2", nominal: 20000.0),
                    ]
                ),
                SummaryItem(
                    activityName: "Activity 2",
                    category: "Category 2",
                    totalNominal: 70000.0,
                    groupName: "Group 5",
                    isCredit: false,
                    persons: [
                        Person(name: "Person 3", nominal: 30000.0),
                    ]
                )
            ]
        ),
    ]
    
    @State private var filterBy: String = "Day"
    @State private var isSheetPresented = false
    @State private var isCredit = true
    
    var body: some View {
        NavigationStack {
            List(content: {
                HStack(content: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isCredit ? Color.teal : Color.gray)
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading, content: {
                            Text("Credit")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                            Text("Nominal")
                                .foregroundColor(.white)
                        })
                    }.onTapGesture {
                        isCredit = true
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isCredit ? Color.gray : Color.red.opacity(0.8))
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading, content: {
                            Text("Debit")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                            Text("Nominal")
                                .foregroundColor(.white)
                        })
                    }.onTapGesture {
                        isCredit = false
                    }
                })
                
                // SEGMENTED CONTROL => FILTER BY DATE
                Picker("Filter", selection: $filterBy) {
                    ForEach(filterTags, id: \.self) { tag in
                        Text(tag).tag(tag)
                    }
                }.pickerStyle(.segmented)
                
                // SECTION SUMMARY
                ForEach(summariesData) { summary in
                    Section {
                        ForEach(summary.summaries) { s in
                            SummaryList(
                                summary: s,
                                date: summary.date
                            )
                        }
                    } header: {
                        HStack{
                            Text("\(formatDate(date: summary.date))").font(.body).foregroundColor(.black)
                            Spacer()
                            Text(formatToIDR(summary.totalNominal)).textCase(.none).font(.body).foregroundColor(.black)
                        }
                    }
                }
            })
            .navigationBarTitle("Summary", displayMode: .automatic)
            .navigationBarItems(
                trailing: Button(action: {
                    self.isSheetPresented = true
                }) {
                    Image(systemName: "plus").foregroundColor(.teal)
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
