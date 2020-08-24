# [Core Data](https://developer.apple.com/documentation/coredata)

## Models

- Table : Entity : Class
- Attributes : Properties
- Module: Current Product Module
- Codegen:
    - Manual/None: no linkage or help, purely manual
    - Class Definition (default): converts data to classes
        - chflags nohidden ~/Library/
        - location of swift files representing model: 
            - /Users/jdemaagd/Library/Developer/Xcode/DerivedData/AppName-characters/Build/Intermediates.noindex/AppName.build/Debug-iphoneos/Testemunho.build/DerivedSources/CoreDataGenerated/DataModel/
            - class file gets generated once and does not get modified unless its deleted or add new entity
            - properties file gets generated many times
            - do not edit these files (auto-generated files)
    - Category/Extension
        - use for custom initializers/functions
        - most used
- NSPersistenContainer: where data is stored (default: SQLite database)
- Context (scratch pad): staging area of unsaved changes to data
    - call save() to save to container

## Database File

- Device: /var/mobile/Containers/Data/Application/7E7B355B-B97A-4B04-BCCB-A6D43B150DF2/Documents/
- Simulator: /Users/jdemaagd/Library/Developer/CoreSimulator/Devices/732CEBC7-0134-4618-ABC6-6503F0D9DC73/data/Containers/Data/Application/0FB5F122-F1FF-43E8-BB5F-5C5757D8788A/
    - cd Library/Application Support/
    - open DataModelName.sqlite (DB Browser for SQLite)
- Application <--> Context <--> Persistence Container (SQLite)

## Resources

- [NSPredicate Cheat Sheet](https://academy.realm.io/posts/nspredicate-cheatsheet/)
- [NSPredicate Blog](https://nshipster.com/nspredicate/)

