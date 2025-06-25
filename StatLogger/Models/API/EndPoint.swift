//
//  EndPoint.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation

enum EndPoint {
  case collector
  
  var domain: String {
    switch self {
    case .collector:
      return "https://jsonplaceholder.typicode.com"
    }
  }
  
  var path: String? {
    switch self {
    case .collector:
      return "/posts"
    }
  }
  
  var method: String {
    switch self {
    case .collector:
      return "POST"
    }
  }
  
  var params: [String: String?] {
    var params: [String: String?] = [:]
    switch self {
    default:
      break
    }
    return params
  }
  
  var headers: [String: String?] {
    var headers: [String: String?] = [:]
    switch self {
    default:
      headers["Content-Type"] = "application/json"
    }
    return headers
  }
}

extension EndPoint {
  func request(body: Data?) -> URLRequest? {
    guard
      let url = URL(string: domain),
      var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
    else {
      return nil
    }
    if let path {
      urlComponents.path = path
    }
    urlComponents.queryItems = params.map({
      return URLQueryItem(name: $0, value: $1)
    })
    
    guard let urlRequest = urlComponents.url else {
      return nil
    }
    var request = URLRequest(url: urlRequest)
    request.httpMethod = method
    
    headers.forEach {
      request.setValue($1, forHTTPHeaderField: $0)
    }
    
    if let body {
      request.httpBody = body
    }
    
    return request
  }
}
