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
        if path == "GameViewController" {
            let vc = GameViewController()
            if let param = argv?[1] as? String,
               let myChars = param.toModel(MyChars.self) {
                vc.myChars = myChars
            }
            navi?.pushViewController(vc, animated: true)
        }
    }
}

