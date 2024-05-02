//
//  DateFormat.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import Foundation

func formatDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy" // Define the desired date format
    return dateFormatter.string(from: date)
}

