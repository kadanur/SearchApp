//
//  FontSwizzling.swift
//  Dilim
//
//  Created by M Kaan Adanur on 13.05.2022.
//

import Foundation
import UIKit

public protocol SwizzlingInjection: class {
    static func inject()
}

class SwizzlingHelper {
    
    private static let doOnce: Any? = {
        UIFont.inject()
        return nil
    }()
    
    static func enableInjection() {
        _ = SwizzlingHelper.doOnce
    }
}

extension UIApplication {
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        SwizzlingHelper.enableInjection()
        return super.next
    }
    
}


// MARK: - Swizzling
extension UIFont: SwizzlingInjection {
    class var defaultFontFamily: String { return "Satellite" }
    
    public static func inject() {
        // make sure this isn't a subclass
        guard self === UIFont.self else { return }
        
        // Do your own method_exchangeImplementations(originalMethod, swizzledMethod) here
        swizzleSystemFont()
    }
    
    private class func swizzleSystemFont()
    {
        let systemPreferredFontMethod = class_getClassMethod(self, #selector(UIFont.preferredFont(forTextStyle:)))
        let mySystemPreferredFontMethod = class_getClassMethod(self, #selector(UIFont.myPreferredFontForTextStyle(style:)))
        method_exchangeImplementations(systemPreferredFontMethod!, mySystemPreferredFontMethod!)
        
        let systemFontMethod = class_getClassMethod(self, #selector(UIFont.systemFont(ofSize:)))
        let mySystemFontMethod = class_getClassMethod(self, #selector(UIFont.mySystemFont(ofSize:)))
        method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)
        
        let boldSystemFontMethod = class_getClassMethod(self, #selector(UIFont.boldSystemFont(ofSize:)))
        let myBoldSystemFontMethod = class_getClassMethod(self, #selector(UIFont.myBoldSystemFont(ofSize:)))
        method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)
        
        let italicSystemFontMethod = class_getClassMethod(self, #selector(UIFont.italicSystemFont(ofSize:)))
        let myItalicSystemFontMethod = class_getClassMethod(self, #selector(UIFont.myItalicSystemFont(ofSize:)))
        method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)
    }
}

// MARK: - New Font Methods
extension UIFont {
    @objc private class func myPreferredFontForTextStyle(style: String) -> UIFont
    {
        let defaultFont = myPreferredFontForTextStyle(style: style)  // will not cause stack overflow - this is now the old, default UIFont.preferredFontForTextStyle
        let newDescriptor = defaultFont.fontDescriptor.withFamily(defaultFontFamily)
        return UIFont(descriptor: newDescriptor, size: defaultFont.pointSize)
    }
    
    @objc private class func mySystemFont(ofSize: CGFloat) -> UIFont
    {
        return myDefaultFont(ofSize: ofSize)
    }
    
    @objc private class func myBoldSystemFont(ofSize: CGFloat) -> UIFont
    {
        return myDefaultFont(ofSize: ofSize, withTraits: .traitBold)
    }
    
    @objc private class func myItalicSystemFont(ofSize: CGFloat) -> UIFont
    {
        return myDefaultFont(ofSize: ofSize, withTraits: .traitItalic)
    }
    
    private class func myDefaultFont(ofSize: CGFloat, withTraits traits: UIFontDescriptor.SymbolicTraits = []) -> UIFont
    {
        let descriptor = UIFontDescriptor(name: defaultFontFamily, size: ofSize).withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: ofSize)
    }
}
