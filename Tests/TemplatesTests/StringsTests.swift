//
// Templates UnitTests
// Copyright © 2019 SwiftGen
// MIT Licence
//

import StencilSwiftKit
import XCTest

class StringsTests: XCTestCase {
  enum Contexts {
    static let all = ["empty", "localizable", "multiple"]
  }

  // generate variations to test customname generation
  let variations: VariationGenerator = { name, context in
    guard name == "localizable" else { return [(context: context, suffix: "")] }

    return [
      (context: context,
       suffix: ""),
      (context: try StencilContext.enrich(context: context, parameters: ["enumName=XCTLoc"]),
       suffix: "-customName"),
      (context: try StencilContext.enrich(context: context, parameters: ["noComments"]),
       suffix: "-noComments"),
      (context: try StencilContext.enrich(context: context, parameters: ["publicAccess"]),
       suffix: "-publicAccess"),
      (context: try StencilContext.enrich(
        context: context,
        parameters: ["localizeFunction=XCTLocFunc"]
       ),
       suffix: "-localizeFunction")
    ]
  }

  func testFlatSwift3() {
    test(
      template: "flat-swift3",
      contextNames: Contexts.all,
      directory: .strings,
      contextVariations: variations
    )
  }

  func testFlatSwift4() {
    test(
      template: "flat-swift4",
      contextNames: Contexts.all,
      directory: .strings,
      contextVariations: variations
    )
  }

  func testFlatSwift5() {
    test(
      template: "flat-swift5",
      contextNames: Contexts.all,
      directory: .strings,
      contextVariations: variations
    )
  }

  func testStructuredSwift3() {
    test(
      template: "structured-swift3",
      contextNames: Contexts.all,
      directory: .strings,
      contextVariations: variations
    )
  }

  func testStructuredSwift4() {
    test(
      template: "structured-swift4",
      contextNames: Contexts.all,
      directory: .strings,
      contextVariations: variations
    )
  }

  func testStructuredSwift5() {
    test(
      template: "structured-swift5",
      contextNames: Contexts.all,
      directory: .strings,
      contextVariations: variations
    )
  }
}
