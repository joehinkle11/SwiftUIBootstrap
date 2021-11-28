//
//  LazyFixCellSizedList.swift
//  
//
//  Created by Joseph Hinkle on 11/28/21.
//


public enum LazyFixCellSizedListHeight {
    case byScreenWidth(vw: Int, minusPixels: Int) // height: calc(Xvm - Ypx)   or height: calc(`vm`vm - `minusPixels`px)
    
    var str: String {
        switch self {
        case .byScreenWidth(let vw, let minusPixels):
            return "calc(\(vw)vw - \(minusPixels)px)"
        }
    }
    
    var pixels: Double {
        switch self {
        case .byScreenWidth(let vw, let minusPixels):
            return window.innerWidth.number! * (Double(vw) / 100.0) - Double(minusPixels)
        }
    }
}

#if canImport(TokamakDOM)
import Foundation
import TokamakDOM
import JavaScriptKit


fileprivate let window = JSObject.global.window

public protocol ListElementWithIndex {
    var posInArr: Int { get }
}

public struct LazyFixCellSizedList<Data: RandomAccessCollection, TopView: View, RowContent: View>: View where Data.Element : Identifiable & ListElementWithIndex {
    
    private let data: Data
    private let fixedHeight: LazyFixCellSizedListHeight
    private let scrollViewHeight: String
    private let rowContent: (Data.Element) -> RowContent
    private let topView: TopView
    @State private var group: ShouldShowElementGroup = ShouldShowElementGroup()

    
    public init(_ data: Data, fixedHeight: LazyFixCellSizedListHeight, scrollViewHeight: String = "100%", topView: TopView, rowContent: @escaping (Data.Element) -> RowContent) {
        self.data = data
        self.fixedHeight = fixedHeight
        self.scrollViewHeight = scrollViewHeight
        self.topView = topView
        self.rowContent = rowContent
    }
    
    public init(_ data: Data, fixedHeight: LazyFixCellSizedListHeight, scrollViewHeight: String = "100%", rowContent: @escaping (Data.Element) -> RowContent) where TopView == EmptyView {
        self.data = data
        self.fixedHeight = fixedHeight
        self.scrollViewHeight = scrollViewHeight
        self.topView = EmptyView()
        self.rowContent = rowContent
    }
    
    private var showsIndicators: Bool {
        false
    }
    
    var listeners: [String : Listener] {
        var listeners: [String : Listener] = [:]
        listeners["scroll"] = { _ in
            group.onScroll(height: fixedHeight)
        }
        return listeners
    }
    
    public var body: some View {
        DynamicHTML("div", [
            "style": "overflow-y:auto;height:\(scrollViewHeight);width:100%;",
            "class": !showsIndicators ? "_tokamak-scrollview _tokamak-scrollview-hideindicators" :
                "_tokamak-scrollview",
            "id": group.parentId
        ], listeners: listeners) {
            HTML("div", [
                "id": group.id
            ]) {
                topView
//                let theData = data.dropLast(data.count - 10)
                ForEach(data) { (dataEl: Data.Element) in
                    LazyFixCellSizedListElementView(
                        dataEl: dataEl,
                        fixedHeight: fixedHeight,
                        shouldShowElementGroup: group,
                        rowContent: rowContent
                    )
                }
            }
        }.onAppear {
            group.onScroll(height: fixedHeight)
        }
    }
}

