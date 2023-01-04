//
//  BaseServerModel+Extension.swift
//  BaseVIPER
//
//  Created on 12/5/22.
//
import Foundation
import MCVIPER

extension BaseServerModel {
    func encode() -> [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        else { return nil }
        
        return json
    }
}

extension Array where Element: BaseServerModel {
    func encode() -> [[String: Any]]? {
        guard let jsonData = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
        else { return nil }
        
        return json
    }
}
