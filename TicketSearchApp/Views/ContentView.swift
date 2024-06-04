//
//  ContentView.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    let strings = Constants.ContentView.self
    
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
                    Label(strings.tab1, image: "tab1")
            }
            PlugView()
                .tabItem {
                    Label(strings.tab2, image: "tab2")
                }
            PlugView()
                .tabItem {
                    Label(strings.tab3, image: "tab3")
                }
            PlugView()
                .tabItem {
                    Label(strings.tab4, image: "tab4")
                }
            PlugView()
                .tabItem {
                    Label(strings.tab5, image: "tab5")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
        .environmentObject(Coordinator())
}
