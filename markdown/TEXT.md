# [NSAttributedString](https://developer.apple.com/documentation/foundation/nsattributedstring)

## Rich Text

- Text: string
- Formatting: set of attributes to be applied to set of character ranges
- [NSAttributedString](https://developer.apple.com/documentation/foundation/nsattributedstring):
    - immutable string
    - options for interactive links, images, etc.
- [NSMutableAttributedString](https://developer.apple.com/documentation/foundation/nsmutableattributedstring): 
    - mutable version

## Core Data Options

- Binary Data: 
    - option for 'Allows External Storage'
    - automatically store binary data in file system (only reference in db)
    - NSData type (any type that conforms to NSCoding protocol can be binary data)
    - responsible for converting to/from NSData
- Tansformable:
    - option to specify type to correspond to
    - Xocde will generate correctly type property

