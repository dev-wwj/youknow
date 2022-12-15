//
//  FlutterChannel+route.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/13.
//

import Foundation

extension FlutterPlugin {
    
    func nativeRoute(_ argv: [Any]?) {
        guard let path = argv?.first as? String else {
            return
        }
        if path == "pop" {
            navi?.popViewController(animated: true)
        }
        if path == "HandwritingVC" {
            let vc = HandwritingVC()
            if let param = argv?[1] as? String,
               let myChars = param.toModel(MyChars.self) {
                vc.myChars = myChars
            }
            navi?.pushViewController(vc, animated: true)
        }
    }
}

