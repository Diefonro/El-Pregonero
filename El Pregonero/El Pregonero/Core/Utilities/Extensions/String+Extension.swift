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
}

