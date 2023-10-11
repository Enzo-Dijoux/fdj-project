//
//  BaseParser.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class BaseParser: NSObject {
    func parse(withResponse data: NSData, headers: [AnyHashable: Any]) -> Any? {
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
            return jsonObject as AnyObject?
        } catch {
            print("🛑 error serializing JSON: \(error) 🛑")
        }

        return nil
    }
}
