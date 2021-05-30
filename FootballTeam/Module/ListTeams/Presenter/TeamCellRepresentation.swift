//
//  TeamCellRepresentation.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 28/05/2021.
//

import Foundation
import UIKit
import AlamofireImage

struct TeamCellRepresentation: Hashable {

    // MARK: - Properties

    let teamIdentifier: String
    let badgeImageURL: URL?

    func hash(into hasher: inout Hasher) {
        hasher.combine(teamIdentifier)
    }

    static func == (lhs: TeamCellRepresentation, rhs: TeamCellRepresentation) -> Bool {
        return lhs.teamIdentifier == rhs.teamIdentifier && lhs.badgeImageURL == rhs.badgeImageURL
    }

    // MARK: - Function

    func configure(cell: TeamCollectionViewCell) {
        if let url = badgeImageURL {
            cell.badgeImageView.af.setImage(withURL: url)
        }
    }

}
