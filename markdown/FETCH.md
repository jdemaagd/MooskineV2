# [FetchedResultsController](https://developer.apple.com/documentation/coredata/nsfetchedresultscontroller)

## Overview

- Sits between View and Model
- Listens for changes to data model
- When change happens triggers logic to update view
- Decouples view and model layers

## Setup

- Persists over lifetime of View Controller
- Use FetchRequest to fetch and track data of interest
    - fetch request must be sorted for consistent ordering for views
- Invoke performFetch to load data and start tracking
- FetchedResultsController tracks changes, to respond to those changes,
    - need to implement delegate methods
    - has no mandatory elements
- Swap it in as datasource for collection/table views over data controller
    - and have views update itself when changes occur

## Caching

- Giving cacheName will enable caching automatically
- Cache will persist between sessions
- Cache updates itself automatically when section or ordering information changes
- Manually delete cache first if making change to fetchRequest in fetchRequestController
    - ` NSFetchedResultsController<ModelName>.deleteCache(withName: "cache_name") `
- Set it and forget it

