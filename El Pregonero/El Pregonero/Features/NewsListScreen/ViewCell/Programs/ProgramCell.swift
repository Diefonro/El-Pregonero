//
//  ProgramCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class ProgramCell: UICollectionViewCell, CellInfo{
    
    static var reuseIdentifier = "ProgramCell"

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(url: String?) {
        self.imageView.setImage(from: URL(string: url!)!)
    }
}
