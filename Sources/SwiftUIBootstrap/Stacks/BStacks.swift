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

public let defaultStackSpacing: CGFloat = 8

public struct BHStack: View {
    let alignment: VerticalAlignment
    let spacing: CGFloat
    var spacingInt: Int {
        max(0, min(5, Int(spacing)))
    }
    let content: () -> [AnyView]

    public init(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewArrayBuilder content: @escaping () -> [AnyView]
    ) {
        self.alignment = alignment
        self.spacing = spacing ?? defaultStackSpacing
        self.content = content
    }
    
    public var body: some View {
        HTML("div", ["class": "container-fluid"]) {
            HTML("div", ["class": "row \(spacingInt == 0 ? "g-0" : "gx-\(spacingInt)")"]) {
                let views = content()
                ForEach(0..<views.count) { i in
                    let view = views[i]
                    HTML("div", ["class": "col"]) {
                        view.background(Color.red)
                    }
                }
            }
        }
    }
}

public struct BVStack<Content: View>: View {
    let alignment: VerticalAlignment
    let spacing: CGFloat
    let content: Content

    public init(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing ?? defaultStackSpacing
        self.content = content()
    }
    
    public var body: some View {
        HTML("div", ["class": "container"]) {
            HTML("div", ["class": "col"]) {
                HTML("div", ["class": "row"]) {
                    Text("one")
                }
            }
        }
    }
}
@_functionBuilder public enum ViewArrayBuilder {
  public static func buildBlock() -> [AnyView] { [] }

  public static func buildBlock<Content>(
    _ content: Content
  ) -> [AnyView] where Content: View {
    [AnyView(content)]
  }
}
public extension ViewArrayBuilder {
  static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> [AnyView]
    where C0: View, C1: View
  {
    [AnyView(c0),AnyView(c1)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2
  ) -> [AnyView] where C0: View, C1: View, C2: View {
    [AnyView(c0),AnyView(c1),AnyView(c2)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2, C3>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2,
    _ c3: C3
  ) -> [AnyView] where C0: View, C1: View, C2: View, C3: View {
    [AnyView(c0),AnyView(c1),AnyView(c2),AnyView(c3)]
  }
}

public extension ViewArrayBuilder {
  static func buildBlock<C0, C1, C2, C3, C4>(
    _ c0: C0,
    _ c1: C1,
    _ c2: C2,
    _ c3: C3,
    _ c4: C4
  ) -> [AnyView] where C0: View, C1: View, C2: View, C3: View, C4: View {
    [AnyView(c0),AnyView(c1),AnyView(c2),AnyView(c3),AnyView(c4)]
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
  ) -> [AnyView]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View
  {
    [AnyView(c0),AnyView(c1),AnyView(c2),AnyView(c3),AnyView(c4),AnyView(c5)]
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
  ) -> [AnyView]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View
  {
    [AnyView(c0),AnyView(c1),AnyView(c2),AnyView(c3),AnyView(c4),AnyView(c5),AnyView(c6)]
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
  ) -> [AnyView]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View
  {
    [AnyView(c0),AnyView(c1),AnyView(c2),AnyView(c3),AnyView(c4),AnyView(c5),AnyView(c6),AnyView(c7)]
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
  ) -> [AnyView]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View
  {
    [AnyView(c0),AnyView(c1),AnyView(c2),AnyView(c3),AnyView(c4),AnyView(c5),AnyView(c6),AnyView(c7),AnyView(c8)]
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
  ) -> [AnyView]
    where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View,
    C9: View
  {
    [AnyView(c0),AnyView(c1),AnyView(c2),AnyView(c3),AnyView(c4),AnyView(c5),AnyView(c6),AnyView(c7),AnyView(c8),AnyView(c9)]
  }
}
#else
typealias BHStack = BHStack
typealias BVStack = BVStack
#endif
