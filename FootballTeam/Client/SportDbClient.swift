//
//  SportDbClient.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 27/05/2021.
//

import Foundation
import Alamofire
import Combine

protocol SportAPIClientProtocol {
    /// Get the teams belonging to the league associated with the search scope
    /// - Parameter searchScope: `String` the search scope
    func getAllTeamsInleague(from searchScope: String) -> AnyPublisher<SearchTeamResponseRepresentation, Error>
}

struct SportsDbClient: SportAPIClientProtocol {

    // MARK: - SportAPIClientProtocol

    func getAllTeamsInleague(from searchScope: String) -> AnyPublisher<SearchTeamResponseRepresentation, Error> {
        return AF.request(SportDBRouter.searchTeamInLeague(searchScope))
            .publishDecodable(type: SearchTeamResponseRepresentation.self)
            .value()
            .print()
            .mapError({ _ in SportDBError.serverError})
            .eraseToAnyPublisher()
    }
}
