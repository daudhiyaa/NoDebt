//
//  CardView.swift
//  DebtTracker
//
//  Created by Daud on 01/05/24.
//

import SwiftUI

struct CategoryActivityCard: View {
    let card: CategoryActivity
    
    var body: some View {
        VStack {
            Image(systemName: card.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.teal)
            
            Text(card.title)
                .font(.caption)
                .foregroundColor(.teal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 3)
    }
}
