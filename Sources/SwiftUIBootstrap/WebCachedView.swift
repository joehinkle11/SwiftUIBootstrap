//
//  WebCachedView.swift
//  
//
//  Created by Joseph Hinkle on 10/13/21.
//

//#if canImport(TokamakDOM)
//import Foundation
//import TokamakDOM
//import JavaScriptKit
//
//var delayedQueue: [() -> ()] = []
//let glTimer: JSTimer = JSTimer(millisecondsDelay: 20, isRepeating: true) {
//    if let first = delayedQueue.first {
//        first()
//        delayedQueue = Array(delayedQueue.dropFirst())
//    }
//}
//
//public struct DelayedWebLoad: View {
//    let calcView: () -> AnyView
//    private let timer: JSTimer
//
//    public init<T: View>(_ view: @autoclosure @escaping () -> T) {
//        self.calcView = {.init(view())}
//        self.timer = glTimer
//    }
//
//    @State private var renderedView: AnyView? = nil
//
//    public var body: some View {
//        if let renderedView = renderedView {
//            renderedView
//        } else {
//            Text("asdf").foregroundColor(.white).onAppear {
//                print("start")
//                
//                delayedQueue.append {
//                    print("render")
//                    renderedView = calcView()
//                }
//            }
//        }
//    }
//}
//#else
//import SwiftUI
//public func DelayedWebLoad<T: View>(_ view: T) -> T {
//    view
//}
//#endif
