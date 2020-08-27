//
//  NoteDetailsViewController+TextField.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/24/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

extension NoteDetailsViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        note.attributedText = textView.attributedText
        //try? note.managedObjectContext?.save()
        try? dataController.viewContext.save()
    }
}
