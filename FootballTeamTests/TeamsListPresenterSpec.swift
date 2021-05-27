//
//  TeamsListPresenterSpec.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 28/05/2021.
//

import XCTest
import Quick
import Nimble
@testable import FootballTeam

class TeamsListPresenterSpec: QuickSpec {

    override func spec() {
        describe("serchLeague") {
            context("valid search scope") {
                it("should update the list of teams") {
                    let mock = TeamListInteractorMock()

                    let presenter = TeamListPresenter(interactor: mock, viewController: UIViewController())
                    mock.searchedTeams = [self.createTeam()]

                    presenter.searchLeague(searchScope: "League 1")
                    expect(presenter.teamCellRepresentations) == [TeamCellRepresentation(teamIdentifier: "12345",
                                                                                         badgeImageURL: URL(string: "www.test.com"))]

                }

                context("empty search scope") {
                    let mock = TeamListInteractorMock()

                    let presenter = TeamListPresenter(interactor: mock, viewController: UIViewController())
                    mock.searchedTeams = [self.createTeam()]

                    presenter.searchLeague(searchScope: "")
                    expect(presenter.teamCellRepresentations) == [TeamCellRepresentation(teamIdentifier: "12345",
                                                                                         badgeImageURL: URL(string: "www.test.com"))]
                }
            }
        }
    }

}

extension TeamsListPresenterSpec {
    func createTeam(identifier: String = "12345",
                    name: String = "OL",
                    league: String = "League 1",
                    teamBadgeImageURL: URL = URL(string: "www.test.com")!,
                    description: String = "big description",
                    country: String = "french") -> ListTeamsTeamMock {
        return ListTeamsTeamMock(identifier: identifier,
                    name: name,
                    league: league,
                    teamBadgeImageURL: teamBadgeImageURL,
                    description: description,
                    country: country)
    }
}
