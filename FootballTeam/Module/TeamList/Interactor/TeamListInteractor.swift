//
//  TeamListInteractor.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 27/05/2021.
//

import Foundation
import Combine

protocol TeamListInteractorProtocol {

    var teams: [TeamProtocol] { get }

    var teamsPublished: Published<[TeamProtocol]> { get }
    var teamsPublisher: Published<[TeamProtocol]>.Publisher { get }

    var errorSubject: PassthroughSubject<Error, Never> { get }

    /// Get all teams from the league associated with the given `leagueSearchScope`
    /// - Parameter leagueSearchScope: `String` leagueSearchScope
    func getAllTeamsFromLeague(leagueSearchScope: String)
}

final class TeamListInteractor: TeamListInteractorProtocol {

    // MARK: - Properties

    let remoteDataSource: TeamRemoteDataStoreProtocol

    var bag: Set<AnyCancellable> = []

    // MARK: - TeamListInteractorProtocol properties

    @Published private(set) var teams: [TeamProtocol] = []

    var teamsPublished: Published<[TeamProtocol]> { _teams }
    var teamsPublisher: Published<[TeamProtocol]>.Publisher { $teams }

    var errorSubject: PassthroughSubject<Error, Never> = .init()

    // MARK: - initializer

    init(remoteDataSource: TeamRemoteDataStoreProtocol = TeamRemoteDataStore(client: SportsDbClient())) {
        self.remoteDataSource = remoteDataSource
    }

    // MARK: - TeamListInteractorProtocol

    func getAllTeamsFromLeague(leagueSearchScope: String) {
        remoteDataSource
            .getAllTeamsFromLeague(leagueSearchScope: leagueSearchScope)
            .sink(receiveCompletion: { [weak self] result in
                if case let .failure(error) = result {
                    self?.errorSubject.send(error)
                }
            }, receiveValue: { [weak self] teams in
                self?.teams = teams
            }).store(in: &bag)

    }
}
