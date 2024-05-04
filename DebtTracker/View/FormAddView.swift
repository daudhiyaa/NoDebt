//
//  FormAddView.swift
//  DebtTracker
//
//  Created by Daud on 01/05/24.
//

import SwiftUI
import SwiftData

struct FormAddView: View {
    @Binding var isSheetPresented: Bool
    @State var isSheetAddCategoryPresented: Bool = false
    
    @Query private var categories: [Category]
    @State private var selectedCategory: Category = Category(title: "Makan", icon: "fork.knife.circle")
    
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
                        Text("Credit")
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
                        Text("Debit")
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
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    } else {
                        Button("Select Image") {
                            self.isImagePickerPresented.toggle()
                        }
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: self.$selectedImage)
                }
                
            }.textInputAutocapitalization(.never).disableAutocorrection(true)
            
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
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { tag in
                        HStack {
                            Text(tag.title)
                            Image(systemName: tag.icon)
                        }.tag(tag)
                    }
                }.pickerStyle(.menu)
//                LazyVGrid(columns: Array(repeating: GridItem(), count: 4), spacing: 20) {
//                    ForEach(categories) { card in
//                        CategoryCard(card: card)
//                    }
//                }.padding(EdgeInsets(
//                    top: 10, leading: 0, bottom: 10, trailing: 0
//                ))
            } header: {
                HStack(content: {
                    Text("Categories")
                    Spacer()
                    Button(action: {
                        isSheetAddCategoryPresented = true
                    }) {
                        Image(systemName: "plus.circle").foregroundColor(.teal)
                    }.popover(isPresented: $isSheetAddCategoryPresented) {
                        NavigationView {
                            FormAddCategoryView(
                                isSheetAddCategoryPresented: $isSheetAddCategoryPresented
                            )
                        }
                    }
                })
            }
            
            Button(action: {
                // print("Button tapped")
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
        .navigationBarTitle("New Note", displayMode: .inline)
        .navigationBarItems(
            trailing:Button("Cancel"){
                isSheetPresented = false
            }.foregroundColor(.red)
        )
    }
}

#Preview {
    FormAddView(isSheetPresented: .constant(false))
}
