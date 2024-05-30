//
//  UserInfoCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import UIKit

class UserInfoCell: UITableViewCell, CellInfo {
    
    static var reuseIdentifier = "UserInfoCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var lottieView: NLottieAnimation!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("Hi :P user cell")
        self.selectionStyle = .none
        lottieView.changeLottie(lottieName: "Animation - 1717004647484")
    }
    
    func configureCell(userData: User, pictureData: UsersPics) {
        self.userNameLabel.text = "\(userData.firstname.capitalizeFirstCharacterFull()) \(userData.lastname.capitalizeFirstCharacterFull())"
        self.userPhoneLabel.text = userData.phone
        self.userMailLabel.text = userData.email
        self.setupPictures(with: pictureData)
    }
    
    func setupPictures(with data: UsersPics) {
        self.userImageView.setImage(from: URL(string: data.picture.large)!)
    }
}
