//
//  BrightnessModifier.swift
//  
//
//  Created by Joseph Hinkle on 8/31/21.
//


#if canImport(TokamakDOM)
import Foundation
import TokamakDOM

public extension View {
    func brightness(_ amount: Double) -> some View {
        let amt = max(0, (amount + 1) * 2)
        return self.rawStyle("filter: brightness(\(String(format: "%.2f", amt)))")
    }
}

public extension View {
    func blur(radius: CGFloat) -> some View {
        return self.rawStyle("filter: blur(\(String(format: "%.2f", radius))px);")
    }
}
#endif
