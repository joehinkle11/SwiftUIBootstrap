//
//  HoverButton.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakDOM)
import TokamakDOM
#else
import SwiftUI
#endif

public struct HoverButton: View {
    #if canImport(TokamakDOM)
    @Environment(\.colorScheme) var colorScheme
    var listeners: [String : Listener] {
        var listeners: [String : Listener] = [
            "click": { _ in
                action()
            }
        ]
        listeners["mouseover"] = { _ in
            isHovering = true
        }
        listeners["mouseout"] = { _ in
            isHovering = false
        }
        return listeners
    }
    #endif
    let title: String?
    let action: () -> Void
    let label: (() -> AnyView)?
    let customHoverLabel: ((Bool) -> AnyView)?
    
    #if os(macOS) || canImport(TokamakDOM)
    @State private var isHovering = false
    #endif
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.label = nil
        self.customHoverLabel = nil
    }
    public init<Label: View>(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.title = nil
        self.action = action
        self.label = {
            AnyView(label())
        }
        self.customHoverLabel = nil
    }
    public init<Label: View>(action: @escaping () -> Void, @ViewBuilder customHoverLabel: @escaping (Bool) -> Label) {
        self.title = nil
        self.action = action
        self.label = nil
        self.customHoverLabel = {
            AnyView(customHoverLabel($0))
        }
    }
    
    @ViewBuilder
    var button: some View {
        if let customHoverLabel = customHoverLabel {
            #if canImport(TokamakDOM)
            DynamicHTML("button", [
                "class":"btn w-100 h-100",
                "style":"box-shadow:none"
            ], listeners: listeners) {
                customHoverLabel(isHovering)
            }
            #else
            Button(action: action, label: {
                #if os(macOS)
                
                #else
                customHoverLabel(false)
                #endif
            })
            #endif
        } else if let title = title {
            #if canImport(TokamakDOM)
            BootstrapButton(colorScheme == .dark ? .dark : .light, rawStyle: "filter: brightness(\(isHovering ? "1.5" : "1"))", action: action) {
                Text(title).foregroundColor(colorScheme == .dark ? .white : .black)
            } onHover: {
                isHovering = $0
            }
            #elseif os(iOS)
            Button(title, action: action)
            #else
            Button(title, action: action)
                .brightness(isHovering ? 0.2 : 0)
            #endif
        } else if let label = label {
            #if canImport(TokamakDOM)
            DynamicHTML("button", [
                "class":"btn w-100 h-100",
                "style":"box-shadow:none;filter: brightness(\(isHovering ? "1.5" : "1"))"
            ], listeners: listeners) {
                label()
            }
            #elseif os(iOS)
            Button(action: action, label: label)
            #else
            Button(action: action, label: label)
                .brightness(isHovering ? 0.2 : 0)
            #endif
        }
    }
    
    @ViewBuilder
    public var body: some View {
        #if os(iOS)
        button
        #elseif canImport(TokamakDOM)
        button
        #else
        // mac
        button.onHover { isHovering = $0 }
        #endif
    }
}
