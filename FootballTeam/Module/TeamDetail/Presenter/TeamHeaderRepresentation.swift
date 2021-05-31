//
//  TeamHeaderRepresentation.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 31/05/2021.
//

import Foundation
import AlamofireImage

struct TeamHeaderCellRepresentation: Hashable {

    // MARK: - Properties

    let identifier = UUID()
    let bannerImageUrl: URL?
    let country: String
    let league: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: TeamHeaderCellRepresentation, rhs: TeamHeaderCellRepresentation) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.bannerImageUrl == rhs.bannerImageUrl &&
            lhs.country == rhs.country &&
            lhs.league == rhs.league
    }

    // MARK: - Function

    func configure(headerView: HeaderView) {
        headerView.mainTitleLabel.text = league
        headerView.secondTitleLabel.text = country

        if let url = bannerImageUrl {
            headerView.bannerImageView.af.setImage(withURL: url)
        }
    }
}
