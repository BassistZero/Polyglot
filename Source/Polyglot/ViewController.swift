//
//  ViewController.swift
//  Polyglot
//
//  Created by Bassist_Zero on 2/2/24.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Private Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    // MARK: - Life-Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        configureLabel(with: .cxx)
    }

}

// MARK: - Layout

private extension ViewController {

    func layout() {
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {
        view.addSubview(titleLabel)
    }

    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

}

// MARK: - Configuration

private extension ViewController {

    func configureLabel(with type: ModelType) {
        let backgroundColor: UIColor
        let titleText: String

        defer {
            view.backgroundColor = backgroundColor
            titleLabel.text = titleText
        }

        (backgroundColor, titleText) = switch type {
        case .swift:
            (.systemOrange, SwiftModel.text)
        case .objC:
            (.systemBrown, ObjectiveCModel.getText())
        case .c:
            (.systemBlue, String(cString: getCText()))
        case .objCXX:
            (.systemPurple, CXXModelWrapper.getText())
        case .cxx:
            (.systemMint, String(CXXModel.getText()))
        }
    }

}

// MARK: - ModelType

enum ModelType {

    case swift
    case objC
    case c
    case objCXX
    case cxx

}
