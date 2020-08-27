## [Concurrency](https://developer.apple.com/documentation/coredata/nsmanagedobjectcontext#1654001)

## Concurrency Queues

- private: background
- main: ui
- add debug flag to scheme to cause app to crash immediately
    - when accessing context from wrong queue
    - Xcode -> Product -> Scheme -> Edit Scheme -> Run Debug -> Arguments Passed On Launch
        - Add (+)
        - -com.apple.CoreData.ConcurrencyBug 1

## Context Policy

- NSMergePolicy.errorMergePolicyType (default)
    - conflicting changes in contexts at merge time
    - causes app to crash
- NSMergePolicy.mergeByPropertyStoreTrump
    - property changes from persistent store will win over changes in context
- NSMergePolicy.mergeByPropertyObjectTrump
    - state of property from object in context will win over state in persistent store

## Resources

- [NSManagedObjectContext](https://developer.apple.com/documentation/coredata/nsmanagedobjectcontext)

