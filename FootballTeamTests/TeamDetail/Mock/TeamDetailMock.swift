//
//  TeamDetailMock.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 30/05/2021.
//

import Foundation
@testable import FootballTeam

struct TeamDetailMock: TeamProtocol {

    var identifier: String
    var name: String
    var teamBannerURL: URL?
    var description: String
    var country: String
    var teamBadgeImageURL: URL?
    var league: String

    init(identifier: String,
         name: String,
         teamBannerURL: URL?,
         description: String,
         country: String,
         teamBadgeImageURL: URL?,
         league: String) {
        self.identifier = identifier
        self.name = name
        self.teamBannerURL = teamBannerURL
        self.description = description
        self.country = country
        self.teamBadgeImageURL = teamBadgeImageURL
        self.league = league
    }
}
