//
//  TeamRemoteDataStoreMock.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 28/05/2021.
//

import Foundation
import Combine
@testable import FootballTeam

struct TeamRemoteDataStoreMock: TeamRemoteDataStoreProtocol {

    var teams: [TeamProtocol]!
    var error: Error?

    func getAllTeamsFromLeague(leagueSearchScope: String) -> AnyPublisher<[TeamProtocol], Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return Just(teams).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
