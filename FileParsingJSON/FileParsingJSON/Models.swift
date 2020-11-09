//
//  Models.swift
//  FileParsingJSON
//
//  Created by Milos Petrusic on 04/11/2020.
//

import Foundation

struct Result: Codable {
    let data: [ResultItem]
}

struct ResultItem: Codable {
    let title: String
    let items: [String]
}
