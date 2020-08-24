//
//  NotesListViewController.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/23/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class NotesListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    
    // MARK: - variables
    
    var notebook: Notebook!
    var notes: [Note] = []
    var numberOfNotes: Int { return notes.count }
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
    
    func addNote() {
        //notebook.addNote()
        tableView.insertRows(at: [IndexPath(row: numberOfNotes - 1, section: 0)], with: .fade)
        updateEditButtonState()
    }

    func deleteNote(at indexPath: IndexPath) {
        //notebook.removeNote(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        if numberOfNotes == 0 {
            setEditing(false, animated: true)
        }
        updateEditButtonState()
    }

    func note(at indexPath: IndexPath) -> Note {
        return notes[indexPath.row]
    }
    
    func updateEditButtonState() {
        navigationItem.rightBarButtonItem?.isEnabled = numberOfNotes > 0
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }


    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NoteDetailsViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.note = note(at: indexPath)

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
