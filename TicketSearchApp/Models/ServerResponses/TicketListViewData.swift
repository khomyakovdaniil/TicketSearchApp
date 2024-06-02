//
//  TicketListViewData.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation

struct TicketListViewData: Codable {
    
    let tickets: [Ticket]
    
    struct Ticket: Codable {
        let id: Int
        let badge: String?
        let price: Price
        let providerName: String
        let company: String
        let departure: FlightData
        let arrival: FlightData
        let hasTransfer: Bool
        let hasVisaTransfer: Bool
        let luggage: Luggage?
        let handLuggage: HandLuggage?
        let isReturnable: Bool
        let isExchangable: Bool
        
        enum CodingKeys: String, CodingKey {
            case id
            case badge
            case price
            case providerName = "provider_name"
            case company
            case departure
            case arrival
            case hasTransfer = "has_transfer"
            case hasVisaTransfer = "has_visa_transfer"
            case luggage
            case handLuggage = "hand_luggage"
            case isReturnable = "is_returnable"
            case isExchangable = "is_exchangable"
        }
        
        struct Luggage: Codable {
            let hasLuggage: Bool
            let price: Price?
            
            enum CodingKeys: String, CodingKey {
                case hasLuggage = "has_luggage"
                case price
            }
            
            struct Price: Codable {
                let value: Int
            }
        }
        
        struct HandLuggage: Codable {
            let hasHandLuggage: Bool
            let size: String?
            
            enum CodingKeys: String, CodingKey {
                case hasHandLuggage = "has_hand_luggage"
                case size
            }
        }
        
        struct Price: Codable {
            let value: Int
        }
        
        struct FlightData: Codable {
            let town: String
            let date: String
            let airport: String
        }
    }
}

