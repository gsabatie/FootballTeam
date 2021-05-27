//
//  ListTeam.swift
//  FootballTeam
//
//  Created by Guillaume Sabatie on 30/05/2021.
//

import Foundation

protocol ListTeamsTeam {
    var identifier: String { get }
    var name: String { get }
    var teamBadgeImageURL: URL? { get }
    var league: String { get }
    var description: String { get }
    var country: String { get }
}
