//
//  Coordinator.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI

@MainActor
final class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var view: AppViews = .home
    @Published var sheet: AppSheets?
    
    var arrivalCity: String? // TODO: should have used repository for that
    var flightDate: Date? // TODO: should have used repository for that
    
    func showHomeView() {
        path.removeLast(path.count)
    }
    
    func showSearchView() {
        path.append(AppViews.search)
    }
    
    func showTicketListView() {
        path.append(AppViews.ticketList)
    }
    
    func showSearchSheet() {
        sheet = .search
    }
    
    @ViewBuilder
    func getView(_ view: AppViews) -> some View {
        switch view {
        case .home:
            let vm = HomeViewModel(coordinator: self)
            HomeView(model: vm)
        case .search:
            let vm = SearchViewModel(coordinator: self, arrivalCity: arrivalCity ?? "")
            SearchView(model: vm)
        case .ticketList:
            let vm = TicketListViewModel(coordinator: self, arrivalCity: arrivalCity ?? "", flightDate: flightDate ?? Date())
            TicketListView(model: vm)
        }
    }
    
    @ViewBuilder
    func getSheet(_ sheet: AppSheets) -> some View {
        switch sheet {
        case .search:
            let vm = SearchSheetViewModel(coordinator: self)
            SearchSheet(model: vm)
        }
    }
}

enum AppViews: String, CaseIterable, Identifiable {
    case home, search, ticketList
    
    var id: String { self.rawValue }
}

enum AppSheets: String, CaseIterable, Identifiable {
    case search
    
    var id: String { self.rawValue }
}
