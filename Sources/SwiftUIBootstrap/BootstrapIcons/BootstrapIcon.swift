//
//  BootstrapIcon.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakDOM)
import TokamakDOM

public struct BootstrapIcon: View {
    
    public let name: String
    public var style: String = ""
    
    public init(name: String, style: String = "") {
        self.name = name
        self.style = style
    }
    
//    public var body: some View {
//        HTML("i", ["class": "bi-\(name)","style":style])
//    }
    public var body: some View {
        HTML("img", ["src": "../contents/bootstrap-icons/\(name).svg","style":style])
    }
    
}
#endif
