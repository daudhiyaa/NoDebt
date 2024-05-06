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
                }
                .pickerStyle(.segmented)
                .onChange(of: filterBy, { oldValue, newValue in
                    filteredSummaries = filterSummaries(
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
    
    func filterSummaries(_ summaries: [Summary], by filter: String) -> [Summary] {
        let currentDate = Date()
        let calendar = Calendar.current
        
        switch filter {
        case "Day":
            return summaries.filter { calendar.isDate($0.date, inSameDayAs: currentDate) }
        case "Week":
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
            let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
            return summaries.filter { calendar.isDate($0.date, equalTo: startOfWeek, toGranularity: .weekOfYear) }
        case "Month":
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
            let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
            return summaries.filter { calendar.isDate($0.date, equalTo: startOfMonth, toGranularity: .month) }
        case "Year":
            let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: currentDate))!
            let endOfYear = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: startOfYear)!
            return summaries.filter { calendar.isDate($0.date, equalTo: startOfYear, toGranularity: .year) }
        default:
            return summaries.filter { calendar.isDate($0.date, inSameDayAs: currentDate) }
        }
    }
}


#Preview {
    SummaryView()
}
