//
//  TeamListInteractor.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 27/05/2021.
//

import Foundation
import Combine

protocol TeamListInteractorProtocol {

    var teams: [ListTeamsTeam] { get }

    var teamsPublished: Published<[ListTeamsTeam]> { get }
    var teamsPublisher: Published<[ListTeamsTeam]>.Publisher { get }
    
    /// Get all teams from the league associated with the given `leagueSearchScope`
    /// - Parameter leagueSearchScope: `String` leagueSearchScope
    func getAllTeamsFromLeague(leagueSearchScope: String)
}

final class TeamListInteractor: TeamListInteractorProtocol {

    // MARK: - Properties

    let remoteDataSource: TeamRemoteDataStoreProtocol

    var bag: Set<AnyCancellable> = []

    // MARK: - TeamListInteractorProtocol properties

    @Published private(set) var teams: [ListTeamsTeam] = []

    var teamsPublished: Published<[ListTeamsTeam]> { _teams }
    var teamsPublisher: Published<[ListTeamsTeam]>.Publisher { $teams }

    // MARK: - initializer

    init(remoteDataSource: TeamRemoteDataStoreProtocol = TeamRemoteDataStore(client: SportsDbClient())) {
        self.remoteDataSource = remoteDataSource
    }

    // MARK: - TeamListInteractorProtocol

    func getAllTeamsFromLeague(leagueSearchScope: String) {
        remoteDataSource
            .getAllTeamsFromLeague(leagueSearchScope: leagueSearchScope)
            .sink { result in
            print(result)
        } receiveValue: { [weak self] teams in
            self?.teams = teams
        }.store(in: &bag)

    }
}
