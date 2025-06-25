//
//  HomeVC.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 24/6/25.
//

import UIKit

class HomeVC: BaseViewController {
  private lazy var runButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Run", for: .normal)
    button.layer.cornerRadius = 8
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var stopButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Stop", for: .normal)
    button.layer.cornerRadius = 8
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 20
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let viewModel = HomeViewModel()
  
  override func addComponents() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(runButton)
    stackView.addArrangedSubview(stopButton)
  }
  
  override func setConstraints() {
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.widthAnchor.constraint(equalToConstant: 200),
      stackView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  override func setProperties() {
    runButton.addTarget(self, action: #selector(onTapRun), for: .touchUpInside)
    stopButton.addTarget(self, action: #selector(onTapStop), for: .touchUpInside)
  }
  
  override func setColor() {
    view.backgroundColor = .white
    
    runButton.setTitleColor(.white, for: .normal)
    runButton.backgroundColor = .systemGreen
    
    stopButton.setTitleColor(.white, for: .normal)
    stopButton.backgroundColor = .systemRed
  }
}

extension HomeVC {
  @objc func onTapRun() {
    viewModel.action.send(.run)
  }
  
  @objc func onTapStop() {
    viewModel.action.send(.stop)
  }
}
