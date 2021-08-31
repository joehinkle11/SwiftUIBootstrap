//
//  FillRestOfDivView.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakDOM)
import Foundation
import TokamakDOM

public struct FillRestOfDivView: View {
    public let body: AnyView
    init<Content: View>(_ view: Content) {
        self.body = AnyView(view)
    }
}

public extension View {
    func fillRestOfDiv() -> FillRestOfDivView {
        FillRestOfDivView(self)
    }
}
#else
public extension View {
    func fillRestOfDiv() -> some View {
        self
    }
}
#endif

