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

    weak var presenter: TeamListPresenter?

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

    init() {
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

        collectionView.backgroundColor = .white
        //SearchController
        navigationItem.searchController = searchController

        definesPresentationContext = true
        bindPresenter()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter?.viewDidAppeared()
    }

    func bindPresenter() {
        presenter?
            .$teamCellRepresentations
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] teamCellRepresentations in
                self?.applySnapshot(teamCellRepresentations: teamCellRepresentations)
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
}

extension TeamListCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.searchLeague(searchScope: searchController.searchBar.text ?? "")
     }
}
