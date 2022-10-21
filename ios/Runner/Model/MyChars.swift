//
//  MyChars.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/19.
//

import Foundation

class MyChars: Codable {
    
    var index: Int
    var section: Int
    
    let groupSize: Int
    let chars: [String]
    
    
    var char: String {
        get {
            return chars[index]
        }
    }
    
}
