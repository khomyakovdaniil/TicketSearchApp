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
            let vm = SearchViewModel()
            SearchView()
        case .ticketList:
            let vm = TicketListViewModel()
            TicketListView()
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
