//
//  Lesson.swift
//  Runner
//
//  Created by wangwenjian on 2022/9/23.
//

import Foundation
 
class Lesson: Codable {
    let index: Int
    let chars: [String]
    
    init(_ index:Int, chars: [String]){
        self.index = index
        self.chars = chars
    }
}
