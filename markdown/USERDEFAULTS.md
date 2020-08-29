# [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)

## Interface to default database

- stores key/values pairs persistently across launches of your app
- saved in plist file: 
    - NSSearchPathForDirectoriesInDomains(
    - /Users/jdemaagd/Library/Developer/CoreSimulator/Devices/D6F2846B-D543-499E-B0DD-78FBCCC9478D/data/Containers/Data/Application/06FCFF97-1ACE-4333-BCC0-78931F58EEAE/Library/Preferences/app-bundle-identifier.plist
- flexibility and adaptability makes it prone to abuse
- only use for persisting small bits of data (few KBs)
    - danger with arrays/dictionarys
- do not use as a database
- entire plist has to be loaded synchronously before any value is accessible
- UserDefaults as Singleton: used across all classes and objects

```
let list = [1, 2, 3]
let dict = [ "name": "Jon deMaagd", "location": "Dallas, TX" ]
let defaults = UserDefaults.standard

defaults.set(0.24, forKey: "Volume")
defaults.set(true, forKey: "MusicOn")
defaults.set("Jon deMaagd", forKey: "PlayerName")
defaults.set(Date(), forKey: "AppLastOpenedByUser")
defaults.set(list, forKey: "MyList")
defaults.set(dict, forKey: "MyDict")

let volume = defaults.float(forKey: "Volume")
let appLastOpened = defaults.object(forKey: "AppLastOpenedByUser")
let myList = defaults.array(forKey: "MyList") as! [Int]
let myDict = defaults.dictionary(forKey: "MyDict")

```

## [Singleton](https://developer.apple.com/documentation/swift/cocoa_design_patterns/managing_a_shared_resource_using_a_singleton)

- Provides access to a shared resource using a single, shared class instance
- Provides a globally accessible, shared instance of a class
    - way to provide a unified access point to a resource or service across an app
    - such as an audio channel to play sound effects or a network manager to make HTTP requests

```
let defaults = UserDefaults.standard
let sharedURLSession = URLSession.shared
```

