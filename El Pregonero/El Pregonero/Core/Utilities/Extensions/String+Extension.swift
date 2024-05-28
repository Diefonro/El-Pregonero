//
//  String+Extension.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import Foundation

extension String {
    func capitalizeFirstCharacter() -> String {
        guard let firstCharacter = self.first else {
            return self
        }
        return firstCharacter.uppercased()
    }
    
    func capitalizeFirstCharacterFull() -> String {
        guard let firstCharacter = self.first else {
            return self
        }
        let remainingString = self.dropFirst()
        return firstCharacter.uppercased() + remainingString
    }
    
    func toDate(withFormats formats: [String] = ["dd/MM/yyyy HH:mm:ss", "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'", "yyyy-MM-dd'T'HH:mm:ss'Z'"]) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        for format in formats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: self) {
                return date
            }
        }
        return nil
    }
}

