//
//  APIServiceProtocol.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation

protocol APIServiceProtocol {
  func request<T: Codable>(from endPoint: EndPoint, body: Data?) async throws -> T
}
