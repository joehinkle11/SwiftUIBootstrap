//
//  Hacks.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

public enum PointerEvents: String {
    case none, auto
}

#if canImport(TokamakDOM)
import Foundation
import TokamakDOM

public extension View {
    func pointerEvents(_ pointerEvent: PointerEvents) -> some View {
        self.rawStyle("pointer-events:\(pointerEvent.rawValue);width:100%;height:100%")
    }
}
#else
public extension View {
    func pointerEvents(_ pointerEvent: PointerEvents) -> some View {
        self
    }
}
#endif
