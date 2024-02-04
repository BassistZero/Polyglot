//
//  LanguageCell.swift
//  Polyglot
//
//  Created by Bassist_Zero on 2/4/24.
//

import UIKit

final class LanguageCell: UITableViewCell {

    // MARK: - Private Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = Constants.Titlelabel.numberOfLines
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)

        return label
    }()

    // MARK: - Public Properties

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var color: UIColor? {
        didSet {
            contentView.backgroundColor = color
        }
    }

    // MARK: - Life-Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        layout()

        contentView.layer.cornerRadius = Constants.cornerRadius
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Layout

private extension LanguageCell {

    func layout() {
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {
        contentView.addSubview(titleLabel)
    }

    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Titlelabel.topSpacing),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.Titlelabel.bottomSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Titlelabel.leadingSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.Titlelabel.trailingSpacing)
        ])
    }

}

// MARK: - Constants

private extension LanguageCell {

    enum Constants {
        static let cornerRadius: CGFloat = 24

        enum Titlelabel {
            static let numberOfLines = 0
            static let leadingSpacing: CGFloat = 8
            static let topSpacing: CGFloat = 8
            static let trailingSpacing: CGFloat = -8
            static let bottomSpacing: CGFloat = -8
        }

    }

}
