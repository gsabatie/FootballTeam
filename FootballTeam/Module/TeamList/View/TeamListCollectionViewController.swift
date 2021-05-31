//
//  TeamListCollectionViewController.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 28/05/2021.
//

import UIKit
import Combine

class TeamListCollectionViewController: UICollectionViewController {

    // MARK: - VIPER

    var presenter: TeamListPresenter?

    // MARK: - Enum

    enum Section {
        case main
    }

    // MARK: - Typealias

    typealias DataSource = UICollectionViewDiffableDataSource<Section, TeamCellRepresentation>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TeamCellRepresentation>

    lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, representation) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.reuseIdentifier,
                                                                for: indexPath) as? TeamCollectionViewCell
            else {
                return nil
            }

            representation.configure(cell: cell)

            return cell
        }

        return dataSource
    }()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search League"

        return searchController
    }()

    var bag: Set<AnyCancellable> = []

    // MARK: - Initializers

    init(presenter: TeamListPresenter) {
        self.presenter = presenter

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 163, height: 163)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.headerReferenceSize = CGSize.zero

        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cells
        let teamCollectionViewCellNib = UINib(nibName: "TeamCollectionViewCell", bundle: .main)
        collectionView.register(TeamCollectionViewCell.self, forCellWithReuseIdentifier: TeamCollectionViewCell.reuseIdentifier)
        collectionView.register(teamCollectionViewCellNib, forCellWithReuseIdentifier: TeamCollectionViewCell.reuseIdentifier)

        // UI
        collectionView.backgroundColor = .white

        // SearchController
        navigationItem.searchController = searchController

        definesPresentationContext = true

        bindPresenter()
    }

    func bindPresenter() {
        presenter?
            .$teamCellRepresentations
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] teamCellRepresentations in
                self?.applySnapshot(teamCellRepresentations: teamCellRepresentations)
            })
            .store(in: &bag)

        presenter?
            .errorMessageSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] errorMessage in
                self?.displayError(message: errorMessage)

            })
            .store(in: &bag)
    }

    func applySnapshot(teamCellRepresentations: [TeamCellRepresentation]) {
        var snapshot = Snapshot()

        if !teamCellRepresentations.isEmpty {
            snapshot.appendSections([.main])
            snapshot.appendItems(teamCellRepresentations)
        }

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

        present(alertController, animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.row)
    }
}

// MARK: - UISearchResultsUpdating

extension TeamListCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        print(text)
        presenter?.searchLeague(searchScope: text)
     }
}
