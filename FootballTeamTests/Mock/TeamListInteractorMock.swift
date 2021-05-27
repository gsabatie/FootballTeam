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

    @Published var teams: [ListTeamsTeam] = []

    var teamsPublished: Published<[ListTeamsTeam]> { _teams }
    var teamsPublisher: Published<[ListTeamsTeam]>.Publisher { $teams }

    // MARK: - Properties
    var searchedTeams: [ListTeamsTeamMock]!

    func getAllTeamsFromLeague(leagueSearchScope: String) {
        teams = searchedTeams
    }
}
