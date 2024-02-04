//
//  ViewController.swift
//  Polyglot
//
//  Created by Bassist_Zero on 2/2/24.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Private Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(LanguageCell.self, forCellReuseIdentifier: "\(LanguageCell.self)")

        return tableView
    }()

    // MARK: - Life-Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }

}

// MARK: - Layout

private extension ViewController {

    func layout() {
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {
        view.addSubview(tableView)
    }

    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.TableView.leadingSpacing),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.TableView.trailingSpacing)
        ])
    }

}

// MARK: - Module

typealias Module = (backgroundColor: UIColor, titleText: String)

// MARK: - ModelType

enum ModelType: Int, CaseIterable {

    case swift
    case objC
    case c
    case objCXX
    case cxx
    case js

    // MARK: - Public Properties

    var info: Module {
        switch self {
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
        case .js:
            (.systemYellow, JSModel().getText())
        }
    }

}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        configureSpacingCell(for: tableView, at: section)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        configureFooter(for: tableView, at: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.TableView.cellVerticalSpacing
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        Constants.TableView.footerHeight
    }

}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        ModelType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.TableView.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureCell(for: tableView, at: indexPath)
    }

}

// MARK: - Private Methods

private extension ViewController {

    func configureCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(LanguageCell.self)", for: indexPath) as? LanguageCell else {
            return .init()
        }

        cell.title = ModelType.init(rawValue: indexPath.section)?.info.titleText
        cell.color = ModelType.init(rawValue: indexPath.section)?.info.backgroundColor

        return cell
    }

    func configureSpacingCell(for tableView: UITableView, at section: Int) -> UIView? {
        guard section != Constants.TableView.firstSection else {
            return nil
        }

        let view = UIView()
        return view
    }

    func configureFooter(for tableView: UITableView, at section: Int) -> UIView? {
        guard section != Constants.TableView.lastSection else {
            return nil
        }

        let view = UIView()
        return view
    }

}

// MARK: - Constants

private extension ViewController {

    enum Constants {

        enum TableView {
            static let cellVerticalSpacing: CGFloat = 16
            static let leadingSpacing: CGFloat = 16
            static let trailingSpacing: CGFloat = -16
            static let footerHeight: CGFloat = 0
            static let numberOfRowsInSection = 1
            static let firstSection = 0
            static let lastSection = ModelType.allCases.count - 1
        }

    }

}
