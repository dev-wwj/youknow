//
//  DrawFileManager+Trans.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/25.
//

import Foundation

extension DrawFileManager {

    func getImageAt(_ index: Int) -> UIImage? {
        guard let paths = self.queryPath(index) else {
            assertionFailure("not found file")
            return nil
        }
        let view = DrawedView(paths: paths)
        return view.snapshot()
    }
    
    func imageDataAt(_ index: Int) -> Data? {
        guard let name = queryKey(index: index) else {
            assertionFailure("not found file")
            return nil
        }
        if let img = imageInCache(name) {
            return img.jpegData(compressionQuality: 0.5)
        }
        
        if let img = getImageAt(index){
            save(image: img, name: name)
            return img.jpegData(compressionQuality: 0.5)
        }
        
        return nil
    }
    
    var cachesPath: String {
        get {
            return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!;
        }
    }
    
    func imageCachePath(_ name: String) -> String {
        return cachesPath.appending("/\(name).png")
    }
    
    func save(image: UIImage, name: String)  {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        let path = imageCachePath(name)
        try? NSData(data: data).write(toFile: path)
    }
    
    func imageInCache(_ name: String) -> UIImage? {
        let path = imageCachePath(name)
        if  FileManager.default.fileExists(atPath: path) {
            return UIImage(contentsOfFile: path)
        }
        return nil
    }
    
    func imagePathFor(_ index: Int) -> String? {
        guard let name = queryKey(index: index) else {
            assertionFailure("not found file")
            return nil
        }
        guard let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            assertionFailure("path error")
            return nil
        }
        let imagePath = cachesPath + "/" + name + ".png"
        if  FileManager.default.fileExists(atPath: imagePath) {
            return imagePath
        }
        guard let image = getImageAt(index),
            let iData = image.jpegData(compressionQuality: 0.5) else {
            return imagePath
        }
        let data = NSData(data: iData)
        try? data.write(toFile: imagePath)
        return imagePath
    }
    
}
