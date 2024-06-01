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
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(model.title)
                    .font(.custom("SFPRODISPLAYBOLD", size: 22))
                    .multilineTextAlignment(.center)
                    .frame(width: 172, height: 52)
                    .padding()
                Spacer()
            }
            List {
                TextField("",
                          text: $model.departureCity,
                          prompt: Text("Откуда - Москва")
                    .foregroundColor(.gray)
                )
                TextField("",
                          text: $model.arrivalCity,
                          prompt: Text("Куда - Турция")
                    .foregroundColor(.gray)
                )
                .onTapGesture {
                    coordinator.showSearchSheet()
                }
            }
            .frame(height: 160) // TODO: handle size
            Text(model.subTitle)
                .font(.custom("SFPRODISPLAYBOLD", size: 26))
                .padding(.vertical)
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(model.offers ?? [], id: \.self.id) { offer in
                        VStack(alignment: .leading) {
                            Image("HomeViewImage\(offer.id)")
                                .resizable()
                                .frame(width: 132, height: 132)
                            Text(offer.title)
                            Text(offer.town)
                            Text("\(offer.price.value)")
                        }
                     }
                     .listStyle(.plain)
                }
            }
            .frame(height: 214)
            Spacer()
//            Button {
//                coordinator.showSearchView()
//            } label: {
//                Text("show Search view")
//            }
//            Button {
//                coordinator.showSearchSheet()
//            } label: {
//                Text("show Search sheet")
//            }
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
