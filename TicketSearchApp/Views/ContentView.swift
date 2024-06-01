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
        NavigationStack(path: $coordinator.path) {
            coordinator.getView(AppViews.home)
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.getSheet(sheet)
                }
                .navigationDestination(for: AppViews.self) { view in
                    coordinator.getView(view)
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Coordinator())
}
