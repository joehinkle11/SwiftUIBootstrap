//
//  BootstrapIcon.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakShim)
import TokamakShim

public struct BootstrapIcon: View {
    
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public var body: some View {
        HTML("i", ["class": "bi-\(name)"])
    }
}
#endif
