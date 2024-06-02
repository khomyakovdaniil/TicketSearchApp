//
//  String+ToDate.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 02.06.2024.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:self+"+0000")
        guard let date else {
            return Date()
        }
        return date
    }
}
