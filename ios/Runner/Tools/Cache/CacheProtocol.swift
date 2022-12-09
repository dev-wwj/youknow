//
//  CacheProtocol.swift
//  Runner
//
//  Created by wangwenjian on 2022/12/9.
//

import Foundation

protocol CacheProtocal {
    
    func addDPath(_ path: [DPath])
    
    func deleteDPath(key: String)
    
    func queryKey(index: Int) -> String?
    
    func queryDpath(key: String) -> [DPath]?
    
    func queryCount() -> Int
    
    func queryPath(_ index: Int) -> [DPath]?
}
