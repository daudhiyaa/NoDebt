//
//  FormAddView.swift
//  DebtTracker
//
//  Created by Daud on 01/05/24.
//

import SwiftUI
import SwiftData

struct FormAddActivityView: View {
    @Environment(\.modelContext) private var context
    
    @Binding var isSheetPresented: Bool
    @State var isSheetAddCategoryActivityPresented: Bool = false
    
    @Query private var summaries: [Summary]
    @Query private var categories: [CategoryActivity]
    @State private var selectedCategoryActivity: CategoryActivity?
    
    @State private var isCredit = true
    
    @State private var activityName: String = ""
    @State private var date = Date()
    
    @State private var groupName: String = ""
    @State private var friendsName: [String] = [""]
    @State private var nominals: [String] = [""]
    
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    
    var body: some View {
        Form {
            HStack(content: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isCredit ? Color.teal : Color.gray)
                        .frame(height: 50)
                    VStack(alignment: .leading, content: {
                        Text("Piutang")
                            .foregroundColor(.white)
                    })
                }.onTapGesture {
                    isCredit = true
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isCredit ? Color.gray : Color.red.opacity(0.8))
                        .frame(height: 50)
                    VStack(alignment: .leading, content: {
                        Text("Hutang")
                            .foregroundColor(.white)
                    })
                }.onTapGesture {
                    isCredit = false
                }
            })
            
            Section {
                HStack {
                    Image(systemName: "note.text")
                    Text("Activity Name")
                    Spacer()
                    TextField("Activity Name", text: $activityName)
                        .multilineTextAlignment(.trailing)
                }
                
                DatePicker(
                    selection: $date,
                    displayedComponents: [.date]
                ) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Deadline")
                    }
                }
                .datePickerStyle(.compact)
                
                VStack {
                    if let image = selectedImage {
                        Button(action: {self.isImagePickerPresented.toggle()}){
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(9)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        }
                    } else {
                        Button(action: {self.isImagePickerPresented.toggle()}) {
                            HStack(alignment: .center) {
                                Image(systemName: "photo.badge.plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25)
                                    .foregroundColor(.teal)
                                Text("Upload Payment Receipt")
                                    .foregroundColor(.teal)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .foregroundColor(.teal)
                        )
                        .cornerRadius(9)
                    }
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: self.$selectedImage)
                }
                
            }
            
            Section {
                HStack {
                    Image(systemName: "person.3")
                    Text("Group Name")
                    Spacer()
                    TextField("Group Name", text: $groupName)
                        .multilineTextAlignment(.trailing)
                }
            } header: {
                HStack(content: {
                    Text("Group")
                })
            }
            
            Section {
                ForEach(Array(zip(friendsName.indices, nominals.indices)) , id: \.0) { friendIndex, nominalIndex in
                    HStack (
                        alignment: .lastTextBaseline,
                        content: {
                            HStack {
                                Image(systemName: "person")
                                TextField(
                                    "Person Name",
                                    text: self.$friendsName[friendIndex]
                                )
                            }
                            Spacer()
                            HStack {
                                Image(systemName: "dollarsign.circle")
                                TextField(
                                    "Nominal",
                                    text: self.$nominals[nominalIndex]
                                ).keyboardType(.decimalPad)
                            }
                        }
                    )
                }.onDelete{ indexSet in
                    for index in indexSet {
                        self.friendsName.remove(at: index)
                        self.nominals.remove(at: index)
                    }
                }
            } header: {
                HStack(content: {
                    Text("List of Persons")
                    Spacer()
                    Button(action: {
                        self.friendsName.append("")
                        self.nominals.append("")
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.teal)
                    }
                })
            }
            
            Section {
                Picker("Choose Category", selection: $selectedCategoryActivity) {
                    Text("").tag(nil as CategoryActivity?)
                    ForEach(categories) { category in
                        HStack {
                            Text(category.title)
                            Image(systemName: category.icon)
                        }.tag(Optional(category))
                    }
                }.pickerStyle(.menu)
            } header: {
                HStack(content: {
                    Text("Category")
                    Spacer()
                    Button(action: {
                        isSheetAddCategoryActivityPresented = true
                    }) {
                        Image(systemName: "plus.circle").foregroundColor(.teal)
                    }.popover(isPresented: $isSheetAddCategoryActivityPresented) {
                        NavigationView {
                            FormAddCategoryActivityView(
                                isSheetAddCategoryActivityPresented: $isSheetAddCategoryActivityPresented
                            )
                        }
                    }
                })
            }
            
            Button(action: {
                if activityName != "" || groupName != "" || friendsName != [""] || nominals != [""] {
                    var listOfPersons: [Person] = []
                    var totalNominal: Double = 0.0
                    
                    for (friend, nominal) in zip(friendsName, nominals) {
                        listOfPersons.append(
                            Person(
                                name: friend,
                                nominal: Double(nominal)!,
                                isPaid: false
                            )
                        )
                        
                        totalNominal += Double(nominal)!
                    }
                    
                    totalNominal *= isCredit ? -1 : 1
                    
                    let newSummaryItem = SummaryItem(
                        activityName: activityName,
                        category: CategoryActivity(title: selectedCategoryActivity!.title, icon: selectedCategoryActivity!.icon),
                        totalNominal: totalNominal,
                        groupName: groupName,
                        isCredit: isCredit,
                        persons: listOfPersons
                    )
                    
                    var isFound = false
                    for summary in summaries {
                        if formatDate(date: date) == formatDate(date: summary.date) {
                            summary.totalNominal += newSummaryItem.totalNominal
                            summary.summaries.append(newSummaryItem)
                            
                            isFound = true
                            try? context.save()
                            break
                        }
                    }
                    
                    if !isFound {
                        context.insert(
                            Summary(
                                date: date,
                                totalNominal: newSummaryItem.totalNominal,
                                summaries: [newSummaryItem]
                            )
                        )
                    }
                }
                
                isSheetPresented = false
            }) {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(8) // Add corner radius
            }
            .buttonStyle(PlainButtonStyle())
        }
        .textInputAutocapitalization(.never).disableAutocorrection(true)
        .navigationBarTitle("New Note", displayMode: .inline)
        .navigationBarItems(
            trailing:Button("Cancel"){
                isSheetPresented = false
            }.foregroundColor(.red)
        )
    }
}
