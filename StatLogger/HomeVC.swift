//
//  ViewController.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 24/6/25.
//

import UIKit

class ViewController: UIViewController {
  
  let runButton = UIButton(type: .system)
  let stopButton = UIButton(type: .system)
  
  var buffer: [String] = []
  let bufferQueue = DispatchQueue(label: "com.example.bufferQueue")
  
  var diskTimer: Timer?
  var batteryTimer: Timer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupUI()
  }
  
  func setupUI() {
    runButton.setTitle("Run", for: .normal)
    stopButton.setTitle("Stop", for: .normal)
    
    let stack = UIStackView(arrangedSubviews: [runButton, stopButton])
    stack.axis = .horizontal
    stack.spacing = 20
    stack.distribution = .fillEqually
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(stack)
    NSLayoutConstraint.activate([
      stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stack.widthAnchor.constraint(equalToConstant: 200),
      stack.heightAnchor.constraint(equalToConstant: 50)
    ])
    
    runButton.addTarget(self, action: #selector(startTasks), for: .touchUpInside)
    stopButton.addTarget(self, action: #selector(stopTasks), for: .touchUpInside)
  }
  
  @objc func startTasks() {
    UIDevice.current.isBatteryMonitoringEnabled = true
    
    diskTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      let disk = self.getFreeDiskSpace()
      self.appendToBuffer("Disk: \(disk)")
    }
    
    batteryTimer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      let battery = self.getBatteryLevel()
      self.appendToBuffer("Battery: \(battery)")
    }
  }
  
  @objc func stopTasks() {
    diskTimer?.invalidate()
    batteryTimer?.invalidate()
    diskTimer = nil
    batteryTimer = nil
  }
  
  func appendToBuffer(_ value: String) {
    bufferQueue.async { [weak self] in
      guard let self = self else { return }
      self.buffer.append(value)
      print("📥 Appended: \(value)")
      
      if self.buffer.count >= 5 {
        let dataToSend = self.buffer
        self.buffer.removeAll()
        DispatchQueue.global().async {
          self.sendToServer(data: dataToSend)
        }
      }
    }
  }
  
  func sendToServer(data: [String]) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let body: [String: Any] = ["data": data]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { _, _, _ in
      print("📤 Sent to server: \(data)")
    }
    task.resume()
  }
  
  func getFreeDiskSpace() -> String {
    if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
       let free = attrs[.systemFreeSize] as? NSNumber {
      let gb = Double(truncating: free) / 1_073_741_824
      return String(format: "%.2f GB", gb)
    }
    return "Unknown"
  }
  
  func getBatteryLevel() -> String {
    let level = UIDevice.current.batteryLevel
    if level < 0 { return "Unknown" }
    return String(format: "%.0f%%", level * 100)
  }
}
