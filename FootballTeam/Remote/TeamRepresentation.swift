//
//  TeamRepresentation.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 27/05/2021.
//

import Foundation

struct TeamRepresentation: Codable {
    let idTeam: String
    let strTeam: String
    let strTeamBadge: String?
    let strLeague: String
    let strDescriptionFR: String?
    let strCountry: String
}
