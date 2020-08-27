//
//  Pathifier.swift
//  MooskineV2
//
//  Created by Jon DeMaagd on 8/26/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

internal struct Pathifier {

    // Creates UIBezierPath from a supplied attributed string and font
    // font will be applied to entire attributed string
    static func makeBezierPath(for attributedString: NSAttributedString, withFont font: UIFont) -> UIBezierPath {
        
        // Generate bezier path:
        //  break attributed string into series of `NSGlyph`s via TextKit,
        //  use CoreText function to create individual paths for each glyph

        // Apply supplied font
        let text = NSMutableAttributedString(string: attributedString.string)
        text.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, text.length))

        // Create NSLayoutManager to generate glyphs
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer()
        let textStorage = NSTextStorage(attributedString: text)
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)

        // Use layout manager to loop through glyphs,
        //  adding to a bezier path as we go
        let path = UIBezierPath()
        let font = CTFontCreateWithFontDescriptor(font.fontDescriptor, font.pointSize, nil)
        for glyphIndex in 0 ..< layoutManager.numberOfGlyphs {
            let glyph = layoutManager.cgGlyph(at: glyphIndex)
            let position = layoutManager.location(forGlyphAt: glyphIndex)
            if let glyphPath = CTFontCreatePathForGlyph(font, glyph, nil) {
                let glyphBezierPath = UIBezierPath(cgPath: glyphPath)
                glyphBezierPath.apply(CGAffineTransform(translationX: position.x, y: 0))
                path.append(glyphBezierPath)
            }
        }

        return path
    }

    // Generate image for attributed string via `makeBezierPath(for:withFont:)`
    static func makeImage(for attributedString: NSAttributedString, withFont font: UIFont, withPatternImage patternImage: UIImage) -> UIImage {
        let path = makeBezierPath(for: attributedString, withFont: font)
        let bounds = path.bounds
        
        // Add padding so wide lines do not clip
        let pad = CGSize(width: 4, height: 6)
        
        let size = CGSize(width: bounds.size.width + bounds.origin.x + pad.width, height: bounds.size.height + pad.height)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()

        // Flip orientation vertically
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -size.height)

        // Adjust positioning for padding
        context?.translateBy(x: -pad.width / 2, y: pad.height / 2)

        // Draw path
        context?.setFillColor(UIColor(patternImage: patternImage).cgColor)
        path.fill()
        context?.setStrokeColor(UIColor.black.cgColor)
        path.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }

    static func makeMutableAttributedString(for attributedString: NSAttributedString, withFont font: UIFont, withPatternImage patternImage: UIImage) -> NSMutableAttributedString {

        // converts text to image using patternimage
        let image = Pathifier.makeImage(for: attributedString, withFont: font, withPatternImage: patternImage)

        // creates text attachment with image
        let attachment = NSTextAttachment()
        attachment.image = image

        // converts attachment to mutable attributed string
        let attachmentAsText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        
        return attachmentAsText
    }
}
