//
//  TextValidator.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 06.06.2024.
//

import Foundation

class TextValidator: ObservableObject {
    
    init(text: String = "") {
        self.text = text
    }
    
    @Published var text = ""
    
    static var russianAlphabetUppercase = ["А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З","И", "К", "Л", "М", "Н", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь", "Э", "Ю", "Я"]
    static var russianAlpabetLowercase = russianAlphabetUppercase.map {$0.lowercased()}
    static var specialCharacters = [" ", "-"]
    let allowedCharacters = russianAlphabetUppercase + russianAlpabetLowercase + specialCharacters
}
