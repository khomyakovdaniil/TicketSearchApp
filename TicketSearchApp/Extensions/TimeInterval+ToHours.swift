//
//  TimeInterval+ToHours.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 02.06.2024.
//

import Foundation

extension TimeInterval {
    
    func toHours() -> String {

        let time = Double(NSInteger(self))
        let hours = (time / 3600.0)
        
        return String(hours.rounded(to: 0.5))

    }
}
