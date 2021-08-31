//
//  ImageOrBI.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(TokamakDOM)
import TokamakDOM

/// Loads SF symbol for Apple SwiftUI builds and Bootstrap Icon for Tokamak builds
public struct ImageOrBI: View {
    
    public let bi: String
    
    public init(systemName: String, bi: String) {
        self.bi = bi
    }
    
    public var body: some View {
        BootstrapIcon(name: bi)
    }
}
#elseif canImport(SwiftUI)
import SwiftUI

/// Loads SF symbol for Apple SwiftUI builds and Bootstrap Icon for Tokamak builds
public struct ImageOrBI: View {
    
    public let systemName: String
    
    public init(systemName: String, bi: String) {
        self.systemName = systemName
    }
    
    public var body: some View {
        Image(systemName: systemName)
    }
}
#endif
