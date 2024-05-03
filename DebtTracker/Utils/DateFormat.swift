//
//  DateFormat.swift
//  DebtTracker
//
//  Created by Daud on 02/05/24.
//

import Foundation

func formatDate(date: Date, dateFormat:String = "EE, d MMMM yy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: date)
}
