//
//  BScrollView.swift
//  
//
//  Created by Joseph Hinkle on 10/12/21.
//


#if canImport(TokamakDOM)

import Foundation
import TokamakDOM

public struct BScrollView: View {
    let showsIndicators: Bool
    let height: String?
    let content: () -> [AnyViewOrSpacer]
    
    public init(
        showsIndicators: Bool = true,
        height: String? = nil,
        @ViewArrayBuilder content: @escaping () -> [AnyViewOrSpacer]
    ) {
        self.showsIndicators = showsIndicators
        self.height = height
        self.content = content
    }
    public var body: some View {
        HTML("div", ["style":"height:\(height == nil ? "100%" : height!);overflow:auto;"]) {
            let views = content().flatten()
            ForEach(0..<views.count) { i in
                let view = views[i]
                HTML("div", [
                    "class":"w-100 h-100 p-0 m-0",
                    "style": "grid-area: 1 / 1 / 1 / 1;text-align:\("center");display:table;z-index:\(i)"
                ]) {
                    HTML("div", [
                        "class": "",
                        "style":"display:table-cell;vertical-align:\("middle")"
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
public typealias BScrollView = ScrollView
#endif
