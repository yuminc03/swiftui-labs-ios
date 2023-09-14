//
//  RepresentedPickerView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/06.
//

import SwiftUI

struct RepresentedPickerView: UIViewRepresentable {
  var items: [[String]]
  @Binding var selectedItemIndeces: [Int]
  
  func makeUIView(context: Context) -> UIPickerView {
    let pickerView = UIPickerView()
    pickerView.delegate = context.coordinator
    pickerView.dataSource = context.coordinator
    return pickerView
  }
  
  func updateUIView(_ uiView: UIPickerView, context: Context) {
    // updateUIView() State가 바뀔 때 update함
    for i in 0 ..< selectedItemIndeces.count {
      uiView.selectRow(selectedItemIndeces[i], inComponent: i, animated: true)
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }
}

class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
  var parent: RepresentedPickerView // SwiftUI에서 사용할 view를 받아야 함
  
  init(parent: RepresentedPickerView) {
    self.parent = parent
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return parent.items.count
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return parent.items[component].count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return parent.items[component][row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    parent.selectedItemIndeces[component] = row
  }
}
