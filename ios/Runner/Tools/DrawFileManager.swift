//
//  DrawPathsCache.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/24.
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

class DrawFileManager {
    static let manager = DrawFileManager()
  
    private init(){
        self.loadFileKeys()
    }
    
    fileprivate var fileKeys: [String] = []
    
    private func loadFileKeys(){
        if let data =  UserDefaults.standard.object(forKey: "UserDrawFileKeys") as? Data {
            if let keys = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
                self.fileKeys += keys
            }
        }
    }
    
    class func saveFiles(){
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: manager.fileKeys, requiringSecureCoding: false) {
            UserDefaults.standard.set(saveData, forKey: "UserDrawFileKeys")
        }
    }
}

extension DrawFileManager: CacheProtocal {

  
    func addDPath(_ path: [DPath]) {
        let time = Date().timeIntervalSince1970
        let cachePath = "\(time)_UserDraw"
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: path, requiringSecureCoding: false) {
            UserDefaults.standard.set(saveData, forKey: cachePath)
            fileKeys.append(cachePath)
            DrawFileManager.saveFiles()
        }
    }
    
    func queryKey(index: Int) -> String? {
        return fileKeys[index]
    }
    
    func queryDpath(key: String) -> [DPath]? {
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            if let dpath = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [DPath] {
                return dpath
            }
        }
        return nil
    }
    
    func deleteDPath(key: String){
        UserDefaults.standard.removeObject(forKey: key)
        fileKeys = fileKeys.filter { str in
            return key != str
        }
    }
    
    func queryCount() -> Int {
        return fileKeys.count
    }
    
    func queryPath(_ index: Int) -> [DPath]? {
        return queryDpath(key:fileKeys[index])
    }
    
}


