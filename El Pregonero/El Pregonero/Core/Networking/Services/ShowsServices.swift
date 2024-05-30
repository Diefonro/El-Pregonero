//
//  ShowsServices.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

protocol ShowsServiceable {
    func getShows() async -> Result<Shows, RequestError>
}

class ShowsServices: HTTPClient, ShowsServiceable {
    func getShows() async -> Result<Shows, RequestError> {
        return await sendRequest(endpoint: ShowsEndpoint.shows, responseModel: Shows.self)
    }
}
