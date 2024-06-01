//
//  SearchView.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var mockList = ["one", "two", "three"]
    var body: some View {
        VStack {
            List(mockList, id: \.self) { value in
                HStack {
                    Text(value)
                    Spacer()
                    Button {
                        coordinator.showTicketListView()
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                
            }
            Button {
                coordinator.showSearchSheet()
            } label: {
                Text("Show sheet")
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(Coordinator())
}
