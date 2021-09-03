//
//  BStacks.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

public enum FillSpace {
    case horizontal, vertical, all, none
    
    var classStr: String {
        switch self {
        case .horizontal:
            return " w-100"
        case .vertical:
            return " h-100"
        case .all:
            return " w-100 h-100"
        case .none:
            return ""
        }
    }
    
    var isVertical: Bool {
        switch self {
        case .vertical, .all: return true
        default: return false
        }
    }
}

#if canImport(TokamakDOM)
import Foundation
import TokamakDOM

/// An alignment position along the vertical axis.
public enum VerticalAlignment: Equatable {
    case top
    case center
    case bottom
}

/// An alignment position along the horizontal axis.
public enum HorizontalAlignment: Equatable {
    case leading
    case center
    case trailing
}

/// An alignment in both axes.
public struct Alignment: Equatable {
  public var horizontal: HorizontalAlignment
  public var vertical: VerticalAlignment

  public init(
    horizontal: HorizontalAlignment,
    vertical: VerticalAlignment
  ) {
    self.horizontal = horizontal
    self.vertical = vertical
  }

  public static let topLeading = Self(horizontal: .leading, vertical: .top)
  public static let top = Self(horizontal: .center, vertical: .top)
  public static let topTrailing = Self(horizontal: .trailing, vertical: .top)
  public static let leading = Self(horizontal: .leading, vertical: .center)
  public static let center = Self(horizontal: .center, vertical: .center)
  public static let trailing = Self(horizontal: .trailing, vertical: .center)
  public static let bottomLeading = Self(horizontal: .leading, vertical: .bottom)
  public static let bottom = Self(horizontal: .center, vertical: .bottom)
  public static let bottomTrailing = Self(horizontal: .trailing, vertical: .bottom)
}

public let defaultStackSpacing: CGFloat = 8

public protocol BStack: View {}
extension BStack {
    func marginValueForHorizontalAlign(with alignment: HorizontalAlignment) -> String {
        switch alignment {
        case .leading:
            return "auto auto auto 0"
        case .center:
            return "0 auto"
        case .trailing:
            return "auto 0 auto auto"
        }
    }
}

extension Array: View where Element == AnyViewOrSpacer {
    public var body: Never {
        fatalError()
    }
    func flatten() -> [AnyViewOrSpacer] {
        var arr: [AnyViewOrSpacer] = []
        for el in self {
            if let subArr = el.arr {
                arr.append(contentsOf: subArr.flatten())
            } else {
                arr.append(el)
            }
        }
        return arr
    }
}

public struct AnyViewOrSpacer: View {
    let arr: [AnyViewOrSpacer]?
    let anyView: AnyView?
    let spacer: Spacer?
    let fillRestOfDivView: FillRestOfDivView?
    
    init<T: View>(_ view: T) {
        if let anyViewOrSpacer = view as? AnyViewOrSpacer {
            self.arr = nil
            self.anyView = anyViewOrSpacer.anyView
            self.spacer = anyViewOrSpacer.spacer
            self.fillRestOfDivView = nil
        } else if let anyViewOrSpacers = view as? [AnyViewOrSpacer] {
            self.arr = anyViewOrSpacers
            self.anyView = nil
            self.spacer = nil
            self.fillRestOfDivView = nil
        } else if let spacer = view as? Spacer {
            self.arr = nil
            self.anyView = nil
            self.spacer = spacer
            self.fillRestOfDivView = nil
        } else if let fillRestOfDivView = view as? FillRestOfDivView {
            self.arr = nil
            self.anyView = nil
            self.spacer = nil
            self.fillRestOfDivView = fillRestOfDivView
        } else {
            self.arr = nil
            self.anyView = AnyView(view)
            self.spacer = nil
            self.fillRestOfDivView = nil
        }
    }
    
    var shouldFillView: Bool {
        spacer != nil || fillRestOfDivView != nil
    }
    
    @ViewBuilder
    public var body: some View {
        if let spacer = spacer {
            spacer
        } else if let fillRestOfDivView = fillRestOfDivView {
            fillRestOfDivView.body
        } else if let anyView = anyView {
            anyView
        }
    }
}

public struct BHStack: BStack {
    let alignment: VerticalAlignment
    var verticalAlignKey: String {
        switch alignment {
        case .top:
            return "top"
        case .center:
            return "middle"
        case .bottom:
            return "bottom"
        }
    }
    let spacing: CGFloat
    var spacingRounded: Double {
        Double(Int(spacing * 100)) * 0.01
    }
    let fillSpace: FillSpace
    let forceCenter: Bool
    let content: () -> [AnyViewOrSpacer]
    
    public init(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        fillSpace: FillSpace = .none,
        forceCenter: Bool = false,
        @ViewArrayBuilder content: @escaping () -> [AnyViewOrSpacer]
    ) {
        self.alignment = alignment
        self.spacing = spacing ?? defaultStackSpacing
        self.fillSpace = fillSpace
        self.forceCenter = forceCenter
        self.content = content
    }
    
