//
//  Int + PriceFormatted.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 04.06.2024.
//

import Foundation

extension Int {
    func priceFormatted() -> String {
        self.formatted().replacingOccurrences(of: ",", with: " ")
    }
}
