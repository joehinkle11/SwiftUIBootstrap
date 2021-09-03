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

// helps old hover targets know that they are no longing being hovered on even when swiftui fails to tell them so
final class IsHovering: ObservableObject {
    static var hoverObjects: [Weak<IsHovering>] = []
    let id: UUID
    init() {
        self.id = UUID()
        Self.hoverObjects.append(Weak(value: self))
    }
    @Published private var privateIsHovering: Bool = false
    var isHovering: Bool {
        privateIsHovering
    }
    func onHover(isHovering: Bool) {
        if isHovering {
            startHovering()
            for weakRef in Self.hoverObjects {
                if let isHoveringObj = weakRef.value {
                    if isHoveringObj.id != self.id {
                        isHoveringObj.stopHovering()
                    }
                }
            }
            Self.hoverObjects.reap()
        } else {
            stopHovering()
        }
    }
    private func startHovering() {
        if !privateIsHovering {
            self.privateIsHovering = true
        }
    }
    private func stopHovering() {
        if privateIsHovering {
            privateIsHovering = false
        }
    }
}
// weak reference array from this stackoverflow answer https://stackoverflow.com/questions/24127587/how-do-i-declare-an-array-of-weak-references-in-swift
class Weak<T: AnyObject> {
    weak var value : T?
    init (value: T) {
        self.value = value
    }
}
extension Array where Element:Weak<IsHovering> {
    mutating func reap() {
        self = self.filter { nil != $0.value }
    }
}
#endif

public typealias HoverEffectedView = HoverButton
public struct HoverButton: View {
    #if canImport(TokamakDOM)
    @Environment(\.colorScheme) var colorScheme
    var listeners: [String : Listener] {
        var listeners: [String : Listener] = [:]
        if !noAction {
            listeners["click"] = { _ in
                action()
            }
        }
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
    let noAction: Bool // when true, this will not actually be a button but just something with a hover effect
    
    #if os(macOS) || os(iOS)
    @StateObject private var isHoveringObj: IsHovering = IsHovering()
    var isHovering: Bool {
        isHoveringObj.isHovering
    }
    #elseif canImport(TokamakDOM)
    @State private var isHovering = false
    #endif
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.label = nil
        self.customHoverLabel = nil
        self.noAction = false
    }
    public init(_ nonButtonTitle: String) {
        self.title = nonButtonTitle
        self.action = {}
        self.label = nil
        self.customHoverLabel = nil
        self.noAction = true
    }
    public init<Label: View>(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.title = nil
        self.action = action
        self.label = {
            AnyView(label())
        }
        self.customHoverLabel = nil
        self.noAction = false
    }
    public init<Label: View>(@ViewBuilder nonButtonLabel: @escaping () -> Label) {
        self.title = nil
        self.action = {}
        self.label = {
            AnyView(nonButtonLabel())
        }
        self.customHoverLabel = nil
        self.noAction = true
    }
    public init<Label: View>(action: @escaping () -> Void, @ViewBuilder customHoverLabel: @escaping (Bool) -> Label) {
        self.title = nil
        self.action = action
        self.label = nil
        self.customHoverLabel = {
            AnyView(customHoverLabel($0))
        }
        self.noAction = false
    }
    public init<Label: View>(@ViewBuilder nonButtonHoverLabel: @escaping (Bool) -> Label) {
        self.title = nil
        self.action = {}
        self.label = nil
        self.customHoverLabel = {
            AnyView(nonButtonHoverLabel($0))
        }
        self.noAction = true
    }
    
    @ViewBuilder
    var button: some View {
        if let customHoverLabel = customHoverLabel {
            #if canImport(TokamakDOM)
            DynamicHTML(noAction ? "div" : "button", [
                "class":"\(noAction ? "" : "btn ")w-100 h-100",
                "style":"box-shadow:none"
            ], listeners: listeners) {
                customHoverLabel(isHovering)
            }
            #else
            if noAction {
                ZStack {
                    Text("\(isHovering ? "." : "")").frame(width: 1, height: 1).opacity(0) // forces update
                    customHoverLabel(isHovering)
                }
            } else {
                Button(action: action, label: {
                    customHoverLabel(isHovering)
                })
            }
            #endif
        } else if let title = title {
            #if canImport(TokamakDOM)
            BootstrapButton(colorScheme == .dark ? .dark : .light, rawStyle: "filter: brightness(\(isHovering ? "1.5" : "1"))", action: action) {
                Text(title).foregroundColor(colorScheme == .dark ? .white : .black)
            } onHover: {
                isHovering = $0
            }
            #else
            if noAction {
                ZStack {
                    Text("\(isHovering ? "." : "")").frame(width: 1, height: 1).opacity(0) // forces update
                    Text(title).brightness(isHovering ? 0.2 : 0)
                }
            } else {
                Button(title, action: action)
                    .brightness(isHovering ? 0.2 : 0)
            }
            #endif
        } else if let label = label {
            #if canImport(TokamakDOM)
            DynamicHTML(noAction ? "div" : "button", [
                "class":"\(noAction ? "" : "btn ")w-100 h-100",
                "style":"box-shadow:none;filter: brightness(\(isHovering ? "1.5" : "1"))"
            ], listeners: listeners) {
                label()
            }
            #else
            if noAction {
                ZStack {
                    Text("\(isHovering ? "." : "")").frame(width: 1, height: 1).opacity(0) // forces update
                    label().brightness(isHovering ? 0.2 : 0)
                }
            } else {
                Button(action: action, label: label)
                    .brightness(isHovering ? 0.2 : 0)
            }
            #endif
        }
    }
    
    @ViewBuilder
    public var body: some View {
        #if canImport(TokamakDOM)
        button
        #else
        button.onHover(perform: isHoveringObj.onHover)
        #endif
    }
}
