//
//  DataController+AutoSave.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/24/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

extension DataController {
    
    // appropriate for cases where data is entered continuously such as editing text
    func autoSaveViewContext(interval: TimeInterval = 60) {
        print("autosaving")
        
        guard interval > 0 else {
            print("Cannot set negative autosave interval")
            return
        }
        
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
}