    public var body: some View {
        HTML("div", ["class": "w-100 d-flex flex-row p-0"]) {
            let _views = content().flatten()
            let hasSpacers = _views.contains(where: {$0.shouldFillView})
            let views: [AnyViewOrSpacer] = {
                if forceCenter {
                    return hasSpacers ? _views : ([AnyViewOrSpacer(Spacer())] + _views + [AnyViewOrSpacer(Spacer())])
                } else {
                    return _views
                }
            }()
            ForEach(0..<views.count) { i in
                let view = views[i]
                let isFirst = i == 0
                let isLast = i == views.count - 1
                HTML("div", [
                    "class": "flex-row justify-content-center\(view.shouldFillView ? " flex-grow-1" : "")\(hasSpacers ? "" : fillSpace.classStr)",
                    "style": "\(isFirst ? "" : "padding-left:\(spacingRounded)px;")\(isLast ? "" : "padding-right:\(spacingRounded)px");display:table"
                ]) {
                    HTML("div", [
                        "class": fillSpace.classStr,
                        "style":"display:table-cell;vertical-align:\(verticalAlignKey)"
                    ]) {
                        view
                    }
                }
            }
        }
    }
}

public struct BVStack: BStack {
    let alignment: HorizontalAlignment
    let spacing: CGFloat
    var spacingRounded: Double {
        Double(Int(spacing * 100)) * 0.01
    }
    let fillSpace: FillSpace
    let content: () -> [AnyViewOrSpacer]
    
    public init(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        fillSpace: FillSpace = .none,
        @ViewArrayBuilder content: @escaping () -> [AnyViewOrSpacer]
    ) {
        self.alignment = alignment
        self.spacing = spacing ?? defaultStackSpacing
        self.fillSpace = fillSpace
        self.content = content
    }
    
    public var body: some View {
        HTML("div", ["class": "h-100 d-flex flex-column p-0"]) {
            let _views = content().flatten()
            let hasSpacers = _views.contains(where: {$0.shouldFillView})
            let views: [AnyViewOrSpacer] = hasSpacers ? _views : ([AnyViewOrSpacer(Spacer())] + _views + [AnyViewOrSpacer(Spacer())])
            ForEach(0..<views.count) { i in
                let view = views[i]
                let isFirst = i == 0
                let isLast = i == views.count - 1
                HTML("div", [
                    "class": "flex-column justify-content-center\(view.shouldFillView ? " flex-grow-1" : "")\(fillSpace.classStr)",
                    "style": "\(isFirst ? "" : "padding-top:\(spacingRounded)px;")\(isLast ? "" : "padding-bottom:\(spacingRounded)px");margin:\(marginValueForHorizontalAlign(with: alignment))"
                ]) {
                    view
                }
            }
        }
    }
}


public struct BZStack: BStack {
    let alignment: Alignment
    var textAlignKey: String {
        switch alignment.horizontal {
        case .leading:
            return "left"
        case .center:
            return "center"
        case .trailing:
            return "right"
        }
    }
    var verticalAlignKey: String {
        switch alignment.vertical {
        case .top:
            return "top"
        case .center:
            return "middle"
        case .bottom:
            return "bottom"
        }
    }
    let fillSpace: FillSpace
    let content: () -> [AnyViewOrSpacer]
    
    public init(
        alignment: Alignment = .center,
        fillSpace: FillSpace = .none,
        @ViewArrayBuilder content: @escaping () -> [AnyViewOrSpacer]
    ) {
        self.alignment = alignment
        self.fillSpace = fillSpace
        self.content = content
    }
    public var body: some View {
        HTML("div", ["class": "p-0 m-0\(fillSpace.classStr)","style":"display:grid\(fillSpace.isVertical ? "" : ";height:inherit")"]) {
            let views = content().flatten()
            ForEach(0..<views.count) { i in
                let view = views[i]
                HTML("div", [
                    "class":"w-100 h-100 p-0 m-0",
                    "style": "grid-area: 1 / 1 / 1 / 1;text-align:\(textAlignKey);display:table;z-index:\(i)"
                ]) {
                    HTML("div", [
                        "class": fillSpace.classStr,
                        "style":"display:table-cell;vertical-align:\(verticalAlignKey)"
                    ]) {
                        view
                    }
                }
            }
        }
    }
}
#else
import SwiftUI
public typealias BHStack = HStack
public extension BHStack {
    init(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        fillSpace: FillSpace = .none,
        forceCenter: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(alignment: alignment, spacing: spacing, content: content)
    }
}
public typealias BVStack = VStack
public extension BVStack {
    init(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        fillSpace: FillSpace = .none,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(alignment: alignment, spacing: spacing, content: content)
    }
}
public typealias BZStack = ZStack
public extension BZStack {
    init(
        alignment: SwiftUI.Alignment = .center,
        fillSpace: FillSpace,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(alignment: alignment, content: content)
    }
}
#endif
