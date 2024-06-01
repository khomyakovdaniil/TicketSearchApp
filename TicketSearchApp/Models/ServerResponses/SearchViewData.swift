//
//  SearchViewData.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation

struct SearchViewData: Codable {
    
    let ticketsOffers: [TicketOffer]

    enum CodingKeys: String, CodingKey {
        case ticketsOffers = "tickets_offers"
    }
    
    struct TicketOffer: Codable {
        let id: Int
        let title: String
        let timeRange: TimeRange
        let price: Price

        enum CodingKeys: String, CodingKey {
            case id
            case title
            case timeRange = "time_range"
            case price
        }
        
        struct TimeRange: Codable {
            let times: [String]
        }

        struct Price: Codable {
            let value: Int
        }
    }
}
