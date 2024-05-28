//
//  SportsServices.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 27/05/2024.
//

import Foundation

protocol SportsServiceable {
    func getMatches() async -> Result<Matches, RequestError>
}

class SportsServices: HTTPClient, SportsServiceable {
    func getMatches() async -> Result<Matches, RequestError> {
        return await sendRequest(endpoint: SportsEndpoint.matches, responseModel: Matches.self)
    }
}

