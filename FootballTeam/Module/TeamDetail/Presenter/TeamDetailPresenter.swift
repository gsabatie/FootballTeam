//
//  TeamDetailPresenter.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 30/05/2021.
//

import Foundation
import Combine
import UIKit

protocol TeamDetailPresenterProtocol {
    var teamDescription: TeamDescriptionCellRepresentation { get }

    var teamDescriptionPublished: Published<TeamDescriptionCellRepresentation> { get }
    var teamDescriptionPublisher: Published<TeamDescriptionCellRepresentation>.Publisher { get }

    var teamHeaderCellRepresentation: TeamHeaderCellRepresentation { get }

    var teamHeaderCellRepresentationPublished: Published<TeamHeaderCellRepresentation> { get }
    var teamHeaderCellRepresentationPublisher: Published<TeamHeaderCellRepresentation>.Publisher { get }

}

final class TeamDetailPresenter: TeamDetailPresenterProtocol {

    // MARK: - TeamDetailPresenterProtocol
    @Published private(set) var teamDescription: TeamDescriptionCellRepresentation

    var teamDescriptionPublished: Published<TeamDescriptionCellRepresentation> { _teamDescription }

    var teamDescriptionPublisher: Published<TeamDescriptionCellRepresentation>.Publisher { $teamDescription }

    @Published var teamHeaderCellRepresentation: TeamHeaderCellRepresentation

    var teamHeaderCellRepresentationPublished: Published<TeamHeaderCellRepresentation> { _teamHeaderCellRepresentation }
    var teamHeaderCellRepresentationPublisher: Published<TeamHeaderCellRepresentation>.Publisher { $teamHeaderCellRepresentation }

    // MARK: - Properties

    var bag: Set<AnyCancellable> = []

    // MARK: - initializer

    init(interactor: TeamDetailInteractorProtocol, viewController: UIViewController) {
        self.teamDescription = TeamDescriptionCellRepresentation(description: interactor.team.description)

        self.teamHeaderCellRepresentation = TeamHeaderCellRepresentation(
            bannerImageUrl: interactor.team.teamBannerURL,
            country: interactor.team.country,
            league: interactor.team.league)

        interactor
            .teamPublisher
            .map { self.headerFrom(team: $0) }
            .assign(to: \.teamHeaderCellRepresentation, on: self).store(in: &bag)

        interactor
            .teamPublisher
            .map { self.descriptionFrom(team: $0) }
            .assign(to: \.teamDescription, on: self).store(in: &bag)
    }

    func descriptionFrom(team: TeamProtocol) -> TeamDescriptionCellRepresentation {
        return TeamDescriptionCellRepresentation(description: team.description)
    }

    func headerFrom(team: TeamProtocol) -> TeamHeaderCellRepresentation {
        return TeamHeaderCellRepresentation(bannerImageUrl: team.teamBannerURL, country: team.country, league: team.league)
    }
}
