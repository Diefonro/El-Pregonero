//
//  Date+Extension.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import Foundation

extension Date {
    func timeAgoSinceNow() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    func formattedPublishedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
