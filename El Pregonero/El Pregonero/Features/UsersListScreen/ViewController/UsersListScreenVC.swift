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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var findUsersButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: UserInfoCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: UserInfoCell.reuseIdentifier)
        findUsersButton.backgroundColor = .black
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
    
    @IBAction func findUsersButtonAction(_ sender: Any) {
        
    }
    
}

extension UsersListScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.usersPictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.reuseIdentifier) as? UserInfoCell {
            let userData = DataManager.usersData[indexPath.row]
            let pictureData = DataManager.usersPictures[indexPath.item]
            cell.configureCell(userData: userData, pictureData: pictureData)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
