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
        
        return firstCharacter.uppercased() + self.dropFirst()
    }
    
    func toDate(withFormat format: String = "dd/MM/yyyy HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
}

