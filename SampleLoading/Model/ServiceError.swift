//
//  ServiceError.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import Foundation

enum ServiceError: Error, LocalizedError {
    case unexpectedStatusCode(statusCode: Int)
    case errorSerializing
    case genericError
    
    var errorDescription: String? {
        switch self {
        case .unexpectedStatusCode(let statusCode):
            return String(format: "Unexpected status code: %i", statusCode)
            
        case .errorSerializing:
            return String(format: "Error serializing response")
            
        default:
            return String(format: "Generic error")
        }
    }
}
