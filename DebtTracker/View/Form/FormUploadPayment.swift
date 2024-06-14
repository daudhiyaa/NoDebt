//
//  FormUploadPaymentView.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import SwiftUI

struct FormUploadPayment: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    let person: Person
    
    var body: some View {
        VStack {
            HStack {
                Text(person.name)
                Spacer()
                Text(formatToIDR(person.nominal))
            }
            if let image = selectedImage {
                Button(action: {self.isImagePickerPresented.toggle()}) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .frame(width: .infinity, height: 150)
                }
            }
            else {
                Button(action: {self.isImagePickerPresented.toggle()}) {
                    VStack {
                        Image(systemName: "photo.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                            .foregroundColor(.teal)
                        Text("Upload Payment Receipt").foregroundColor(.teal)
                    }.padding([.vertical, .horizontal], 70)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(.teal)
                )
                .cornerRadius(9)
            }
            Button(action: {
                /// Action
            }) {
                Text("Confirm Payment")
                    .padding([.horizontal], 114)
                    .padding([.vertical])
                    .background(
                        selectedImage == nil
                        ? Color.gray.opacity(0.5)
                        : Color.teal
                    )
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("Payment Receipt", displayMode: .inline)
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: self.$selectedImage)
        }
    }
}
