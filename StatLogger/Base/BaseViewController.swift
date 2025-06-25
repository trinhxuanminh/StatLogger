//
//  BaseViewController.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import UIKit
import Combine

class BaseViewController: UIViewController, ViewProtocol {
  var subscriptions = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    addComponents()
    setConstraints()
    setProperties()
    binding()
    DispatchQueue.main.async { [weak self] in
      guard let self else {
        return
      }
      setColor()
    }
  }
  
  deinit {
    removeSubs()
  }
  
  func addComponents() {}
  
  func setConstraints() {}
  
  func setProperties() {}
  
  func setColor() {}
  
  func binding() {}
  
  func removeSubs() {
    subscriptions.forEach { $0.cancel() }
    subscriptions.removeAll()
  }
}
