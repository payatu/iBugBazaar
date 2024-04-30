import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "Cake" asset catalog image resource.
    static let cake = ImageResource(name: "Cake", bundle: resourceBundle)

    /// The "Chiken" asset catalog image resource.
    static let chiken = ImageResource(name: "Chiken", bundle: resourceBundle)

    /// The "Done" asset catalog image resource.
    static let done = ImageResource(name: "Done", bundle: resourceBundle)

    /// The "Home" asset catalog image resource.
    static let home = ImageResource(name: "Home", bundle: resourceBundle)

    /// The "Mix pizza" asset catalog image resource.
    static let mixPizza = ImageResource(name: "Mix pizza", bundle: resourceBundle)

    /// The "Mixsalad" asset catalog image resource.
    static let mixsalad = ImageResource(name: "Mixsalad", bundle: resourceBundle)

    /// The "Salad" asset catalog image resource.
    static let salad = ImageResource(name: "Salad", bundle: resourceBundle)

    /// The "Veg mix" asset catalog image resource.
    static let vegMix = ImageResource(name: "Veg mix", bundle: resourceBundle)

    /// The "egg" asset catalog image resource.
    static let egg = ImageResource(name: "egg", bundle: resourceBundle)

    /// The "nachos" asset catalog image resource.
    static let nachos = ImageResource(name: "nachos", bundle: resourceBundle)

    /// The "payatu" asset catalog image resource.
    static let payatu = ImageResource(name: "payatu", bundle: resourceBundle)

    /// The "pizza" asset catalog image resource.
    static let pizza = ImageResource(name: "pizza", bundle: resourceBundle)

    /// The "sweet banana" asset catalog image resource.
    static let sweetBanana = ImageResource(name: "sweet banana", bundle: resourceBundle)

    /// The "twitter-icon" asset catalog image resource.
    static let twitterIcon = ImageResource(name: "twitter-icon", bundle: resourceBundle)

}

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Hashable {

    /// An asset catalog color resource name.
    fileprivate let name: String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Hashable {

    /// An asset catalog image resource name.
    fileprivate let name: String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif