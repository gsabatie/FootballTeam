//
//  TeamsListPresenterSpec.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 28/05/2021.
//

import XCTest
import Quick
import Nimble
import Combine
@testable import FootballTeam

class TeamsListPresenterSpec: QuickSpec {

    var bag: Set<AnyCancellable> = []

    override func spec() {
        describe("serchLeague") {
            context("valid search scope") {
                it("should update the list of teams") {
                    let interactorMock = TeamListInteractorMock()
                    let routerMock = TeamListRouterMock()

                    let presenter = TeamListPresenter(interactor: interactorMock, router: routerMock)
                    interactorMock.searchedTeams = [self.createTeam()]

                    presenter.searchLeague(searchScope: "League 1")
                    expect(presenter.teamCellRepresentations) == [TeamCellRepresentation(teamIdentifier: "12345",
                                                                                         badgeImageURL: URL(string: "www.test.com"))]

                }

                context("empty search scope") {
                    it("should not update the list of teams") {
                        let interactorMock = TeamListInteractorMock()
                        let routerMock = TeamListRouterMock()

                        let presenter = TeamListPresenter(interactor: interactorMock, router: routerMock)
                        interactorMock.searchedTeams = []

                        presenter.searchLeague(searchScope: "")
                        expect(presenter.teamCellRepresentations.isEmpty) == true
                    }
                }

                context("interractor sent an error") {
                    it("should send an error message") {
                        let interactorMock = TeamListInteractorMock()
                        let routerMock = TeamListRouterMock()

                        let presenter = TeamListPresenter(interactor: interactorMock, router: routerMock)
                        interactorMock.error = NSError(domain: "Server", code: 500, userInfo: nil)
                        interactorMock.searchedTeams = []

                        presenter
                            .errorMessageSubject
                            .receive(on: DispatchQueue.main)
                            .sink { errorMessage in
                                expect(errorMessage) == "The operation couldn’t be completed. (Server error 500.)"
                            }.store(in: &self.bag)

                        presenter.searchLeague(searchScope: "Ligue 1")

                    }
                }
            }
        }

        describe("didSelectItem") {
            it("should push a detail team") {
                let interactorMock = TeamListInteractorMock()
                let routerMock = TeamListRouterMock()
                let viewController = UIViewController()
                interactorMock.teams = [self.createTeam()]

                let presenter = TeamListPresenter(interactor: interactorMock, router: routerMock)
                presenter.viewController = viewController

                presenter.didSelectItem(at: 0)
                expect(routerMock.pushedTeam?.identifier) == "12345"
            }
        }
    }

}

extension TeamsListPresenterSpec {
    func createTeam(identifier: String = "12345",
                    name: String = "OL",
                    league: String = "League 1",
                    teamBadgeImageURL: URL = URL(string: "www.test.com")!,
                    teamBannerURL: URL = URL(string: "www.test.com")!,
                    description: String = "big description",
                    country: String = "french") -> TeamMock {
        return TeamMock(identifier: identifier,
                    name: name,
                    league: league,
                    teamBadgeImageURL: teamBadgeImageURL,
                    teamBannerURL: teamBannerURL,
                    description: description,
                    country: country)
    }
}