fileprivate var groupCount = 0
fileprivate final class ShouldShowElementGroup {
    final fileprivate let id: String
    fileprivate var parentId: String {
        id + "p"
    }
    //                                  [posInForEach : element]
    final fileprivate var allShouldShowElements: [Int : ShouldShowElement] = [:]
    
    fileprivate init() {
        self.id = "lazylistgroup\(groupCount)"
        groupCount += 1
    }
    
//    final private var element: JSValue? = nil
//    final private func getElement() -> JSValue {
//        if let element = self.element {
//            print("reuse element")
//            return element
//        } else {
//            print("first get element")
//            let element = window.customQuerySelector.function!("#\(id)")
//            print("got element")
//            print(element)
//            self.element = element
//            return element
//        }
//    }
    final private var lastTop: Double = -1000
    final fileprivate func onScroll(height cellHeight: LazyFixCellSizedListHeight) {
        let position = window.getBoundingClientRectForQuerySelector.function!("#\(id)")
        if let top: Double = position.top.number {
            if abs(self.lastTop - top) < 50 {
                return
            }
            self.lastTop = top
            let parentPosition = window.getBoundingClientRectForQuerySelector.function!("#\(parentId)")
            if let parentTop: Double = parentPosition.top.number,
               let parentHeight: Double = parentPosition.bottom.number {
                let cellPixels = cellHeight.pixels
                let pixelsOverTop = parentTop - top
                let pixelsOverTopPlusDist = pixelsOverTop + parentHeight
//                print("cellPixels")
//                print(cellPixels)
//                print("pixelsOverTop")
//                print(pixelsOverTop)
//                print("pixelsOverTopPlusDist")
//                print(pixelsOverTopPlusDist)
                
                let startingIndex: Int = Int(pixelsOverTop / cellPixels) - 1
                let endingIndex: Int = Int(pixelsOverTopPlusDist / cellPixels) + 1
//                print("startingIndex")
//                print(startingIndex)
//                print("endingIndex")
//                print(endingIndex)
                for i in startingIndex...endingIndex {
                    if let el = allShouldShowElements[i], !el.shouldRender {
                        el.shouldRender = true
                    }
                }
            }
        }
    }
}

fileprivate final class ShouldShowElement: ObservableObject {
    final fileprivate var hashValue: Int
    @Published final fileprivate var shouldRender = false
    private func reset() {
        self.shouldRender = false
    }
    private init(hashValue: Int) { self.hashValue = hashValue }
    fileprivate static func find<T: Hashable>(id: T, pos: Int, in group: ShouldShowElementGroup) -> ShouldShowElement {
        let hashValueOfId = id.hashValue
        if let foundEl = group.allShouldShowElements[pos] {
            if foundEl.hashValue != hashValueOfId {
                // this element has been replaced, reset it's should show state
                foundEl.reset()
            }
            return foundEl
        } else {
            let new = ShouldShowElement(hashValue: hashValueOfId)
            group.allShouldShowElements[pos] = new
            return new
        }
    }
}


fileprivate struct LazyFixCellSizedListElementView<DataElement: Identifiable & ListElementWithIndex, RowContent: View>: View {
    
    private let dataEl: DataElement
    private let fixedHeight: LazyFixCellSizedListHeight
    private let rowContent: (DataElement) -> RowContent
    
    @ObservedObject private var shouldShowElement: ShouldShowElement
    
    fileprivate init(dataEl: DataElement, fixedHeight: LazyFixCellSizedListHeight, shouldShowElementGroup: ShouldShowElementGroup, rowContent: @escaping (DataElement) -> RowContent) {
        self.dataEl = dataEl
        self.fixedHeight = fixedHeight
        self.rowContent = rowContent
        self._shouldShowElement = .init(wrappedValue: .find(id: dataEl.id, pos: dataEl.posInArr, in: shouldShowElementGroup))
    }
    
    fileprivate var body: some View {
        if shouldShowElement.shouldRender {
//            Text("YES index \(dataEl.posInArr)").rawStyle("height:\(fixedHeight.str)")
            rowContent(dataEl).rawStyle("height:\(fixedHeight.str)")
        } else {
//            Text("NOO index \(dataEl.posInArr)").rawStyle("height:\(fixedHeight.str)")
            Text("").rawStyle("height:\(fixedHeight.str)")
        }
    }
}

#else
import SwiftUI
public func LazyFixCellSizedList<Data, RowContent>(
    _ data: Data,
    fixedHeight: LazyFixCellSizedListHeight,
    rowContent: @escaping (Data.Element) -> RowContent
) -> some View where Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable {
    return SwiftUI.List(
        data,
        rowContent
    )
}
#endif
