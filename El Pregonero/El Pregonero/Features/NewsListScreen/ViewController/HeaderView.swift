//
//  HeaderView.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.text = "This is a header"
        return label
    }()
    
    var didTapOnViewAll: ((_ navTitle: String) -> Void)?
    var navTitle: String? = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(label)
        
        label.frame = CGRect(x: 10, y: 0, width: frame.size.width - 110, height: 35)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
