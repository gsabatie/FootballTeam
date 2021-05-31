//
//  ListTeam.swift
//  FootballTeam
//
//  Created by Guillaume Sabatie on 30/05/2021.
//

import Foundation

protocol TeamProtocol {
    var identifier: String { get }
    var name: String { get }
    var teamBadgeImageURL: URL? { get }
    var league: String { get }
    var description: String { get }
    var country: String { get }
    var teamBannerURL: URL? { get }
}
