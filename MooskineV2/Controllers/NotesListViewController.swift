//
//  NotesListViewController.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/23/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

class NotesListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - variables
    
    var dataController: DataController!
    private var fetchedResultsController: NSFetchedResultsController<Note>!
    private var listDataSource: ListDataSource<Note, NoteCell>!
    var notebook: Notebook!
    

    // MARK: - computed properties

    var isEditingPossible: Bool {
        return listDataSource.isEditingPossible
    }
    
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = notebook.name
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
    
    func addNote() {
        let note = Note(context: dataController.viewContext)
        note.attributedText = NSAttributedString(string: "New Note")
        note.notebook = notebook
        try? dataController.viewContext.save()
    }
    
    func updateEditButtonState() {
        navigationItem.rightBarButtonItem?.isEnabled = isEditingPossible
    }


    // MARK: - private methods
    
    private func setupDataSource() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        let predicate = NSPredicate(format: "%K == %@", "notebook", notebook)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        listDataSource = ListDataSource<Note, NoteCell>(tableView: tableView, viewContext: dataController.viewContext, fetchRequest: fetchRequest, configureCell: { (cell, note) in
            cell.textPreviewLabel.attributedText = note.attributedText
            if let creationDate = note.creationDate {
                let dateFormatter = DateFormatter()
                dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
                cell.dateLabel.text = dateFormatter.string(from: creationDate)
            }
        })
        listDataSource.onContentUpdated = {
            self.updateEditButtonState()
        }
    }


    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NoteDetailsViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.dataController = dataController
                vc.note = listDataSource.object(at: indexPath)

                vc.onDelete = { [weak self] in
                    if let indexPath = self?.tableView.indexPathForSelectedRow {
                        self?.listDataSource?.deleteItem(at: indexPath)
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addTapped(sender: UIBarButtonItem) {
        addNote()
    }
}
