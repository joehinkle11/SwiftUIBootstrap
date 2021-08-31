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
    let size: BootstrapButtonSize?
    let action: () -> Void
    let label: () -> Label
    
    var sizeStr: String {
        if let size = size {
            return " btn-\(size.rawValue)"
        }
        return ""
    }
    
    public init(_ style: BootstrapButtonStyle = .primary, isOutlined: Bool = false, size: BootstrapButtonSize? = nil, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.style = style
        self.isOutlined = isOutlined
        self.size = size
        self.action = action
        self.label = label
    }
    
    public var body: some View {
        DynamicHTML("button", ["class":"btn btn\(isOutlined ? "-outline" : "")-\(style.rawValue)\(sizeStr)"], listeners: ["click": { _ in
            action()
        }]) {
            label()
        }
    }
}

#endif
