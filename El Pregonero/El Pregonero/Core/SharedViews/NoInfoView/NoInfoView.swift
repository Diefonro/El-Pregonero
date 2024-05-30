//
//  NoInfoView.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 29/05/2024.
//

import UIKit

class NoInfoView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var titleView: String? {
        get {return titleLbl?.text}
        set {titleLbl.text = newValue}
    }
    
    var descriptionView: String? {
        get {return descriptionLbl?.text}
        set {descriptionLbl.text = newValue}
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
        let nib = UINib(nibName: "NoInfoView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)

    }
}
