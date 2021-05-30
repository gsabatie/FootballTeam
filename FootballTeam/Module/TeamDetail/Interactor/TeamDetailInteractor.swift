//
//  TeamDetailInteractot.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 30/05/2021.
//

import Foundation

protocol TeamDetailInteractorProtocol {
    var team: TeamProtocol { get }

    var teamPublished: Published<TeamProtocol> { get }
    var teamPublisher: Published<TeamProtocol>.Publisher { get }

}

final class TeamDetailInteractor: TeamDetailInteractorProtocol {

    // MARK: - TeamDetailInteractorProtocol
    @Published private(set) var team: TeamProtocol

    var teamPublished: Published<TeamProtocol> { _team }

    var teamPublisher: Published<TeamProtocol>.Publisher { $team }

    // MARK: - initializer

    init(team: TeamProtocol) {
        self.team = team
    }
}
