//
//  SearchSheet.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI

struct SearchSheet: View {
    
    // MARK: - ViewModel
    @StateObject var model: SearchSheetViewModel
    
    // MARK: - Private constants
    private let searchViewHeight = 90.0
    private let actionCellImageHeight = 48.0
    private let actionCellImageWidth = 48.0
    private let suggestionCellImageHeight = 40.0
    private let suggestionCellImageWidth = 40.0
    private let actionsViewHeight = 114.0
    private let actionFontSize = 14.0
    
    // MARK: - dismissal action
    @Environment(\.dismiss) var dismiss
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
                VStack {
                    HStack {
                        Image("planeIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                        TextField("",
                                  text: $model.departureCity,
                                  prompt: Text(model.strings.departureCityPrompt)
                            .foregroundColor(.gray)
                        )
                    }
                    Divider()
                        .background(Color(hex: "#9F9F9F"))
                    HStack {
                        Image("magnifierIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                        TextField("",
                                  text: $model.arrivalCity,
                                  prompt: Text(model.strings.arrivalCityPrompt)
                            .foregroundColor(.gray)
                        )
                        .onSubmit() {
                            dismiss()
                            model.userEnteredArrivalCity()
                        }
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 24, height: 24)
                    }
                }
                .padding()
                .frame(height: searchViewHeight) // TODO: handle size
                .background {
                                RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: "#3E3F43"))
                                    .shadow(radius: 2, y: 2)
                            }
            .padding(16)
            .background {
                            RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: "#2F3035"))
                                .shadow(radius: 2, y: 2)
                        }
            .padding()
            HStack {
                ForEach(model.actions, id: \.self.text) { action in
                    VStack(alignment: .center) {
                        Image(action.imagename)
                            .resizable()
                            .frame(width: actionCellImageWidth, height: actionCellImageHeight)
                        Text(action.text)
                            .font(.custom(model.fontName, size: actionFontSize))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 114)
                    .onTapGesture {
                        action.action()
                    }
                }
                .listStyle(.plain)
            }
//            .frame(height: scrollViewHeight)
            VStack {
                ForEach(model.suggestions, id: \.self.text) { suggestion in
                    VStack {
                        HStack {
                            Image(suggestion.imagename)
                                .resizable()
                                .scaledToFill()
                                .frame(width: suggestionCellImageWidth, height: suggestionCellImageHeight)
                                .clipped()
                            VStack(alignment: .leading) {
                                Text(suggestion.text)
                                    .bold() // TODO: handle text appearance
                                Text(model.strings.popularDestination)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.top, 6)
                        Divider()
                            .background(Color(hex: "#9F9F9F"))
                    }
                    .onTapGesture {
                        dismiss()
                        model.arrivalCity = suggestion.text
                        model.userEnteredArrivalCity()
                    }
                }
            }
            .padding()
            .background {
                            RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: "#2F3035"))
                                .shadow(radius: 2, y: 2)
                        }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SearchSheet(model: SearchSheetViewModel(coordinator: Coordinator()))
        .preferredColorScheme(.dark)
}
