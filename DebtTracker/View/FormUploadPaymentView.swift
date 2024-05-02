//
//  FormUploadPaymentView.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import SwiftUI

struct FormUploadPaymentView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Person Name")
                Spacer()
                Text("Rp Nominal")
            }
            if let image = selectedImage {
                Button(action: {self.isImagePickerPresented.toggle()}) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .frame(width: .infinity)
                }
            }
            else {
                Button(action: {self.isImagePickerPresented.toggle()}) {
                    VStack {
                        Image(systemName: "photo.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                        Text("Upload Payment Receipt")
                    }.padding([.vertical, .horizontal], 70)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(.blue)
                )
                .cornerRadius(9)
            }
            Button(action: {}) {
                Text("Confirm Payment")
                    .padding([.horizontal], 114)
                    .padding([.vertical])
                    .background(
                        selectedImage == nil
                        ? Color.gray.opacity(0.5)
                        : Color.blue
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

#Preview {
    FormUploadPaymentView()
}
