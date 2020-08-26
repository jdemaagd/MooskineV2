//
//  NotebooksListViewController.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/23/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

class NotebooksListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    

    // MARK: - variables
    
    var dataController: DataController!
    private var listDataSource: ListDataSource<Notebook, NotebookCell>!

    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "toolbar-cow"))
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupDataSource()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        listDataSource = nil
    }


    // MARK: - override methods
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

    
    // MARK: - internal methods
    
    func addNotebook(name: String) {
        let notebook = Notebook(context: dataController.viewContext)
        notebook.name = name
        try? dataController.viewContext.save()
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
    
    func updateEditButtonState() {
        navigationItem.rightBarButtonItem?.isEnabled = listDataSource.isEditingPossible
    }
    
    
    // MARK: - private methods
    
    private func setupDataSource() {
        let fetchRequest: NSFetchRequest<Notebook> = Notebook.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        listDataSource = ListDataSource(tableView: tableView, viewContext: dataController.viewContext, fetchRequest: fetchRequest, configureCell: { (cell, notebook) in
            cell.nameLabel.text = notebook.name
            let count = notebook.notes?.count ?? 0
            let pageString = count == 1 ? "page" : "pages"
            cell.pageCountLabel.text = "\(count) \(pageString)"
        })
        
        listDataSource.onContentUpdated = {
            self.updateEditButtonState()
        }
    }

    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NotesListViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.notebook = listDataSource.object(at: indexPath)
                vc.dataController = dataController
            }
        }
    }
    
    
    // MARK: - Actions

    @IBAction func addTapped(sender: UIBarButtonItem) {
        presentNewNotebookAlert()
    }
}
