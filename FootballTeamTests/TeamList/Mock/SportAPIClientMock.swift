//
//  SportAPIClientMock.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 28/05/2021.
//

import Foundation
import Combine
@testable import FootballTeam

struct SportAPIClientMock: SportAPIClientProtocol {

    var searchTeamResponseRepresentation: SearchTeamResponseRepresentation!

    func getAllTeamsInleague(from searchScope: String) -> AnyPublisher<SearchTeamResponseRepresentation, Error> {
        return Just(searchTeamResponseRepresentation)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
    }

}
