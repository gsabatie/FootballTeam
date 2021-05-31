//
//  TeamDetailPresenter.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 30/05/2021.
//

import XCTest
import Quick
import Nimble
import Combine
@testable import FootballTeam

class TeamDetailPresenterSpec: QuickSpec {

    var bag: Set<AnyCancellable> = []

    override func spec() {
        describe("initialization") {
            it("should update the team publisher") {
                let teamMock = self.createTeam()
                let interactorMock = TeamDetailInteractorMock(team: teamMock)
                let presenter = TeamDetailPresenter(interactor: interactorMock, viewController: UIViewController())

                waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                    presenter.$teamDescription.sink { teamDescription in
                        expect(teamDescription.description) == "big description"
                        done()
                    }.store(in: &self.bag)
                }

                waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                    presenter.$teamHeaderCellRepresentation.sink { teamHeader in
                        expect(teamHeader.bannerImageUrl) == URL(string: "www.test.com")!
                        expect(teamHeader.league) == "Ligue 1"
                        expect(teamHeader.country) == "french"
                        done()
                    }.store(in: &self.bag)
                }
            }
        }
    }

}

extension TeamDetailPresenterSpec {
    func createTeam(identifier: String = "12345",
                    name: String = "OL",
                    teamBannerURL: URL = URL(string: "www.test.com")!,
                    description: String = "big description",
                    country: String = "french",
                    teamBadgeImageURL: URL? = URL(string: "www.test.com")!,
                    league: String = "Ligue 1") -> TeamDetailMock {
        return TeamDetailMock(identifier: identifier,
                              name: name,
                              teamBannerURL: teamBannerURL,
                              description: description,
                              country: country,
                              teamBadgeImageURL: teamBadgeImageURL,
                              league: league)
    }
}
