//
//  FootballTeamTests.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 27/05/2021.
//

import XCTest
import Quick
import Nimble
@testable import FootballTeam

class SportDBRouterSpec: QuickSpec {

    override func spec() {
        describe("searchTeamInLeague case") {
            context("empty search scope") {
                it("should have a url request with an empty parameter") {
                    // swiftlint:disable:next force_try
                    let urlRequest = try! SportDBRouter.searchTeamInLeague("").asURLRequest()

                    expect(urlRequest.method) == .get
                    expect(urlRequest.url) == URL(string: "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=")!
                }
            }

            context("valid search scope") {
                it("should have a url request with the search scode as parameter") {
                    // swiftlint:disable:next force_try
                    let urlRequest = try! SportDBRouter.searchTeamInLeague("French Ligue 1").asURLRequest()

                    expect(urlRequest.method) == .get
                    expect(urlRequest.url) == URL(string: "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=French%20Ligue%201")!

                }

            }
        }
    }

}
