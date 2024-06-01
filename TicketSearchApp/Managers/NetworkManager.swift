//
//  NetworkManager.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation
import Combine

final class NetworkManager {
    
    static func fetchHomeViewData() -> AnyPublisher<HomeViewData, Never> {
        guard let url = URL(string: Endpoints.homeViewData.url) else {
            return Just(HomeViewData(offers: [])).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {
                $0.data
            }
            .decode(type: HomeViewData.self, decoder: JSONDecoder())
            .catch {
                error in Just(HomeViewData(offers: []))
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static func fetchSearchViewData() -> AnyPublisher<SearchViewData, Never> {
        guard let url = URL(string: Endpoints.searchViewData.url) else {
            return Just(SearchViewData(ticketsOffers: [])).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {
                $0.data
            }
            .decode(type: SearchViewData.self, decoder: JSONDecoder())
            .catch {
                error in Just(SearchViewData(ticketsOffers: []))
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static func fetchTicketListViewData() -> AnyPublisher<TicketListViewData, Never> {
        guard let url = URL(string: Endpoints.ticketListViewData.url) else {
            return Just(TicketListViewData(tickets: [])).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {
                $0.data
            }
            .decode(type: TicketListViewData.self, decoder: JSONDecoder())
            .catch {
                error in Just(TicketListViewData(tickets: []))
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

enum Endpoints {
    case homeViewData
    case searchViewData
    case ticketListViewData
}

extension Endpoints {
    
    var baseUrl: String {
        "https://run.mocky.io/v3"
    }
    
    var path: String {
        switch self {
        case .homeViewData:
            "/214a1713-bac0-4853-907c-a1dfc3cd05fd"
        case .searchViewData:
            "/7e55bf02-89ff-4847-9eb7-7d83ef884017"
        case .ticketListViewData:
            "/670c3d56-7f03-4237-9e34-d437a9e56ebf"
        }
    }
    
    var url: String {
        return baseUrl + path
    }
}
