//
//  DrawFileManagerV2.swift
//  Runner
//
//  Created by wangwenjian on 2022/12/9.
//

import Foundation
import PencilKit

struct DrawedModel: Codable {
    let drawing: PKDrawing
    let size: CGSize
    let time: Date
}

struct CacheModel: Codable {
    
    static let keyPath = "Drawed"
    
    var draweds: [DrawedModel] = []
    
    var count: Int {
        return draweds.count
    }
    
    func drawedAt(index :Int) -> DrawedModel {
        return draweds[index]
    }
    
    func imageAt(index: Int) -> UIImage? {
        let drawed = drawedAt(index: index)
        let drawing = drawed.drawing
        return drawing.image(from: CGRectMake(0, 0, drawed.size.width, drawed.size.height), scale: 1.0)
    }
}

class DrawedCache {
    static let cache = DrawedCache()

    var model = CacheModel()
    
    init() {
        loadModel()
    }
    
    private let serializationQueue = DispatchQueue(label: "SerializationQueue", qos: .background)
}

extension DrawedCache {
    
    func loadModel() {
        let path = savePath
        serializationQueue.async {
            let fileManager = FileManager.default
            var isDir: UnsafeMutablePointer<ObjCBool>?
            if fileManager.fileExists(atPath: path, isDirectory: isDir) {
                do {
                    let names =  try fileManager.contentsOfDirectory(atPath: path)
                    for name in names {
                        let dPath = path.appending("/\(name)")
                        if fileManager.fileExists(atPath: dPath) {
                            let data = try Data(contentsOf: URL(fileURLWithPath: dPath))
                            let decoder = PropertyListDecoder()
                            let drawed = try! decoder.decode(DrawedModel.self, from: data)
                            self.model.draweds.append(drawed)
                        }
                    }
                } catch {
                }
            }
        }
    }

    private var savePath: String {
        let root = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = root.appending("/youknow.data")
        let fileManager = FileManager.default
        var isDir:UnsafeMutablePointer<ObjCBool>?
        let exised = fileManager.fileExists(atPath: path, isDirectory: isDir)
        if !exised {
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true)
            } catch {
            }
        }
        return path
    }
}

extension DrawedCache {
    func addDrawing(_ drawing: PKDrawing, size: CGSize) {
        let drawed = DrawedModel(drawing: drawing, size: size, time: Date())
        model.draweds.append(drawed)
        saveDrawed(drawed)
    }
    
    private func saveDrawed(_ drawed: DrawedModel) {
        let path = savePath
        serializationQueue.async {
            do {
                let encoder = PropertyListEncoder()
                let data = try encoder.encode(drawed)
                let name = "/drawed_\(drawed.time.timeIntervalSince1970)"
                if let dPath = path.appending(name) as? String {
                    try data.write(to: URL(fileURLWithPath: dPath))
                }
            } catch {
            }
        }
    }
}

