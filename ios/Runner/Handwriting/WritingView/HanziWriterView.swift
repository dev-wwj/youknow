//
//  HanziWriterView.swift
//  Runner
//
//  Created by wangwenjian on 2022/12/2.
//

import Foundation
import WebKit

class HanziWriterView: UIControl {
    
    var char: String? {
        didSet {
            guard char != nil else {
                return
            }
            webView.reload()
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCnChar()
        tapAction(.touchUpInside) {[weak self] _ in
            self?.webView.reload()
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = self.viewController()?.view.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  lazy var webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = false
        webView.navigationDelegate = self
        webView.backgroundColor = .clear
        webView.isUserInteractionEnabled = false
        webView.isOpaque = false
        webView.uiDelegate = self
        self.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return webView
    }()
    
}

extension HanziWriterView: WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
    func setupCnChar() {
        let path = Bundle.main.path(forResource: "chchar", ofType: "html")
        let url = URL(fileURLWithPath: path!)
        let dir = URL(string: "file://")!
        webView.loadFileURL(url, allowingReadAccessTo: dir)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        _drawAnimate()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    }
    
    @objc func reloadWeb(){
        webView.reload()
    }
    
    private func _drawAnimate() {
        guard let char = char else {
            return
        }
        let jsStr = "draw('\(char)')"
        webView.evaluateJavaScript(jsStr) { _, _ in
        }
    }
}
