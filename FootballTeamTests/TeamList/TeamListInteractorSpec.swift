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

                context("Remote data source send an error") {
                    it("should send an error") {
                        var mock = TeamRemoteDataStoreMock()
                        mock.error = NSError(domain: "Server", code: 500, userInfo: nil)
                        mock.teams = []

                        let interractor = TeamListInteractor(remoteDataSource: mock)

                        interractor.errorSubject.sink { error in
                            expect(error.localizedDescription) == "The operation couldn’t be completed. (Server error 500.)"

                        }.store(in: &self.bag)

                        interractor.getAllTeamsFromLeague(leagueSearchScope: "League 4")
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
                    teamBannerURL: URL = URL(string: "www.test.com")!,
                    description: String = "big description",
                    country: String = "french") -> TeamMock {
        return TeamMock(identifier: identifier,
                    name: name,
                    league: league,
                    teamBadgeImageURL: teamBannerURL,
                    teamBannerURL: teamBannerURL,
                    description: description,
                    country: country)
    }
}
