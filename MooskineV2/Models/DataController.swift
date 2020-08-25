//
//  DataController.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/24/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData

/*
 Setup Core Data Stack when application first starts up.
 
 To keep from cluttering App/Scene Delegate files:
    1. Holds persistence container instance
    2. Load persistence store
    3. Access contexts
 */
class DataController {
    
    // immutable: should not need to change over lifetime of data controller
    let persistentContainer: NSPersistentContainer
    
    // computed convenience property to access contexts
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    // use persistent container to load persistent store
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            
            self.autoSaveViewContext()
            
            completion?()
        }
    }
}
