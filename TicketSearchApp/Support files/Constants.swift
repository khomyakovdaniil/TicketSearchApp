//
//  Constant.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation

struct Constants {
    
    static let fontName = "SFProDisplay-Bold"
    static let departureCityPrompt = "Откуда - Москва"
    static let arrivalCityPrompt = "Куда - Турция"
    
    struct HomeView {
        let title = "Поиск дешевых авиабилетов"
        let subTitle = "Музыкально отлететь"
        let departureCityPrompt = Constants.departureCityPrompt
        let arrivalCityPrompt = Constants.arrivalCityPrompt
    }
    
    struct SearchSheet {
        
        let popularDestination = "Популярное направление"
        let departureCityPrompt = Constants.departureCityPrompt
        let arrivalCityPrompt = Constants.arrivalCityPrompt
        
        struct ActionTitles {
            let route = "Сложный маршрут"
            let anywhere = "Куда угодно"
            let holiday = "Выходные"
            let hot = "Горячие билеты"
        }
        
        struct SuggestionCities {
            let stambul = "Стамбул"
            let sochi = "Сочи"
            let phucket = "Пхукет"
        }
    
    }
    
    struct SearchView {
        
    }
    
}
