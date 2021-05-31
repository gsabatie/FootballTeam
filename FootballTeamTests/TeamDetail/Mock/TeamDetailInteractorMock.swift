//
//  TeamDetailInteractorMocl.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 30/05/2021.
//

import Foundation
@testable import FootballTeam

final class TeamDetailInteractorMock: TeamDetailInteractorProtocol {

    // MARK: - TeamDetailInteractorProtocol
    @Published private(set) var team: TeamProtocol

    var teamPublished: Published<TeamProtocol> { _team }

    var teamPublisher: Published<TeamProtocol>.Publisher { $team }

    init(team: TeamDetailMock) {
        self.team = team
    }
}
