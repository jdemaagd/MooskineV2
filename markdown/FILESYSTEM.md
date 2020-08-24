# File Storage System and NSCoder

## Sandbox

- Apps live in self-contained containers
- Essential for ensuring security of device
- Malicious app cannot access data outside its container
- Using data, persisting data is stored inside apps container
    - cannot be accessed by any other app
    - cannot extend beyond your app to get any other data
- File system associated per app
    - syncs with iCloud/iTune

## Codable

- Items have been organized and encoded automatically
    - via Swift Encodable (still a plist)

## Resources

- [NSCoder](https://developer.apple.com/documentation/foundation/nscoder)
- [FileManager](https://developer.apple.com/documentation/foundation/filemanager)

