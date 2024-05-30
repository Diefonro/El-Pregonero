//
//  UsersListScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import UIKit

class UsersListScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "UsersListScreen"
    static var identifier = "UsersListScreenVC"
    
    var viewModel: UserListScreenViewModel?
    var usersCoordinator: UsersListScreenCoordinator?
    var data: User?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var findUsersButton: UIButton!
    @IBOutlet weak var noInfoView: NoInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: UserInfoCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: UserInfoCell.reuseIdentifier)
        findUsersButton.tintColor = .black
        fetchUsers()
    }
    
    func fetchUsers() {
        viewModel?.getUsers {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel?.getUsersPictures {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setViewModel(viewModel: UserListScreenViewModel) {
        self.viewModel = viewModel
    }
    
    func setCoordinator(coordinator: UsersListScreenCoordinator?) {
        self.usersCoordinator = coordinator
    }
    
    func recoverIndexFromArray(with index: Int) -> Int{
        return index
    }
    
    @IBAction func findUsersButtonAction(_ sender: Any) {
        self.usersCoordinator?.pushToUserMap(with: User(id: 0, firstname: "", lastname: "", email: "", birthDate: "", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "0.0", lng: "0.0")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: "")), showAllUsers: true)
    }
    
}

extension UsersListScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.usersPictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.reuseIdentifier) as? UserInfoCell {
            let userData = DataManager.usersData
            self.data = userData[indexPath.row]
            let pictureData = DataManager.usersPictures
            if !userData.isEmpty, !pictureData.isEmpty {
                cell.lottieView.isHidden = true
                cell.configureCell(userData: userData[indexPath.row], pictureData: pictureData [indexPath.item])
            } else {
                cell.lottieView.isHidden = true
                self.findUsersButton.isEnabled = false
            }
           
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userData = DataManager.usersData[indexPath.row]
        self.usersCoordinator?.pushToUserMap(with: userData, showAllUsers: false)
    }
    
    
}
