# Core Data Migration

## Changes

- Any changes made in place:
    - will immediately invalidate any stored data on the device
    - app will crash on startup
- Pre-Release with users:
    - delete app from simulator/device
    - new persistent store will be created on next build/run
    - not an option after release with users that have existing data
- Need for versions

## Versions

- Select data model in project navigator
- Editor -> Add Model Version... -> Give appropriate version name
- Select new model version in 
- Make updates on new model version
    - since NSAttributedString conforms to NSCoding
    - use transformable to automatically convert to/from binary data
    - specify type correctly:
        - i.e. Custom Class: NSAttributedString

## [Migration](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreDataVersioning/Articles/vmMigrationProcess.html)

- Automatic (Lightweight: Default)
    - best attempts to infer how to map entities, attributes, and relationships
    - between model versions
- Custom (Manual)
    - Create new Mapping Model file
    - Choose source (V1) and destination (V2) models
    - Create new Migration Policy file
    - Select mapping model file -> select mapping -> Entity Mapping -> Custom Policy
        - Namespace.FileNamePolicy
- When Core Data notices that an automatic migration is required, 
    - it will first look for custom mapping models before engaging lightweight migration

