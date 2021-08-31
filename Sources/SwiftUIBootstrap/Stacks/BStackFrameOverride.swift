//
//  BStackFrameOverride.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakDOM)
import Foundation
import TokamakDOM

public extension View {
    func frameOld(
        minWidth: CGFloat? = nil,
        idealWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        idealHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: TokamakDOM.Alignment = .center
    ) -> some View {
        return self.frame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment)
    }
}

public extension BStack {
    @ViewBuilder
    func frame(
        minWidth: CGFloat? = nil,
        idealWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        idealHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: TokamakDOM.Alignment = .center
    ) -> some View {
        let classStr: String = {
            var str = ""
            if maxWidth == .infinity {
                str += "w-100 "
            }
            if maxHeight == .infinity {
                str += "h-100"
            }
            return str
        }()
        let hasNonInfiniteValue: Bool = {
            if let maxWidth = maxWidth, maxWidth != .infinity {
                return true
            }
            if let maxHeight = maxHeight, maxHeight != .infinity {
                return true
            }
            return false
        }()
        if classStr == "" {
            self.frameOld(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment)
        } else {
            if hasNonInfiniteValue {
                HTML("div", ["class":classStr]) {
                    self
                }.frameOld(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth == .infinity ? nil : maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight == .infinity ? nil : maxHeight, alignment: alignment)
            } else {
                HTML("div", ["class":classStr]) {
                    self
                }
            }
        }
    }
}

#endif
