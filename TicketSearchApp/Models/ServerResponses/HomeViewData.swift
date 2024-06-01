//
//  HomeViewData.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation

struct HomeViewData: Codable {
    
    let offers: [Offer]
    
    struct Offer: Codable {
        let id: Int
        let title: String
        let town: String
        let price: Price
        
        struct Price: Codable {
            let value: Int
        }
    }
}
