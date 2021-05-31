//
//  TeamDetailTableViewController.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 30/05/2021.
//

import UIKit
import Combine

final class TeamDetailTableViewController: UITableViewController {

    // MARK: - VIPER

    weak var presenter: TeamDetailPresenter?

    // MARK: - Typealias

    typealias DataSource = UITableViewDiffableDataSource<Section, TeamDescriptionCellRepresentation>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TeamDescriptionCellRepresentation>

    lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { tableView, _, representation in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier) as? DescriptionTableViewCell else {
                return nil
            }

            representation.configure(cell: cell)

            return cell
        }

        return dataSource
    }()

    var teamHeaderRepresentation: TeamHeaderCellRepresentation? {
        didSet {
            tableView.reloadData()
        }
    }

    var bag: Set<AnyCancellable> = []

    // MARK: - Enum

    enum Section {
        case main
    }

    // MARK: - Typealias

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell
        let descriptionTableViewCellNib = UINib(nibName: "DescriptionTableViewCell", bundle: .main)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(descriptionTableViewCellNib, forCellReuseIdentifier: DescriptionTableViewCell.identifier)

        // Register HeaderView
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)

        bindPresenter()
    }

    func bindPresenter() {
        presenter?.$teamDescription.receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] descriptionCellRepresentation in
            self?.applySnapshot(teamDescriptionRepresentation: descriptionCellRepresentation)
        }).store(in: &bag)

        presenter?.$teamHeaderCellRepresentation.receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] representation in
            self?.teamHeaderRepresentation = representation
        }).store(in: &bag)
    }

    func applySnapshot(teamDescriptionRepresentation: TeamDescriptionCellRepresentation) {
        var snapshot = Snapshot()

        snapshot.appendSections([.main])
        snapshot.appendItems([teamDescriptionRepresentation])

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let teamHeaderRepresentation = teamHeaderRepresentation,
              let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView
        else {
            return nil
        }

        teamHeaderRepresentation.configure(headerView: headerView)

        return headerView

    }

}
