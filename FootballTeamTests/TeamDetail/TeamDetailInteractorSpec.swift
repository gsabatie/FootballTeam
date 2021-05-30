//
//  TeamDetailInteractorSpec.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 30/05/2021.
//

import XCTest
import Quick
import Nimble
import Combine
@testable import FootballTeam

class TeamDetailInteractorSpec: QuickSpec {

    var bag: Set<AnyCancellable> = []

    override func spec() {
        describe("initialization") {
            it("should update the team publisher") {
                let teamMock = self.createTeam()
                let interactor = TeamDetailInteractor(team: teamMock)

                waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                    interactor.$team.sink { team in
                        expect(team.identifier) == "12345"
                        expect(team.name) == "OL"
                        expect(team.teamBannerURL) == URL(string: "www.test.com")
                        expect(team.description) == "big description"
                        expect(team.country) == "french"

                        done()
                    }.store(in: &self.bag)
                }
            }
        }
    }
}

extension TeamDetailInteractorSpec {
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
