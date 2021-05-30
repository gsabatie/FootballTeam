//
//  TeamListInteractorMock.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 28/05/2021.
//

import Foundation
import Combine
@testable import FootballTeam

final class TeamListInteractorMock: TeamListInteractorProtocol {

    // MARK: - TeamListInteractorProtocol Properties

    @Published var teams: [TeamProtocol] = []

    var teamsPublished: Published<[TeamProtocol]> { _teams }
    var teamsPublisher: Published<[TeamProtocol]>.Publisher { $teams }

    var errorSubject: PassthroughSubject<Error, Never> = .init()

    // MARK: - Properties
    var searchedTeams: [TeamMock]!
    var error: Error?

    func getAllTeamsFromLeague(leagueSearchScope: String) {
        teams = searchedTeams
        if let error = error {
            errorSubject.send(error)
        }
    }
}
