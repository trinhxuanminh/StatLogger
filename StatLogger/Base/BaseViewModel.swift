//
//  BaseViewModel.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation
import Combine

class BaseViewModel {
  var subscriptions = Set<AnyCancellable>()
  
  deinit {
    removeSubs()
  }
  
  func removeSubs() {
    subscriptions.forEach { $0.cancel() }
    subscriptions.removeAll()
  }
}
