//
//  UserListScreenViewModel.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import UIKit

class UserListScreenViewModel {
    let userServices = UsersServices()
    
    func getUsers(completion: @escaping () -> Void) {
        Task(priority: .userInitiated) {
            let result = await userServices.getUsers()
            switch result {
            case .success(let data):
                DataManager.usersData = data
                completion()
            case .failure(let error):
                AppError.handle(error: error)
            }
        }
    }
    
    func getUsersPictures(completion: @escaping () -> Void) {
        Task(priority: .userInitiated) {
            let result = await userServices.getPictures()
            switch result {
            case .success(let data):
                let results = data.getResults()
                DataManager.usersPictures = results
                completion()
            case .failure(let error):
                AppError.handle(error: error)
            }
        }
    }
}
