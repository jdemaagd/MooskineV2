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
    var fetchedResultsController: NSFetchedResultsController<Note>!
    var notebook: Notebook!
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = notebook.name
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        setupFetchedResultsController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupFetchedResultsController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fetchedResultsController = nil
    }

    
    // MARK: - override methods
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    

    // MARK: - internal methods
    
    func addNote() {
        let note = Note(context: dataController.viewContext)
        note.text = "New Note"
        note.creationDate = Date()
        note.notebook = notebook
        try? dataController.viewContext.save()
    }

    func deleteNote(at indexPath: IndexPath) {
        let noteToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(noteToDelete)
        try? dataController.viewContext.save()
    }
    
    func updateEditButtonState() {
        if let sections = fetchedResultsController.sections {
            navigationItem.rightBarButtonItem?.isEnabled = sections[0].numberOfObjects > 0
        }
    }


    // MARK: - fileprivate methods
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", "notebook", notebook)
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "\(notebook!)-notes")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }


    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NoteDetailsViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.dataController = dataController
                vc.note = fetchedResultsController.object(at: indexPath)

                vc.onDelete = { [weak self] in
                    if let indexPath = self?.tableView.indexPathForSelectedRow {
                        self?.deleteNote(at: indexPath)
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addTapped(sender: Any) {
        addNote()
    }
}
