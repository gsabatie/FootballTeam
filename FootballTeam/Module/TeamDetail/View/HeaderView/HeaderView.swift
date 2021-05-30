//
//  HeaderTableViewCell.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 30/05/2021.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    static let identifier: String = "HeaderView"

    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.addConstraint(imageView.heightAnchor.constraint(equalToConstant: 80))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    lazy var secondTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .gray
        label.addConstraint(label.heightAnchor.constraint(equalToConstant: 25))
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.addConstraint(label.heightAnchor.constraint(equalToConstant: 25))
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bannerImageView, secondTitleLabel, mainTitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupUI()
        setupConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(mainStackView)
    }

    func setupConstraints() {
        addConstraints([mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                        mainStackView.topAnchor.constraint(equalTo: topAnchor),
                        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
