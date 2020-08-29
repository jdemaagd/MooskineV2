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
    
    var dataController: DataController!
    var note: Note!
    var saveOberverToken: Any?
    
    var onDelete: (() -> Void)?

    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let creationDate = note.creationDate {
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
            navigationItem.title = dateFormatter.string(from: creationDate)
        }
        textView.attributedText = note.attributedText

        configureToolbarItems()
        configureTextViewInputAccessoryView()
        
        addSaveNotificationObserver()
    }
    
    deinit {
        removeSaveNotificationObserver()
    }
    

    // MARK: - Internal methods
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    func presentDeleteNotebookAlert() {
        let alert = UIAlertController(title: "Delete Note", message: "Do you want to delete this note?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: deleteHandler))
        present(alert, animated: true, completion: nil)
    }

    func deleteHandler(alertAction: UIAlertAction) {
        onDelete?()
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
       textView.resignFirstResponder()
        
       return true
    }
    
    
    // MARK: - IBActions
    
    @IBAction func deleteNote(sender: Any) {
        presentDeleteNotebookAlert()
    }
}
