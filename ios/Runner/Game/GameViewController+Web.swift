//
//  GameViewController+Web.swift
//  Runner
//
//  Created by wangwenjian on 2022/9/8.
//

import Foundation
import JavaScriptCore
import WebKit

extension GameViewController: WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
    func setupCnChar() {
        let path = Bundle.main.path(forResource: "chchar", ofType: "html")
        let url = URL(fileURLWithPath: path!)
        let dir = URL(string: "file://")!
        webView.loadFileURL(url, allowingReadAccessTo: dir)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let jsStr = "cnchar.voice.speak(text: '一', options?: ISpeakOptions): SpeechSynthesisUtterance;"
        webView.evaluateJavaScript(jsStr) { _, _ in
        
        }
        
//        webView.evaluateJavaScript("'汉字拼音'.spell()") { _, _ in
//            
//        }
       
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    }
}
