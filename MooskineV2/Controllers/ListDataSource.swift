//
//  ListDataSource.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/25/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

// Generic class for ViewController's tableCell, managedObject, managedObjectContext, etc.
class ListDataSource<EntityType: NSManagedObject, CellType: UITableViewCell>: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    // MARK: - private variables
    
    private let cellIdentifier = String(describing: CellType.self)
    private let configureCell: (CellType, EntityType) -> Void
    private let fetchedResultsController: NSFetchedResultsController<EntityType>
    private let tableView: UITableView
    private let viewContext: NSManagedObjectContext
    
    
    // MARK: - computed properties
    
    var onContentUpdated: (() -> Void)? = nil
    var numberOfSections: Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    var isEditingPossible: Bool {
        return numberOfRowsIn(section: 0) > 0
    }
    
    
    // MARK: - Generic initializer
    
    init(tableView: UITableView, viewContext: NSManagedObjectContext, fetchRequest: NSFetchRequest<EntityType>, configureCell: @escaping (CellType, EntityType) -> Void) {
        
        self.tableView = tableView
        self.viewContext = viewContext
        self.configureCell = configureCell
        
        fetchedResultsController = NSFetchedResultsController<EntityType>(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        loadData()
    }
    

    // MARK: - internal methods
    
    func deleteItem(at indexPath: IndexPath) {
        let itemToDelete = object(at: indexPath)
        viewContext.delete(itemToDelete)
        try? viewContext.save()
        
        if !isEditingPossible {
            tableView.setEditing(isEditingPossible, animated: true)
        }
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func object(at indexPath: IndexPath) -> EntityType {
        return fetchedResultsController.object(at: indexPath)
    }
    
    
    // MARK: - private methods
    
    private func loadData() {
        tableView.dataSource = self
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsIn(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellType
        let model = fetchedResultsController.object(at: indexPath)
        
        configureCell(cell, model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
            case .delete: deleteItem(at: indexPath)
            default: ()
        }
    }

    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case.move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        default:
            tableView.reloadData()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .fade)
        case .delete:
            tableView.deleteSections(indexSet, with: .fade)
        case .update:
            tableView.reloadSections(indexSet, with: .fade)
        default:
            tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        onContentUpdated?()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
}
