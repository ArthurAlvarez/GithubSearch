//
//  UserSearchPresenter.swift
//  GithubSearch
//
//  Created by Arthur Alvarez on 17/06/2018.
//  Copyright © 2018 Arthur Alvarez. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class UserSearchPresenter: NSObject {

    // MARK: - Properties
    var view: UserSearchViewController!
    let repository = UserSearchRepository()

    init(view: UserSearchViewController) {
        self.view = view
    }

    // MARK: - LifeCycle

    func viewDidLoad() {
        view.setTableView()
        view.setSearchBar()
    }

    // MARK: - DataSource

    func numberOfRows() -> Int {
        return repository.usersCount()
    }

    func cellForRow(tableView: UITableView, index: Int) -> UITableViewCell {
        let user = repository.getUserAt(index: index)
        let userCell: GithubUserTableViewCell? = GithubUserTableViewCell.dequeued(from: tableView)!
        userCell?.setContent(with: user)
        return userCell ?? UITableViewCell()
    }

    // MARK: - Events

    func searchTapped(for query: String) {
        self.view.showLoading()
        repository.fetchUsers(query: query) { success in
            self.view.hideLoading()
            if success {
                self.view.reloadData()
            } else {
                NotificationBanner(title: "Falha ao carregar dados", subtitle: "Tente novamente", style: .danger).show()
            }
        }
    }

    func userTapped(at index: Int) {
        print("Tapped user at: \(index)")
        // TODO: show user repos
    }
}
