//
//  DataCollector.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation

final class DataCollector {
  private let sources: [DataSource]
  private let apiService: APIServiceProtocol
  private let storage = DataStorage()
  private var timers: [DispatchSourceTimer] = []
  private var isRunning = false
  
  init(sources: [DataSource], apiService: APIServiceProtocol) {
    self.sources = sources
    self.apiService = apiService
  }
  
  func start() {
    guard !isRunning else {
      return
    }
    isRunning = true
    
    print("Start collect!")
    for source in sources {
      let queue = DispatchQueue(label: "collector.\(source.name)")
      let timer = DispatchSource.makeTimerSource(queue: queue)
      timer.schedule(deadline: .now() + source.interval,
                     repeating: source.interval,
                     leeway: .milliseconds(100))
      
      timer.setEventHandler { [weak self] in
        guard
          let self = self,
          self.isRunning
        else {
          return
        }
        let info = source.collect()
        Task {
          await self.handle(info)
        }
      }
      
      timers.append(timer)
      timer.resume()
    }
  }
  
  func stop() {
    guard isRunning else {
      return
    }
    print("Stop collect!")
    timers.forEach { $0.cancel() }
    timers.removeAll()
    isRunning = false
  }
}

extension DataCollector {
  private func handle(_ info: DeviceInfo) async {
    let shouldSend = await storage.append(info)
    print("Collected: \(info)")
    if shouldSend {
      let batch = await storage.fetchAndClear()
      await sendToServer(batch)
    }
  }
  
  private func sendToServer(_ data: [DeviceInfo]) async {
    do {
      let body = try JSONEncoder().encode(data)
      let response: CollectResponse = try await apiService.request(from: .collector, body: body)
      print("✅ Send result: \(response)")
    } catch {
      switch error as? APIError {
      case .invalidRequest:
        print("❌ Send error - Invalid request: \(error)")
      default:
        print("❌ Send error - Unknown: \(error)")
      }
    }
  }
}
