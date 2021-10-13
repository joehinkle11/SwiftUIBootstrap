//
//  ScaleEffect.swift
//  
//
//  Created by Joseph Hinkle on 10/12/21.
//


#if canImport(TokamakDOM)
import Foundation
import TokamakDOM

public extension View {
    @inlinable
    func scaleEffectCSS(_ s: CGFloat, anchor: UnitPoint = .center) -> some View {
//        self.rawStyle("transform-origin: center;transform: scale(\(String(format: "%.2f", s)))")
//        let amt = max(0, (s + 1) * 2)
//        return self.rawStyle("filter: brightness(\(String(format: "%.2f", amt)))")
        self
    }
}
#else
import Foundation
import SwiftUI

public extension View {
    @inlinable
    func scaleEffectCSS(_ s: CGFloat, anchor: UnitPoint = .center) -> some View {
        self.scaleEffect(s, anchor: anchor)
    }
}
#endif
