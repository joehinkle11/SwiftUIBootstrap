//
//  ViewArrayBuilder.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakShim)
import Foundation
import TokamakShim

@_functionBuilder public enum ViewArrayBuilder {
    public static func buildBlock() -> [AnyViewOrSpacer] { [] }
    
    public static func buildBlock<Content>(
        _ content: Content
    ) -> [AnyViewOrSpacer] where Content: View {
        [AnyViewOrSpacer(content)]
    }
    
    public static func buildIf(_ content: [AnyViewOrSpacer]?) -> [AnyViewOrSpacer] {
        content ?? []
    }
    
    public static func buildEither<TrueContent>(
        first: TrueContent
    ) -> AnyViewOrSpacer where TrueContent: View {
        AnyViewOrSpacer(first)
    }
    
    public static func buildEither(first component: [AnyViewOrSpacer]) -> [AnyViewOrSpacer] {
        component
    }
    
    public static func buildEither(second component: [AnyViewOrSpacer]) -> [AnyViewOrSpacer] {
        component
    }
    
    public static func buildEither<FalseContent>(
        second: FalseContent
    ) -> AnyViewOrSpacer where FalseContent: View {
        AnyViewOrSpacer(second)
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
#endif
