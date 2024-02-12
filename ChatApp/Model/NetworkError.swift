//
//  NetworkResponse.swift
//  ChatApp
//
//  Created by Admin on 11/02/24.
//

import SwiftUI

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
