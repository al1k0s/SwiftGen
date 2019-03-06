//
// SwiftGenKit
// Copyright © 2019 SwiftGen
// MIT Licence
//

import Foundation
import PathKit

private struct ColorAsset: Codable {
  let colors: [IdiomAndColor]
}

private struct IdiomAndColor: Codable {
  let color: ColorSpaceWithComponents
}

private struct ColorSpaceWithComponents: Codable {
  struct Components: Codable {
    let red, green, blue, alpha: String
  }

  enum ColorSpace: String, Codable {
    case srgb
  }

  private let colorSpace: ColorSpace
  let components: Components

  enum CodingKeys: String, CodingKey {
    case colorSpace = "color-space"
    case components
  }
}

struct RGBA {
  let red, green, blue, alpha: Double
}

extension AssetsCatalog.Entry {
  final class ColorsetFileParser {
    func parseColor(contents: Path, colorName: String) throws -> RGBA {
      do {
        let decoder = JSONDecoder()
        let colors = try decoder.decode(ColorAsset.self, from: contents.read()).colors
        guard let color = colors.first?.color else {
            fatalError("Asset does not contain a color")
        }
        let parsedColor = try color.components.allComponents(path: contents)

        return parsedColor
      } catch {
        throw error
      }
    }
  }
}

extension ColorSpaceWithComponents.Components {
  typealias Component = Double

  typealias AllComponents = UInt32

  func detectComponent(from string: String, path: Path) throws -> Component {
    if string.contains("."), let color = Double(string) {
      return color
    } else if let color = UInt8(string.dropFirst(2), radix: 16) {
      return Double(color) / 255
    } else {
      throw Colors.ParserError.invalidHexColor(path: path, string: string, key: nil)
    }
  }

  func allComponents(path: Path) throws -> RGBA {
    let red = try detectComponent(from: self.red, path: path)
    let green = try detectComponent(from: self.green, path: path)
    let blue = try detectComponent(from: self.blue, path: path)
    let alpha = try detectComponent(from: self.alpha, path: path)

    return RGBA(red: red, green: green, blue: blue, alpha: alpha)
  }
}
