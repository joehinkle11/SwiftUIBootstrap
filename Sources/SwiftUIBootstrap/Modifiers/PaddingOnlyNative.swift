//
//  PaddingOnlyNative.swift
//  
//
//  Created by Joseph Hinkle on 10/12/21.
//

// Makes it so that the padding is only applied to non-tokamak builds

import Foundation

#if canImport(TokamakDOM)
import TokamakDOM

public extension View {
//    func paddingOnlyNative(_ insets: TokamakDOM.Edge) -> Self {
//        return self
//    }
    
    func paddingOnlyNative(
        _ edges: TokamakDOM.Edge.Set = .all,
        _ length: CGFloat? = nil
    ) -> Self {
        return self
    }
}
#else
import SwiftUI

public extension View {
    func paddingOnlyNative(_ insets: EdgeInsets) -> some View {
        return self.padding(insets)
    }
    
    func paddingOnlyNative(
        _ edges: Edge.Set = .all,
        _ length: CGFloat? = nil
    ) -> some View {
        return self.padding(edges, length)
    }
}
#endif
