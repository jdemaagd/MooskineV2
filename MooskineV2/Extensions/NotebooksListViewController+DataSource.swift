//
//  NotebooksListViewController+DataSource.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/24/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

extension NotebooksListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfNotebooks
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aNotebook = notebook(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: NotebookCell.defaultReuseIdentifier, for: indexPath) as! NotebookCell

        // Configure cell
        cell.nameLabel.text = aNotebook.name
        let pageString = aNotebook.notes.count == 1 ? "page" : "pages"
        cell.pageCountLabel.text = "\(aNotebook.notes.count) \(pageString)"

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteNotebook(at: indexPath)
        default: () // Unsupported
        }
    }
}