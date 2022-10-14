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
        guard let char = lesson?.chars[index] else {
            return
        }
        let jsStr = "draw('\(char)')"
        webView.evaluateJavaScript(jsStr) { _, _ in
        }
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    }
}
