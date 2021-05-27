//
//  TeamListInteractorSpec.swift
//  FootballTeamTests
//
//  Created by Guillaume Sabatie on 28/05/2021.
//

import XCTest
import Quick
import Nimble
import Combine
@testable import FootballTeam

class TeamListInteractorSpec: QuickSpec {

    var bag: Set<AnyCancellable> = []

    override func spec() {

        describe("searchTeam") {
            context("previous text empty") {
                context("valid search scope") {
                    it("should update the list teams") {
                        var mock = TeamRemoteDataStoreMock()
                        mock.teams = [self.createTeam(), self.createTeam(identifier: "123456")]

                        let interractor = TeamListInteractor(remoteDataSource: mock)
                        interractor.getAllTeamsFromLeague(leagueSearchScope: "League 1")

                        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in

                            interractor.$teams.sink(receiveValue: { teams in
                                expect(teams.count) == 2
                                expect(teams[0].identifier) == "12345"
                                expect(teams[1].identifier) == "123456"
                                
                                done()
                            }).store(in: &self.bag)
                        }
                    }
                }

                context("invalid search scope") {
                    it("should return an empty list") {
                        var mock = TeamRemoteDataStoreMock()
                        mock.teams = []

                        let interractor = TeamListInteractor(remoteDataSource: mock)
                        interractor.getAllTeamsFromLeague(leagueSearchScope: "League 4")

                        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in

                            interractor.$teams.sink(receiveValue: { teams in
                                expect(teams).to(beEmpty())

                                done()
                            }).store(in: &self.bag)
                        }
                    }
                }
            }
        }
    }
}

extension TeamListInteractorSpec {
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
