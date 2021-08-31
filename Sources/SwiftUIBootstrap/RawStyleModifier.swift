//
//  RawStyleModifier.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakDOM)
import Foundation
import TokamakCore
import TokamakDOM
import TokamakStaticHTML


public struct RawStyleModifier: DOMViewModifier {
    public let style: String
    public var attributes: [HTMLAttribute: String] {
        fatalError()
        return ["style": style]
    }
}

public extension View {
    func rawStyle(_ style: String) -> ModifiedContent<Self, RawStyleModifier> {
        self.modifier(RawStyleModifier(style: style))
    }
}
#endif
