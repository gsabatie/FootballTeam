//
//  TeamRemoteDataStoreProtocol.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 27/05/2021.
//

import Foundation
import Combine

protocol TeamRemoteDataStoreProtocol {
    /// Get all teams from the given league
    /// - Parameter leagueSearchScope: `String` the league search scope
    func getAllTeamsFromLeague(leagueSearchScope: String) -> AnyPublisher<[TeamProtocol], Error>
}

struct TeamRemoteDataStore: TeamRemoteDataStoreProtocol {

    // MARK: - Properties

    var client: SportAPIClientProtocol

    var bag: Set<AnyCancellable> = []

    // MARK: - Initializer

    init(client: SportAPIClientProtocol) {
        self.client = client
    }

    // MARK: - TeamRemoteDataStoreProtocol

    func getAllTeamsFromLeague(leagueSearchScope: String) -> AnyPublisher<[TeamProtocol], Error> {
        return client.getAllTeamsInleague(from: leagueSearchScope)
                     .map({ representation in
                        return representation.teams?.map({ Team(representation: $0) }) ?? []
                     })
                     .eraseToAnyPublisher()
    }
}
