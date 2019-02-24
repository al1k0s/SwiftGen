// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS)
  import ARKit
  import UIKit
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#elseif os(tvOS) || os(watchOS)
  import UIKit
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Files {
    internal static let data = DataAsset(name: "Data")
    internal enum Json {
      internal static let data = DataAsset(name: "Json/Data")
    }
    internal static let readme = DataAsset(name: "README")
  }
  internal enum Food {
    internal enum Exotic {
      internal static let banana = ImageAsset(name: "Exotic/Banana")
      internal static let mango = ImageAsset(name: "Exotic/Mango")
    }
    internal enum Round {
      internal static let apricot = ImageAsset(name: "Round/Apricot")
      internal enum Red {
        internal static let apple = ImageAsset(name: "Round/Apple")
        internal enum Double {
          internal static let cherry = ImageAsset(name: "Round/Double/Cherry")
        }
        internal static let tomato = ImageAsset(name: "Round/Tomato")
      }
    }
    internal static let `private` = ImageAsset(name: "private")
  }
  internal enum Other {
  }
  internal enum Styles {
    internal enum _24Vision {
      internal static let background = ColorAsset(name: "24Vision/Background")
      internal static let primary = ColorAsset(name: "24Vision/Primary")
    }
    internal static let orange = ImageAsset(name: "Orange")
    internal enum Vengo {
      internal static let primary = ColorAsset(name: "Vengo/Primary")
      internal static let tint = ColorAsset(name: "Vengo/Tint")
    }
  }
  internal enum Targets {
    internal static let bottles = ARResourceGroupAsset(name: "Bottles")
    internal static let paintings = ARResourceGroupAsset(name: "Paintings")
    internal static let posters = ARResourceGroupAsset(name: "Posters")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ARResourceGroupAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) && swift(>=3.2)
  @available(iOS 11.3, *)
  internal var referenceImages: Set<ARReferenceImage> {
    return ARReferenceImage.referenceImages(in: self)
  }

  @available(iOS 12.0, *)
  internal var referenceObjects: Set<ARReferenceObject> {
    return ARReferenceObject.referenceObjects(in: self)
  }
  #endif
}

#if os(iOS) && swift(>=3.2)
@available(iOS 11.3, *)
internal extension ARReferenceImage {
  static func referenceImages(in asset: ARResourceGroupAsset) -> Set<ARReferenceImage> {
    let bundle = Bundle(for: BundleToken.self)
    return referenceImages(inGroupNamed: asset.name, bundle: bundle) ?? Set()
  }
}

@available(iOS 12.0, *)
internal extension ARReferenceObject {
  static func referenceObjects(in asset: ARResourceGroupAsset) -> Set<ARReferenceObject> {
    let bundle = Bundle(for: BundleToken.self)
    return referenceObjects(inGroupNamed: asset.name, bundle: bundle) ?? Set()
  }
}
#endif

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal fileprivate(set) lazy var color: AssetColorTypeAlias = AssetColorTypeAlias(asset: self)
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension AssetColorTypeAlias {
  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: asset.name, bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
  #endif
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if (os(iOS) || os(tvOS) || os(macOS)) && swift(>=3.2)
  @available(iOS 9.0, macOS 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if (os(iOS) || os(tvOS) || os(macOS)) && swift(>=3.2)
@available(iOS 9.0, macOS 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    self.init(name: asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS) || os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
