//
//  NoteDetailsViewController.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/23/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class NoteDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var textView: UITextView!

    
    // MARK: - variables
    
    var note: Note!
    var onDelete: (() -> Void)?
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()

    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = dateFormatter.string(from: note.creationDate)
        textView.text = note.text
    }

    
    // MARK: - IBActions
    
    @IBAction func deleteNote(sender: Any) {
        presentDeleteNotebookAlert()
    }
}


// MARK: - Delete helpers

extension NoteDetailsViewController {
    func presentDeleteNotebookAlert() {
        let alert = UIAlertController(title: "Delete Note", message: "Do you want to delete this note?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: deleteHandler))
        present(alert, animated: true, completion: nil)
    }

    func deleteHandler(alertAction: UIAlertAction) {
        onDelete?()
    }
}


// MARK: - UITextViewDelegate methods

extension NoteDetailsViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note.text = textView.text
    }
}
