//
//  Notebook.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/23/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

class Notebook {

    let name: String

    let creationDate: Date

    var notes: [Note] = []

    init(name: String) {
        self.name = name
        creationDate = Date()
        notes = []
    }
}

extension Notebook {

    func addNote() {
        notes.append(Note())
    }

    func removeNote(at index: Int) {
        notes.remove(at: index)
    }
}
