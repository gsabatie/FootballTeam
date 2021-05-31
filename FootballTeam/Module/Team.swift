//
//  Team.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 27/05/2021.
//

import Foundation

struct Team: TeamProtocol, Equatable {
    let identifier: String
    let name: String
    let teamBadgeImageURL: URL?
    let league: String
    let description: String
    let country: String
    let teamBannerURL: URL?

    init(representation: TeamRepresentation) {
        self.identifier = representation.idTeam
        self.name = representation.strTeam
        self.league = representation.strLeague
        self.description = representation.strDescriptionFR ?? ""
        self.country = representation.strCountry
        if let teamBadge = representation.strTeamBadge {
            self.teamBadgeImageURL = URL(string: teamBadge)
        } else {
            teamBadgeImageURL = nil
        }

        if let teamBanner = representation.strTeamBanner {
            self.teamBannerURL = URL(string: teamBanner)
        } else {
            teamBannerURL = nil
        }
    }
}
