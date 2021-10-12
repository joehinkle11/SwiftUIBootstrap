//
//  OnHoverModifier.swift
//  
//
//  Created by Joseph Hinkle on 8/31/21.
//

#if canImport(TokamakDOM)
import Foundation
import TokamakDOM

public extension View {
    func onHover(perform onHover: @escaping (Bool) -> Void) -> some View {
        var listeners: [String : Listener] = [
            "mouseover": { _ in
                onHover(true)
            },
            "mouseout": { _ in
                onHover(false)
            }
        ]
        return DynamicHTML("div", listeners: listeners) {
            self
        }
    }
}
#endif
