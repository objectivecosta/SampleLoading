//
//  Info.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import Foundation

//"info": {
//    "count": 671,
//    "pages": 34,
//    "next": "https://rickandmortyapi.com/api/character/?page=20",
//    "prev": "https://rickandmortyapi.com/api/character/?page=18"
//  },

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
