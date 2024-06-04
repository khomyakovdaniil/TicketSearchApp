//
//  ContentView.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        TabView {
            NavigationStack(path: $coordinator.path) {
                coordinator.getView(AppViews.home)
                    .sheet(item: $coordinator.sheet) { sheet in
                        coordinator.getSheet(sheet)
                    }
                    .navigationDestination(for: AppViews.self) { view in
                        coordinator.getView(view)
                    }
            }
                .tabItem {
                Label("Авиабилеты", image: "tab1")
            }
            PlugView()
                .tabItem {
                    Label("Отели", image: "tab2")
                }
            PlugView()
                .tabItem {
                    Label("Короче", image: "tab3")
                }
            PlugView()
                .tabItem {
                    Label("Подписки", image: "tab4")
                }
            PlugView()
                .tabItem {
                    Label("Профиль", image: "tab5")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
        .environmentObject(Coordinator())
}
