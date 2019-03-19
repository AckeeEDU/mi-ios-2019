//
//  PickerViewController.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 26/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit
import SnapKit

protocol HasTitle {
    var title: String { get }
}

protocol HasSubtitle {
    var subtitle: String { get }
}

protocol HasAllCases {
    static var allCases: [Self] { get }
}

typealias Pickable = HasTitle & HasSubtitle & HasAllCases

final class PickerViewController<Item: Pickable>: UIViewController, UITableViewDataSource, UITableViewDelegate {
    typealias ResultHandler = (PickerViewController, Item?) -> Void

    var resultHandler: ResultHandler?

    private weak var closeButton: UIButton!
    private weak var titleLabel: UILabel!
    private weak var tableView: UITableView!

    // MARK: - View life cycle

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal) // TODO: Localize when permission is granted
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        self.closeButton = closeButton

        let titleLabel = UILabel()
        titleLabel.text = "Picker" // TODO: Localize when permission is granted
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(closeButton)
        }
        self.titleLabel = titleLabel

        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(closeButton.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
        self.tableView = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PickerCell.self, forCellReuseIdentifier: "Cell")

        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .primaryActionTriggered)
    }

    // MARK: - UI actions

    @objc private func closeButtonTapped(_ sender: UIButton) {
        resultHandler?(self, nil)
    }

    // MARK: - UITableView data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Item.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let carKind = Item.allCases[indexPath.row]
        cell.textLabel?.text = carKind.title
        cell.detailTextLabel?.text = carKind.subtitle
        return cell
    }

    // MARK: - UITableView delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultHandler?(self, Item.allCases[indexPath.row])
    }
}

private final class PickerCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
