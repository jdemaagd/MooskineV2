//
//  Note.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/23/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

class Note {

    let creationDate: Date

    var text: String

    init(text: String = "New note") {
        self.text = text
        creationDate = Date()
    }
}
