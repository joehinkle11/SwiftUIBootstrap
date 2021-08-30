//
//  BStackFrameOverride.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakShim)
import Foundation
import TokamakShim

public extension View {
    func frameOld(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        return self.frame(width: width, height: height)
    }
}

public extension BStack {
    @ViewBuilder
    func frame(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        let classStr: String = {
            var str = ""
            if width == .infinity {
                str += "w-100 "
            }
            if height == .infinity {
                str += "h-100"
            }
            return str
        }()
        let hasNonInfinteValue: Bool = {
            if let width = width, width != .infinity {
                return true
            }
            if let height = height, height != .infinity {
                return true
            }
            return false
        }()
        if classStr == "" {
            self.frameOld(width: width, height: height)
        } else {
            if hasNonInfinteValue {
                HTML("div", ["class":classStr]) {
                    self
                }.frameOld(width: width == .infinity ? nil : width, height: height == .infinity ? nil : height)
            } else {
                HTML("div", ["class":classStr]) {
                    self
                }
            }
        }
    }
}

#endif
