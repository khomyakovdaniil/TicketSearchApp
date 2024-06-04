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
    
    struct ContentView {
        static let tab1 = "Авиабилеты"
        static let tab2 = "Отели"
        static let tab3 = "Короче"
        static let tab4 = "Подписки"
        static let tab5 = "Профиль"
    }
    
    struct HomeView {
        static let title = "Поиск дешевых авиабилетов"
        static let subTitle = "Музыкально отлететь"
        static let departureCityPrompt = Constants.departureCityPrompt
        static let arrivalCityPrompt = Constants.arrivalCityPrompt
        static let priceFrom = "от "
    }
    
    struct SearchSheet {
        
        static let popularDestination = "Популярное направление"
        static let departureCityPrompt = Constants.departureCityPrompt
        static let arrivalCityPrompt = Constants.arrivalCityPrompt
        
        struct ActionTitles {
            static  let route = "Сложный маршрут"
            static  let anywhere = "Куда угодно"
            static let holiday = "Выходные"
            static let hot = "Горячие билеты"
        }
        
        struct SuggestionCities {
            static let stambul = "Стамбул"
            static let sochi = "Сочи"
            static let phucket = "Пхукет"
        }
    
    }
    
    struct SearchView {
        static let directFlights = "Прямые рельсы" // TODO: just for lulz, it's written like that in Figma"
        static let showAllTickets = "Посмотреть все билеты"
        static let returnFLight = "обратно"
        static let economy = "эконом"
        static let filters = "фильтры"
    }
    
    struct TicketListView {
        static let direct = " / Без пересадок"
        static let time = "ч в пути"
        static let filter = "Фильтр"
        static let priceChart = "График цен"
    }
    
}
