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

    var teams: [ListTeamsTeam]!

    func getAllTeamsFromLeague(leagueSearchScope: String) -> AnyPublisher<[ListTeamsTeam], Error> {
        return Just(teams).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
