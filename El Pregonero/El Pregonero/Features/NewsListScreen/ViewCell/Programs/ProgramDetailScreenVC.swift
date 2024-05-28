//
//  ProgramDetailScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import UIKit

class ProgramDetailScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "ProgramDetailScreen"
    static var identifier = "ProgramDetailScreenVC"
    
    var navTitle = ""
    var data: Show?
    var serviceProviders: [Me] = []
    
    @IBOutlet weak var showBannerImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var showTypeLabel: UILabel!
    @IBOutlet weak var showOverviewLabel: UILabel!
    @IBOutlet weak var showReleaseYearLabel: UILabel!
    @IBOutlet weak var showGenresLabel: UILabel!
    @IBOutlet weak var showDirectorsLabel: UILabel!
    @IBOutlet weak var showCastLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    @IBOutlet weak var serviceProviderPicker: UIPickerView!
    @IBOutlet weak var showGoToProviderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = navTitle
        if let data = data {
            setupView(with: data)
            serviceProviderPicker.dataSource = self
            serviceProviderPicker.delegate = self
        }
    }
    
    func setupView(with data: Show) {
        self.showBannerImageView.setImage(from: URL(string: data.getImageSet().getHorizontalPoster().on720())!)
        self.showTitleLabel.text = data.title
        self.showTypeLabel.text = data.showType.capitalizeFirstCharacter()
        self.showOverviewLabel.text = data.overview
        
        let genres = data.getGenres().map { $0.getGenre() }.joined(separator: ", ")
        self.showGenresLabel.text = genres
        
        let directors = data.getDirectors().joined(separator: ", ")
        self.showDirectorsLabel.text = directors
        
        let cast = data.getCast().joined(separator: ", ")
        self.showCastLabel.text = cast
        
        self.serviceProviders = data.getStreamingOptions().getProviders()
        updateButton(for: serviceProviders.first)
    }
    
    func updateButton(for provider: Me?) {
        guard let provider = provider else {
            showGoToProviderButton.setTitle("No Service Available", for: .normal)
            showGoToProviderButton.isEnabled = false
            return
        }
        
        if let price = provider.price?.formatted {
            showGoToProviderButton.setTitle("\(provider.type.rawValue.capitalized) for \(price)", for: .normal)
        } else {
            showGoToProviderButton.setTitle("Watch at \(provider.service.name)", for: .normal)
        }
        
        showGoToProviderButton.isEnabled = true
        showGoToProviderButton.accessibilityHint = provider.link
    }
    
    @IBAction func showGoToProviderButtonAction(_ sender: UIButton) {
        if let link = sender.accessibilityHint, let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}

extension ProgramDetailScreenVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return serviceProviders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return serviceProviders[row].service.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedProvider = serviceProviders[row]
        updateButton(for: selectedProvider)
    }
}


