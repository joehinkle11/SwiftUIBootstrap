//
//  Setup.swift
//  
//
//  Created by Joseph Hinkle on 8/30/21.
//

#if canImport(JavaScriptKit)
import JavaScriptKit

public func setupBootstrap() {
    let document = JSObject.global.document
    //let script = document.createElement("script")
    //script.setAttribute("src", "https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js")
    //document.head.appendChild(script)

    _ = document.head.insertAdjacentHTML("beforeend", #"""
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    """#)
}
#endif
