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

public struct _RawStyleModifier: DOMViewModifier, ViewModifier {
    public let style: String
    public var attributes: [HTMLAttribute: String] {
        ["style": style + ";"]
    }
    
    public func body(content: Content) -> some View {
        content
    }
}

public extension TokamakDOM.View {
    func rawStyle(_ style: String) -> some View {
        modifier(_RawStyleModifier(style: style))
    }
}

#endif
