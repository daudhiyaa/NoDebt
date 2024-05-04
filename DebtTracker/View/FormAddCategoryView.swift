//
//  FormAddCategoryView.swift
//  DebtTracker
//
//  Created by Daud on 03/05/24.
//

import SwiftUI
import SwiftData

struct FormAddCategoryView: View {
    @Environment(\.modelContext) private var context
    @Binding var isSheetAddCategoryPresented: Bool
    
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
            TextField("Category Name", text: $categoryName).font(.body)
                .textInputAutocapitalization(.never).disableAutocorrection(true)
            Picker("Choose Icon", selection: $categoryIcon) {
                ForEach(categoriesIcon, id: \.self) { tag in
                    Image(systemName: tag).tag(tag)
                }
            }.pickerStyle(.menu)
            Button (action: {
                if(categoryName != "") {
                    insertCategory(title: categoryName, icon: categoryIcon)
                }
            }, label: {
                Text("Save")
            })
        }
        .navigationBarTitle("New Category", displayMode: .inline)
        .navigationBarItems(
            trailing:Button("Cancel"){
                isSheetAddCategoryPresented = false
            }.foregroundColor(.red)
        ).textCase(.none)
    }
    
    func insertCategory(title: String, icon: String) {
        let category = Category(title: categoryName, icon: categoryIcon)
        context.insert(category)
    }
}

#Preview {
    FormAddCategoryView(isSheetAddCategoryPresented: .constant(true))
}
