//
//  BStacks.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakShim)
import Foundation
import TokamakShim

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


public let defaultStackSpacing: CGFloat = 8

public struct AnyViewOrSpacer {
    let anyView: AnyView?
    let spacer: Spacer?
    
    init<T: View>(_ view: T) {
        if let spacer = view as? Spacer {
            self.anyView = nil
            self.spacer = spacer
        } else {
            self.anyView = AnyView(view)
            self.spacer = nil
        }
    }
    
    var isSpacer: Bool {
        spacer != nil
    }
    
    @ViewBuilder
    var view: some View {
        if let spacer = spacer {
            spacer
        } else {
            anyView
        }
    }
}

public struct BHStack: View {
    let alignment: VerticalAlignment
    let spacing: CGFloat
    var spacingInt: Int {
        max(0, min(5, Int(spacing)))
    }
    let content: () -> [AnyViewOrSpacer]

    public init(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewArrayBuilder content: @escaping () -> [AnyViewOrSpacer]
    ) {
        self.alignment = alignment
        self.spacing = spacing ?? defaultStackSpacing
        self.content = content
    }
    
    public var body: some View {
        HTML("div", ["class": "container-fluid p-0"]) {
            HTML("div", ["class": "row \(spacingInt == 0 ? "g-0" : "gx-\(spacingInt)")"]) {
                let views = content()
                ForEach(0..<views.count) { i in
                    let view = views[i]
                    HTML("div", ["class": view.isSpacer ? "col" : "col-auto"]) {
                        view.view
                    }
                }
            }
        }
    }
}

public struct BVStack: View {
    let alignment: HorizontalAlignment
    let spacing: CGFloat
    var spacingRounded: Double {
        Double(Int(spacing * 100)) * 0.01
    }
    let content: () -> [AnyViewOrSpacer]

    public init(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewArrayBuilder content: @escaping () -> [AnyViewOrSpacer]
    ) {
        self.alignment = alignment
        self.spacing = spacing ?? defaultStackSpacing
        self.content = content
    }
    
    public var body: some View {
        HTML("div", ["class": "h-100 d-flex flex-column p-0"]) {
            let views = content()
            let hasNoSpacers = !views.contains(where: {$0.isSpacer})
            ForEach(0..<views.count) { i in
                let view = views[i]
                let isFirst = i == 0
                let isLast = i == views.count - 1
                HTML("div", [
                    "class": "flex-column justify-content-center\(hasNoSpacers || view.isSpacer ? " flex-grow-1" : "")",
                    "style": "\(isFirst ? "" : "padding-top:\(spacingRounded)px;")\(isLast ? "" : "padding-bottom:\(spacingRounded)px;")"
                ]) {
                    view.view
                }
            }
        }
    }
}
@_functionBuilder public enum ViewArrayBuilder {
  public static func buildBlock() -> [AnyViewOrSpacer] { [] }

  public static func buildBlock<Content>(
    _ content: Content
  ) -> [AnyViewOrSpacer] where Content: View {
    [AnyViewOrSpacer(content)]
  }
}
public extension ViewArrayBuilder {
  static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> [AnyViewOrSpacer]
    where C0: View, C1: View
  {
    [AnyViewOrSpacer(c0),AnyViewOrSpacer(c1)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2
  ) -> [AnyViewOrSpacer] where C0: View, C1: View, C2: View {
    [AnyViewOrSpacer(c0),AnyViewOrSpacer(c1),AnyViewOrSpacer(c2)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2, C3>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2,
    _ c3: C3
  ) -> [AnyViewOrSpacer] where C0: View, C1: View, C2: View, C3: View {
    [AnyViewOrSpacer(c0),AnyViewOrSpacer(c1),AnyViewOrSpacer(c2),AnyViewOrSpacer(c3)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2, C3, C4>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2,
    _ c3: C3,
    _ c4: C4
  ) -> [AnyViewOrSpacer] where C0: View, C1: View, C2: View, C3: View, C4: View {
    [AnyViewOrSpacer(c0),AnyViewOrSpacer(c1),AnyViewOrSpacer(c2),AnyViewOrSpacer(c3),AnyViewOrSpacer(c4)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2, C3, C4, C5>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2,
    _ c3: C3,
    _ c4: C4,
    _ c5: C5
  ) -> [AnyViewOrSpacer]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View
  {
    [AnyViewOrSpacer(c0),AnyViewOrSpacer(c1),AnyViewOrSpacer(c2),AnyViewOrSpacer(c3),AnyViewOrSpacer(c4),AnyViewOrSpacer(c5)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2,
    _ c3: C3,
    _ c4: C4,
    _ c5: C5,
    _ c6: C6
  ) -> [AnyViewOrSpacer]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View
  {
    [AnyViewOrSpacer(c0),AnyViewOrSpacer(c1),AnyViewOrSpacer(c2),AnyViewOrSpacer(c3),AnyViewOrSpacer(c4),AnyViewOrSpacer(c5),AnyViewOrSpacer(c6)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2,
    _ c3: C3,
    _ c4: C4,
    _ c5: C5,
    _ c6: C6,
    _ c7: C7
  ) -> [AnyViewOrSpacer]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View
  {
    [AnyViewOrSpacer(c0),AnyViewOrSpacer(c1),AnyViewOrSpacer(c2),AnyViewOrSpacer(c3),AnyViewOrSpacer(c4),AnyViewOrSpacer(c5),AnyViewOrSpacer(c6),AnyViewOrSpacer(c7)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2,
    _ c3: C3,
    _ c4: C4,
    _ c5: C5,
    _ c6: C6,
    _ c7: C7,
    _ c8: C8
  ) -> [AnyViewOrSpacer]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View
  {
    [AnyViewOrSpacer(c0),AnyViewOrSpacer(c1),AnyViewOrSpacer(c2),AnyViewOrSpacer(c3),AnyViewOrSpacer(c4),AnyViewOrSpacer(c5),AnyViewOrSpacer(c6),AnyViewOrSpacer(c7),AnyViewOrSpacer(c8)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2,
    _ c3: C3,
    _ c4: C4,
    _ c5: C5,
    _ c6: C6,
    _ c7: C7,
    _ c8: C8,
    _ c9: C9
  ) -> [AnyViewOrSpacer]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View,
    C9: View
  {
    [AnyViewOrSpacer(c0),AnyViewOrSpacer(c1),AnyViewOrSpacer(c2),AnyViewOrSpacer(c3),AnyViewOrSpacer(c4),AnyViewOrSpacer(c5),AnyViewOrSpacer(c6),AnyViewOrSpacer(c7),AnyViewOrSpacer(c8),AnyViewOrSpacer(c9)]
  }
}
#else
typealias BHStack = BHStack
typealias BVStack = BVStack
#endif
