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
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Ver todos", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        return button
    }()
    
    var didTapOnViewAll: ((_ navTitle: String) -> Void)?
    var navTitle: String? = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(label)
        addSubview(button)
        
        label.frame = CGRect(x: 10, y: 0, width: frame.size.width - 110, height: 35)
        button.frame = CGRect(x: frame.size.width - 100, y: 0, width: 90, height: 35)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        self.didTapOnViewAll?(navTitle!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
