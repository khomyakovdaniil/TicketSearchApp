//
//  Date+Formatted.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 02.06.2024.
//

import SwiftUI

extension Date {
    
    func formattedToTextView() -> some View {
        HStack(spacing: 0) {
            Text(self.formattedDate())
                .font(.custom("SFProDisplay-LightItalic", size: 14))
            Text(", \(self.formattedWeekday())")
                .font(.custom("SFProDisplay-LightItalic", size: 14))
                .foregroundColor(Color(hex: "#9F9F9F"))
        }
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.setLocalizedDateFormatFromTemplate("dd MMM")
        return formatter.string(from: self)
    }
    
    func formattedWeekday() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.setLocalizedDateFormatFromTemplate("EEE")
        return formatter.string(from: self).lowercased()
    }
    
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("HH:mm")
        return formatter.string(from: self)
    }
}
