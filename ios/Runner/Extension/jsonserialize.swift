//
//  jsonserialize.swift
//  ISawIt
//
//  Created by liujiang on 2020/10/13.
//  Copyright © 2020 xox. All rights reserved.
//

import Foundation
extension Dictionary {
    func jsonString() -> String {
        let optDic = self as [AnyHashable: Any?]
        var json: String = "{"
        for (key, v) in optDic {
            guard let value = v else {
                continue
            }
            json = json + "\"\(key)\":"
            if let value1 = value as? [AnyHashable:Any] {
                json = json + value1.jsonString()
            }else if let value1 = value as? [Any] {
                json = json + value1.jsonString()
            }else if let value1 = value as? Bool {
                json = json + (value1 ? "true" : "false")
            }else if !(value is String), self.isNumberString("\(value)") {
                json = json + "\(value)"
            }else {
                json = json + "\"\(value)\""
            }
            json = json + ","
        }
        
        json = String(json[json.startIndex..<json.index(before: json.endIndex)])
        json = json + "}"
        return json
    }
    
    
    private func isNumberString(_ obj: String) -> Bool {
        guard obj.count > 0 else {
            return false
        }
        let regex = "^[+-]{0,}\\d*[.]{0,}\\d+$"
        return (obj.range(of: regex, options: .regularExpression, range:Range(uncheckedBounds: (lower: obj.startIndex, upper: obj.endIndex)), locale: nil) != nil)
    }
        
    func jsonToData() -> Data? {
     
        if (!JSONSerialization.isValidJSONObject(self)) {
     
            print("is not a valid json object")
     
            return nil
     
        }
     
        //利用自带的json库转换成Data
     
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
     
        let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return data
     
    }
    
    func prettyPrint() {
        let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        if let jsonData = data {
            let jsonStr = String(data:jsonData, encoding: .utf8)
            guard let unwrapStr = jsonStr else {
                print("[Not support json object for print: \(self)]")
                return
            }
            var trimedStr = unwrapStr.replacingOccurrences(of: "\t", with: "")
            trimedStr = unwrapStr.replacingOccurrences(of: "\r", with: "")
            let arr = trimedStr.components(separatedBy: "\n")
            arr.forEach({
                print($0)
            })
            return
        }
        print("[Not support json object for print: \(self)]")
    }
}

extension Dictionary {
    func toModel<T>(_ type: T.Type) -> T? where T : Codable {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
            return nil
        }
        return try? JSONDecoder().decode(type, from: data)
    }
}

extension Array {
    func jsonString() -> String {
        let optArray = self as [Any?]
        var json: String = "["
        for (i, v) in optArray.enumerated() {
            guard let value = v else {
                json = json + "null"
                if i != self.count-1 {
                    json = json + ","
                }
                continue
            }
            if let value1 = value as? [AnyHashable:Any] {
                json = json + value1.jsonString()
            }else if let value1 = value as? [Any] {
                json = json + value1.jsonString()
            }else if let value1 = value as? Bool {
                json = json + (value1 ? "true" : "false")
            }else if !(value is String), self.isNumberString("\(value)") {
                json = json + "\(value)"
            }else {
                json = json + "\"\(value)\""
            }
            if i != self.count-1 {
                json = json + ","
            }
        }
        json = json + "]"
        return json
    }
    
    
    private func isNumberString(_ obj: String) -> Bool {
        guard obj.count > 0 else {
            return false
        }
        let regex = "^[+-]{0,}\\d*[.]{0,}\\d+$"
        return (obj.range(of: regex, options: .regularExpression, range:Range(uncheckedBounds: (lower: obj.startIndex, upper: obj.endIndex)), locale: nil) != nil)
    }
    
    func prettyPrint() {
        let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        if let jsonData = data {
            let jsonStr = String(data:jsonData, encoding: .utf8)
            guard let unwrapStr = jsonStr else {
                print("[Not support json object for print: \(self)]")
                return
            }
            var trimedStr = unwrapStr.replacingOccurrences(of: "\t", with: "")
            trimedStr = unwrapStr.replacingOccurrences(of: "\r", with: "")
            let arr = trimedStr.components(separatedBy: "\n")
            arr.forEach({
                print($0)
            })
            return
        }
        print("[Not support json object for print: \(self)]")
    }
}

extension String {
    
    func jsonObject() -> Any? {
        let json = try? JSONSerialization.jsonObject(with: self.data(using: .utf8) ?? Data(), options: .mutableContainers)
        return json
    }
    
    func toModel<T>(_ type: T.Type) -> T? where T : Codable {
        guard let dic = self.jsonObject() as? Dictionary<String, Any> else {
            return nil
        }
        return dic.toModel(type)
    }
}
