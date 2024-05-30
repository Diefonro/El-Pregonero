//
//  ClassInfo.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import UIKit

protocol StoryboardInfo {
    static var storyboard: String { get }
    static var identifier: String { get }
}

protocol CellInfo {
    static var reuseIdentifier: String { get }
}
