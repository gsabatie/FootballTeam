//
//  TeamDetailDescriptionRepresentation.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 30/05/2021.
//

import Foundation

struct TeamDescriptionCellRepresentation: Hashable {

    // MARK: - Properties

    let description: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }

    static func == (lhs: TeamDescriptionCellRepresentation, rhs: TeamDescriptionCellRepresentation) -> Bool {
        return lhs.description == rhs.description
    }

    // MARK: - Function

    func configure(cell: DescriptionTableViewCell) {
        cell.descriptionTextView.text = description
    }

}
