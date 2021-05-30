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

        let router = TeamListRouter()
        let presenter = TeamListPresenter(interactor: interactor, router: router)
        let viewController = TeamListCollectionViewController(presenter: presenter)
        presenter.viewController = viewController

        return viewController
    }
}
