//
//  TeamListRouterMock.swift
//  FootballTeamTests
//
//  Created by guillaume sabatié on 31/05/2021.
//

import Foundation
import UIKit
@testable import FootballTeam

class TeamListRouterMock: TeamListRouterProtocol {
    var pushedTeam: TeamProtocol?

    func pushDetailViewController(from viewController: UIViewController, team: TeamProtocol) {
        pushedTeam = team
    }
}
