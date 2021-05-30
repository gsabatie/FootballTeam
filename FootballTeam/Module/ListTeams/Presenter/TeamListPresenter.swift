//
//  TeamListPresenter.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 28/05/2021.
//

import Foundation
import Combine
import UIKit

protocol TeamListPresenterProtocol {

    var teamCellRepresentations: [TeamCellRepresentation] { get }

    var teamCellRepresentationsPublished: Published<[TeamCellRepresentation]> { get }
    var teamCellRepresentationsPublisher: Published<[TeamCellRepresentation]>.Publisher { get }
    
    /// Search the league from the `searchScope`
    /// - Parameter searchScope: `String` searchScope
    func searchLeague(searchScope: String)
    
    /// Function should
    func viewDidAppeared()
}

final class TeamListPresenter: TeamListPresenterProtocol {

    // MARK: - VIPER

    let interactor: TeamListInteractorProtocol
    let viewController: UIViewController

    // MARK: - TeamListPresenterProtocol properties

    @Published var teamCellRepresentations: [TeamCellRepresentation] = []

    var teamCellRepresentationsPublished: Published<[TeamCellRepresentation]> { _teamCellRepresentations }
    var teamCellRepresentationsPublisher: Published<[TeamCellRepresentation]>.Publisher { $teamCellRepresentations }

    // MARK: - Properties

    var bag: Set<AnyCancellable> = []
    
    // MARK: - Initializer

    init(interactor: TeamListInteractorProtocol, viewController: UIViewController) {
        self.interactor = interactor
        self.viewController = viewController

        interactor
            .teamsPublisher
            .map { teams in
                teams.map { team in
                    return TeamCellRepresentation(teamIdentifier: team.identifier, badgeImageURL: team.teamBadgeImageURL)
                }
            }
            .assign(to: \.teamCellRepresentations, on: self)
            .store(in: &bag)
    }

    // MARK: - TeamListPresenterProtocol

    func searchLeague(searchScope: String) {
        interactor.getAllTeamsFromLeague(leagueSearchScope: searchScope)
    }
    
    func viewDidAppeared() {
        interactor.getAllTeamsFromLeague(leagueSearchScope: "")
    }
}
