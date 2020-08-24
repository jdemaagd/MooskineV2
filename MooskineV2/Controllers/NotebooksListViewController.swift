//
//  NotebooksListViewController.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/23/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class NotebooksListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    
    // MARK: - variables
    
    var notebooks: [Notebook] = []
    var numberOfNotebooks: Int { return notebooks.count }

    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "toolbar-cow"))
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        updateEditButtonState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Internal methods
    
    func addNotebook(name: String) {
        let notebook = Notebook(name: name)
        notebooks.append(notebook)
        tableView.insertRows(at: [IndexPath(row: numberOfNotebooks - 1, section: 0)], with: .fade)
        updateEditButtonState()
    }
    
    func deleteNotebook(at indexPath: IndexPath) {
        notebooks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        if numberOfNotebooks == 0 {
            setEditing(false, animated: true)
        }
        updateEditButtonState()
    }
    
    func notebook(at indexPath: IndexPath) -> Notebook {
        return notebooks[indexPath.row]
    }
    
    func presentNewNotebookAlert() {
        let alert = UIAlertController(title: "New Notebook", message: "Enter a name for this notebook", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            if let name = alert.textFields?.first?.text {
                self?.addNotebook(name: name)
            }
        }
        saveAction.isEnabled = false

        alert.addTextField { textField in
            textField.placeholder = "Name"
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { notif in
                if let text = textField.text, !text.isEmpty {
                    saveAction.isEnabled = true
                } else {
                    saveAction.isEnabled = false
                }
            }
        }

        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

    func updateEditButtonState() {
        navigationItem.rightBarButtonItem?.isEnabled = numberOfNotebooks > 0
    }


    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NotesListViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.notebook = notebook(at: indexPath)
            }
        }
    }
    
    
    // MARK: - Actions

    @IBAction func addTapped(sender: Any) {
        presentNewNotebookAlert()
    }
}
