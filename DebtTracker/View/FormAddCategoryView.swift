//
//  FormAddCategoryActivityView.swift
//  DebtTracker
//
//  Created by Daud on 03/05/24.
//

import SwiftUI
import SwiftData

struct FormAddCategoryActivityView: View {
    @Environment(\.modelContext) private var context
    @Query private var categories: [CategoryActivity]
    
    @Binding var isSheetAddCategoryActivityPresented: Bool
    
    @State private var categoryName: String = ""
    @State private var categoryIcon: String = "beach.umbrella"
    
    let categoriesIcon: [String] = [
        "beach.umbrella", "fork.knife.circle",
        "macbook.and.iphone", "movieclapper", "photo.on.rectangle",
        "house", "car", "star", "bell", "envelope",
        "person", "moon", "sun.max", "cloud", "leaf",
        "heart", "book", "paperplane", "pencil", "scissors",
        "globe", "hourglass", "camera", "bicycle", "music.note"
    ]
    
    var body: some View {
        Form {
            TextField("CategoryActivity Name", text: $categoryName).font(.body)
                .textInputAutocapitalization(.never).disableAutocorrection(true)
            Picker("Choose Icon", selection: $categoryIcon) {
                ForEach(categoriesIcon, id: \.self) { tag in
                    Image(systemName: tag).tag(tag)
                }
            }.pickerStyle(.menu)
            Button (action: {
                if(categoryName != "") {
                    insertCategoryActivity(title: categoryName, icon: categoryIcon)
                }
            }, label: {
                Text("Save").font(.subheadline)
            })
            
            Section {
                ForEach(categories) { category in
                    HStack {
                        Text(category.title)
                        Image(systemName: category.icon)
                    }.foregroundStyle(.black)
                }
                .onDelete{ indexSet in
                    for index in indexSet {
                        context.delete(categories[index])
                    }
                }
            }
        }
        .navigationBarTitle("New CategoryActivity", displayMode: .inline)
        .navigationBarItems(
            trailing:Button("Cancel"){
                isSheetAddCategoryActivityPresented = false
            }.foregroundColor(.red)
        ).textCase(.none)
    }
    
    func insertCategoryActivity(title: String, icon: String) {
        let category = CategoryActivity(title: categoryName, icon: categoryIcon)
        context.insert(category)
        isSheetAddCategoryActivityPresented = false
    }
}

#Preview {
    FormAddCategoryActivityView(isSheetAddCategoryActivityPresented: .constant(true))
}
