//
//  Note+CreationDate.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/24/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

extension Note {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        creationDate = Date()
    }
}
