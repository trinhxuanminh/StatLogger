//
//  CollectUseCase.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation

class CollectUseCase {
  private let collector = DataCollector(sources: [
    FreeSpaceSource(),
    BatterySource(),
  ], apiService: MockAPIService())
  
  func start() {
    collector.start()
  }
  
  func stop() {
    collector.stop()
  }
}
