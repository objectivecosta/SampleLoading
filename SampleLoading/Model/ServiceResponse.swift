//
//  ServiceResponse.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import Foundation

struct ServiceResponse<T : Codable> : Codable {
    let results: T
    let info: Info
}
