//
//  HomeView.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var model: HomeViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(model.offers?.first?.title ?? "no data")
            Button {
                coordinator.showSearchView()
            } label: {
                Text("show Search view")
            }
            Button {
                coordinator.showSearchSheet()
            } label: {
                Text("show Search sheet")
            }
        }
        .padding()
        .onAppear() {
            model.getData()
        }
    }
}

#Preview {
    HomeView(model: HomeViewModel())
        .environmentObject(Coordinator())
}
