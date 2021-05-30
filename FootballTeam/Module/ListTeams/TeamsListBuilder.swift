//
//  TeamsListBuilder.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 28/05/2021.
//

import Foundation
import UIKit

struct TeamsListBuilder {

    static func buildViewController() -> UIViewController {
        let interactor = TeamListInteractor(remoteDataSource: TeamRemoteDataStore(client: SportsDbClient()))
        let viewController = TeamListCollectionViewController()
        let presenter = TeamListPresenter(interactor: interactor, viewController: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
