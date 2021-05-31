//
//  SearchTeams.swift
//  FootballTeamTests
//
//  Created by Guillaume Sabatie on 30/05/2021.
//

import Foundation
@testable import FootballTeam

struct TeamMock: TeamProtocol {
    let identifier: String
    let name: String
    let teamBadgeImageURL: URL?
    let teamBannerURL: URL?
    let league: String
    let description: String
    let country: String

    init(identifier: String,
         name: String,
         league: String,
         teamBadgeImageURL: URL,
         teamBannerURL: URL?,
         description: String,
         country: String) {
        self.identifier = identifier
        self.name = name
        self.teamBadgeImageURL = teamBadgeImageURL
        self.teamBannerURL = teamBannerURL
        self.league = league
        self.description = description
        self.country = country
    }
}
