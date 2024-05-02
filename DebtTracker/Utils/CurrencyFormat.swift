//
//  CurrencyFormat.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import Foundation

func formatToIDR(_ number: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "id_ID")
    
    var formattedNumber = formatter.string(from: NSNumber(value: number))
    formattedNumber = formattedNumber?.replacingOccurrences(of: "RP", with: "Rp ")
    
    return formattedNumber!
}
