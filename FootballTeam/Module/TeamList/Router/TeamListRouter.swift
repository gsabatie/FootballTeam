//
//  TeamsListRouter.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 28/05/2021.
//

import Foundation
import UIKit

protocol TeamListRouterProtocol {
    /// Function push a detailViewcontroller displaying a team,
    /// - Parameters:
    ///   - viewController: `UIViewController`  viewcontroller where the detailViewController is pushed
    ///   - team: `TeamProtocol` team displayed in the detailViewController
    func pushDetailViewController(from viewController: UIViewController, team: TeamProtocol)
}

final class TeamListRouter: TeamListRouterProtocol {

    func pushDetailViewController(from viewController: UIViewController, team: TeamProtocol) {
        let detailViewController = TeamsDetailBuilder.buildViewController(team: team)

        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
