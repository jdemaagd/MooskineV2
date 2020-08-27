//
//  NoteDetailsViewController+Notifications.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData

extension NoteDetailsViewController {

    func addSaveNotificationObserver() {
        removeSaveNotificationObserver()
        saveOberverToken = NotificationCenter.default.addObserver(forName: .NSManagedObjectContextObjectsDidChange, object: dataController.viewContext, queue: nil, using: handleSaveNotification(notification:))
    }
    
    func removeSaveNotificationObserver() {
        if let token = saveOberverToken {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    func handleSaveNotification(notification: Notification) {
        DispatchQueue.main.async {
            self.reloadText()
        }
    }
    
    fileprivate func reloadText() {
        textView.attributedText = note.attributedText
    }
}
