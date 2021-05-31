//
//  TeamDetailBuilder.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 30/05/2021.
//

import Foundation
import UIKit

struct TeamsDetailBuilder {

    static func buildViewController(team: TeamProtocol) -> UIViewController {
        let interactor = TeamDetailInteractor(team: team)
        let viewController = TeamDetailTableViewController()
        let presenter = TeamDetailPresenter(interactor: interactor, viewController: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
