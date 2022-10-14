//
//  JSTools.swift
//  Runner
//
//  Created by wangwenjian on 2022/9/20.
//

import Foundation
import JavaScriptCore

fileprivate let tool = JSTools()

class JSTools {
    
    fileprivate init() {
        loadJs()
    }
    
    private var ctx: JSContext!
    private func loadJs(){
        let vm = JSVirtualMachine()
        let ctx = JSContext(virtualMachine: vm)
        let path = Bundle.main.path(forResource: "cnchar.all.min", ofType: "js")!
        do {
            let script = try? String(contentsOfFile: path, encoding: .utf8)
            ctx?.evaluateScript(script)
        }
        self.ctx  = ctx
    }
    
    //        JSTools.evaluateJavaScript("'拼音'.spell()")
    //        JSTools.evaluateJavaScript("cnchar.spellInfo('shàng')")
    static func evaluateJavaScript(_ javaScriptString: String) -> JSValue {
        let value = tool.ctx.evaluateScript(javaScriptString)!
        return value
    }

    
}
