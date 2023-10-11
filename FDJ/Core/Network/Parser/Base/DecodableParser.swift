//
//  DecodableParser.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class DecodableParser<T: Decodable>: BaseParser {

    override func parse(withResponse data: NSData, headers: [AnyHashable : Any]) -> Any? {
        do {
            return try JSONDecoder().decode(T.self, from: data as Data)
        } catch {
            print(error)
            return nil
        }
    }
}
