//
//  TeamRemoteDataStoreTests.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 28/05/2021.
//

import XCTest
import Quick
import Nimble
import Combine
@testable import FootballTeam

class TeamRemoteDataStoreSpec: QuickSpec {
    var mockClient = SportAPIClientMock()
    var bag: Set<AnyCancellable> = []

    override func spec() {
        describe("getTeams") {
            context("empty search scope") {
                it("should return a list of teams") {
                    self.mockClient.searchTeamResponseRepresentation = self.createSearchTeamResponseRepresentation()
                    let remoteDataStore = TeamRemoteDataStore(client: self.mockClient)

                    waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                        remoteDataStore
                            .getAllTeamsFromLeague(leagueSearchScope: "")
                            .sink(receiveCompletion: { _ in },
                                  receiveValue: { teams in
                                    expect(teams.count) == 1
                                    expect(teams[0].identifier) == "1234"

                                    done()
                                  })
                            .store(in: &self.bag)
                    }
                }
            }

            context("valid search scope") {
                it("should return a list of teams") {
                    self.mockClient.searchTeamResponseRepresentation = self.createSearchTeamResponseRepresentation()
                    let remoteDataStore = TeamRemoteDataStore(client: self.mockClient)

                    waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                        remoteDataStore
                            .getAllTeamsFromLeague(leagueSearchScope: "french ligue 1")
                            .sink(receiveCompletion: { _ in },
                                  receiveValue: { teams in
                                    expect(teams.count) == 1
                                    expect(teams[0].identifier) == "1234"

                                    done()
                                  })
                            .store(in: &self.bag)
                    }
                }
            }
        }
    }

}

extension TeamRemoteDataStoreSpec {
    func createSearchTeamResponseRepresentation() -> SearchTeamResponseRepresentation {
        return SearchTeamResponseRepresentation(teams: [TeamRepresentation(idTeam: "1234",
                                                                           strTeam: "OL",
                                                                           strTeamBadge: "www.test.com",
                                                                           strTeamBanner: "www.test.com", strLeague: "Ligue 1",
                                                                           strDescriptionFR: "a Big description",
                                                                           strCountry: "French")])
    }
}
