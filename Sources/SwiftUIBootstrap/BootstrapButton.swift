//
//  BootstrapButtonStyle.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//


#if canImport(TokamakDOM)
import Foundation
import TokamakDOM

public enum BootstrapButtonStyle: String {
    case primary
    case secondary
    case success
    case danger
    case warning
    case info
    case light
    case dark
    case link
}

public enum BootstrapButtonSize: String {
    case lg, sm
}

public struct BootstrapButton<Label> : View where Label : View {
    
    let isOutlined: Bool
    let style: BootstrapButtonStyle
    let rawStyle: String
    let size: BootstrapButtonSize?
    let action: () -> Void
    let label: () -> Label
    let onHover: ((Bool) -> ())?
    
    var sizeStr: String {
        if let size = size {
            return " btn-\(size.rawValue)"
        }
        return ""
    }
    
    public init(_ style: BootstrapButtonStyle = .primary, rawStyle: String = "", isOutlined: Bool = false, size: BootstrapButtonSize? = nil, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label, onHover: ((Bool) -> ())? = nil) {
        self.style = style
        self.rawStyle = rawStyle
        self.isOutlined = isOutlined
        self.size = size
        self.action = action
        self.label = label
        self.onHover = onHover
    }
    
    var listeners: [String : Listener] {
        var listeners: [String : Listener] = [
            "click": { _ in
                action()
            }
        ]
        if let onHover = onHover {
            listeners["mouseover"] = { _ in
                onHover(true)
            }
            listeners["mouseout"] = { _ in
                onHover(false)
            }
        }
        return listeners
    }
    
    public var body: some View {
        DynamicHTML("button", [
            "class":"btn btn\(isOutlined ? "-outline" : "")-\(style.rawValue)\(sizeStr)",
            "style":"box-shadow:none;\(rawStyle)"
        ], listeners: listeners) {
            label()
        }
    }
}

#endif
