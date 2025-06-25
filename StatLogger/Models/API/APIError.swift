//
//  APIError.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation

enum APIError: Error {
  case invalidRequest
  case invalidResponse
  case jsonEncodingError
  case jsonDecodingError
  case notInternet
  case anyError
}
