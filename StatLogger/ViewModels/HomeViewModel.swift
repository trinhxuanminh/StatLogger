//
//  HomeViewModel.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation
import Combine

class HomeViewModel: BaseViewModel {
  enum Action {
    case run
    case stop
  }
  
  let action = PassthroughSubject<Action, Never>()
  private let useCase = CollectUseCase()
  
  override init() {
    super.init()
    // Subscriptions
    action.sink(receiveValue: { [weak self] action in
      guard let self else {
        return
      }
      processAction(action)
    }).store(in: &subscriptions)
  }
}

extension HomeViewModel {
  private func processAction(_ action: Action) {
    switch action {
    case .run:
      useCase.start()
    case .stop:
      useCase.stop()
    }
  }
}
