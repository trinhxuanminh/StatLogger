//
//  MockService.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation

final class MockAPIService: APIServiceProtocol {
  func request<T: Codable>(from endPoint: EndPoint, body: Data? = nil) async throws -> T {
    if let body {
      print("✅ [MOCK] Sent to \(endPoint) with \(String(data: body, encoding: .utf8) ?? "")")
    }
    let mock = CollectResponse(status: 200, message: "Collected successfully")
    return mock as! T
  }
}
