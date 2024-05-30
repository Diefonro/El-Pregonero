//
//  CustomSearchBar.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import UIKit

struct CustomMainSearchBar {
    
    static func customizeSearchBar(with searchBar: UISearchBar) {
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField,
           let customIconImage = UIImage(named: "MagnifyingGlassLogo") {
            let iconSize = CGSize(width: 25, height: 25)
            UIGraphicsBeginImageContextWithOptions(iconSize, false, 0.0)
            customIconImage.draw(in: CGRect(x: 0, y: 0, width: iconSize.width, height: iconSize.height))
            
            if let resizedIconImage = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                let iconImageView = UIImageView(image: resizedIconImage)
                iconImageView.contentMode = .center
                searchTextField.leftView = iconImageView
                searchTextField.leftViewMode = .always
                searchTextField.backgroundColor = .clear
                
                let textAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "HelveticaNeue-Semibold", size: 16.5) ?? UIFont.systemFont(ofSize: 16.5),
                    .foregroundColor: UIColor.gray
                ]
                searchTextField.defaultTextAttributes = textAttributes
            }
        }
        let defaultPlaceholder = "Search a new"
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.placeholder = defaultPlaceholder
    }
}
