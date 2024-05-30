//
//  UsersServices.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import Foundation

protocol UsersServiceable {
    func getUsers() async -> Result<Users, RequestError>
    func getPictures()  async -> Result<Results, RequestError>
}

class UsersServices: HTTPClient, UsersServiceable {
    func getUsers() async -> Result<Users, RequestError> {
        return await sendRequest(endpoint: UsersEndpoint.users, responseModel: Users.self)
    }
    
    func getPictures() async -> Result<Results, RequestError> {
        return await sendRequest(endpoint: UsersEndpoint.pictures, responseModel: Results.self)
    }
}
