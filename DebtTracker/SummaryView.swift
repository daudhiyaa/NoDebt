//
//  ContentView.swift
//  DebtTracker
//
//  Created by Daud on 26/04/24.
//

import SwiftUI
import SwiftData

let filterTags: [String] = ["Day", "Week", "Month", "Year"]

struct SummaryView: View {
    @Query private var summaries: [Summary]
    
    @State private var filterBy: String = "Day"
    @State private var isSheetPresented = false
    @State private var isCredit = true
    @State private var filteredSummaries: [Summary]
    
    init(filterBy: String = "Day", isSheetPresented: Bool = false, isCredit: Bool = true) {
        self.filterBy = filterBy
        self.isSheetPresented = isSheetPresented
        self.isCredit = isCredit
        self.filteredSummaries = []
    }
    
    var body: some View {
        NavigationStack {
            List(content: {
                HStack(content: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isCredit ? Color.teal : Color.gray)
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading, content: {
                            Text("Piutang")
                                .foregroundColor(.white)
//                                .font(.system(size: 12))
//                            Text("Nominal")
//                                .foregroundColor(.white)
                        })
                    }.onTapGesture {
                        isCredit = true
                        filterByIsCredit(summaries, by: isCredit)
                    }

                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isCredit ? Color.gray : Color.red.opacity(0.8))
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading, content: {
                            Text("Hutang")
                                .foregroundColor(.white)
//                                .font(.system(size: 12))
//                            Text("Nominal")
//                                .foregroundColor(.white)
                        })
                    }.onTapGesture {
                        isCredit = false
                        filterByIsCredit(summaries, by: isCredit)
                    }
                })
                
                // SEGMENTED CONTROL => FILTER BY DATE
                Picker("Filter", selection: $filterBy) {
                    ForEach(filterTags, id: \.self) { tag in
                        Text(tag).tag(tag)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: filterBy, { oldValue, newValue in
                    filteredSummaries = filterSummariesByDate(
                        summaries, by: filterBy
                    )
                })
                
                // SECTION SUMMARY
                ForEach(filteredSummaries == [] ? summaries : filteredSummaries) { summary in
                    Section {
                        ForEach(summary.summaries) { s in
                            SummaryList(
                                summary: s,
                                date: summary.date,
                                isCredit: s.isCredit
                            )
                        }
                    } header: {
                        HStack{
                            Text("\(formatDate(date: summary.date))")
                                .font(.body).foregroundStyle(.black)
                            Spacer()
                            Text(formatToIDR(summary.totalNominal))
                                .textCase(.none).font(.body).foregroundStyle(.black)
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
                        FormAddActivityView(isSheetPresented: $isSheetPresented)
                    }
                }
            )
        }
    }
    
    func filterSummariesByDate(_ summaries: [Summary], by filter: String) -> [Summary] {
        let currentDate = Date()
        let calendar = Calendar.current
        
        switch filter {
        case "Day":
            return summaries.filter { calendar.isDate($0.date, inSameDayAs: currentDate) }
        case "Week":
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
            return summaries.filter { calendar.isDate($0.date, equalTo: startOfWeek, toGranularity: .weekOfYear) }
        case "Month":
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
            return summaries.filter { calendar.isDate($0.date, equalTo: startOfMonth, toGranularity: .month) }
        case "Year":
            let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: currentDate))!
            return summaries.filter { calendar.isDate($0.date, equalTo: startOfYear, toGranularity: .year) }
        default:
            return summaries.filter { calendar.isDate($0.date, inSameDayAs: currentDate) }
        }
    }
    
    func filterByIsCredit(_ summaries: [Summary], by filter: Bool) {
        filteredSummaries = summaries.filter { summary in
            for index in 0..<summary.summaries.count {
                let item = summary.summaries[index]
                if ((item.isCredit && filter) || (!item.isCredit && !filter)) {
                    return true
                }
            }
            return false
        }
    }
}


#Preview {
    SummaryView().modelContainer(for: [CategoryActivity.self, Summary.self])
}
