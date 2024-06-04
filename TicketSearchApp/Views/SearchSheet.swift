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
    //    private let actionsViewHeight = 114.0
    
    // MARK: - dismissal action
    @Environment(\.dismiss) var dismiss
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            LocationsView(departureCity: $model.departureCity,
                          arrivalCity: $model.arrivalCity,
                          departureCityPrompt: model.strings.departureCityPrompt,
                          arrivalCityPrompt: model.strings.arrivalCityPrompt) {
                dismiss()
                model.userEnteredArrivalCity()
            }
                          .padding()
            HStack(spacing: 0) {
                ForEach(model.actions, id: \.self.text) { action in
                    ActionView(action)
                }
            }
            .padding(.top)
            VStack {
                ForEach(model.suggestions, id: \.self.text) { suggestion in
                    SuggestionView(popularDestinationString: model.strings.popularDestination, data: suggestion) {
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
            .padding(.horizontal)
            Spacer()
        }
    }
}

fileprivate struct LocationsView: View {
    
    @Binding var departureCity: String
    @Binding var arrivalCity: String
    
    
    
    private let searchViewHeight = 96.0
    
    let departureCityPrompt: String
    let arrivalCityPrompt: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Image("planeIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
                TextField("",
                          text: $departureCity,
                          prompt: Text(departureCityPrompt)
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
                          text: $arrivalCity,
                          prompt: Text(arrivalCityPrompt)
                    .foregroundColor(.gray)
                )
                .onSubmit() {
                    action()
                }
                Spacer()
                Image(systemName: "xmark")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        arrivalCity = ""
                    }
            }
        }
        .padding()
        .frame(height: searchViewHeight) // TODO: handle size
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#2F3035"))
                .shadow(radius: 2, y: 2)
        }
    }
}

fileprivate struct ActionView: View {
    
    private let imageName: String
    private let text: String
    private let action: @MainActor () -> Void
    private let actionCellImageHeight = 48.0
    private let actionCellImageWidth = 48.0
    private let actionFontSize = 14.0
    
    init(_ data: SearchSheetViewModel.ActionData) {
        imageName = data.imagename
        text = data.text
        action = data.action
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .frame(width: actionCellImageWidth, height: actionCellImageHeight)
            Text(text)
                .font(.system(size: actionFontSize)) // TODO: replace font
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 114)
        .onTapGesture {
            action()
        }
    }
}

fileprivate struct SuggestionView: View {
    
    private let imageName: String
    private let text: String
    private let action: @MainActor () -> Void
    private let popularDestinationString: String
    private let suggestionCellImageHeight = 40.0
    private let suggestionCellImageWidth = 40.0
    
    init(popularDestinationString: String, data: SearchSheetViewModel.SuggestionData, action: @escaping @MainActor () -> Void) {
        imageName = data.imagename
        text = data.text
        self.action = action
        self.popularDestinationString = popularDestinationString
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: suggestionCellImageWidth, height: suggestionCellImageHeight)
                    .clipped()
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(text)
                        .bold() // TODO: handle text appearance
                    Text(popularDestinationString)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.top, 6)
            Divider()
                .background(Color(hex: "#9F9F9F"))
        }
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    SearchSheet(model: SearchSheetViewModel(coordinator: Coordinator()))
        .preferredColorScheme(.dark)
}
