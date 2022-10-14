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
               let lesson = param.toModel(Lesson.self) {
                vc.lesson = lesson
            }
            if let index = argv?[2] as? Int {
                vc.index = index
            }
            navi?.pushViewController(vc, animated: true)
        }
    }
}
