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

    var errorMessageSubject: PassthroughSubject<String, Never> { get }

    /// Search the league from the `searchScope`
    /// - Parameter searchScope: `String` searchScope
    func searchLeague(searchScope: String)

    /// Function triggered when a teamCellRepresentation is selected
    /// - Parameter index: `Int` index of the teamCellRepresentation selected
    func didSelectItem(at index: Int)
}

final class TeamListPresenter: TeamListPresenterProtocol {

    // MARK: - VIPER

    let interactor: TeamListInteractorProtocol
    let router: TeamListRouterProtocol
    weak var viewController: UIViewController?

    // MARK: - TeamListPresenterProtocol properties

    @Published var teamCellRepresentations: [TeamCellRepresentation] = []

    var teamCellRepresentationsPublished: Published<[TeamCellRepresentation]> { _teamCellRepresentations }
    var teamCellRepresentationsPublisher: Published<[TeamCellRepresentation]>.Publisher { $teamCellRepresentations }

    var errorMessageSubject: PassthroughSubject<String, Never>

    // MARK: - Properties

    var bag: Set<AnyCancellable> = []

    // MARK: - Initializer

    init(interactor: TeamListInteractorProtocol, router: TeamListRouterProtocol) {
        self.interactor = interactor
        self.router = router

        self.errorMessageSubject = .init()

        interactor
            .teamsPublisher
            .map { teams in
                teams.map { team in
                    return TeamCellRepresentation(teamIdentifier: team.identifier, badgeImageURL: team.teamBadgeImageURL)
                }
            }
            .assign(to: \.teamCellRepresentations, on: self)
            .store(in: &bag)

        interactor
            .errorSubject
            .sink { [weak self] error in
                self?.errorMessageSubject.send(error.localizedDescription)
            }
            .store(in: &bag)
    }

    // MARK: - TeamListPresenterProtocol

    func searchLeague(searchScope: String) {
        guard !searchScope.isEmpty else { return }

        interactor.getAllTeamsFromLeague(leagueSearchScope: searchScope)
    }

    func didSelectItem(at index: Int) {
        guard let viewController = viewController else { return }

        router.pushDetailViewController(from: viewController, team: interactor.teams[index])
    }
}
