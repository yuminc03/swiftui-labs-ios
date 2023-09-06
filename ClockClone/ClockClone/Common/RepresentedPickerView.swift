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
    for i in 0 ..< selectedItemIndeces.count {
      uiView.selectRow(selectedItemIndeces[i], inComponent: i, animated: true)
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(items: items, selectedItemIndeces: $selectedItemIndeces)
  }
}

class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
  let items: [[String]]
  var selectedItemIndeces: Binding<[Int]>
  
  init(items: [[String]], selectedItemIndeces: Binding<[Int]>) {
    self.items = items
    self.selectedItemIndeces = selectedItemIndeces
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return items.count
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return items[component].count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return items[component][row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedItemIndeces.wrappedValue[component] = row
  }
}
