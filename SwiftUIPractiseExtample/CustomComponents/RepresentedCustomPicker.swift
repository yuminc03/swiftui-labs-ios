import SwiftUI

struct RepresentedCustomPicker: UIViewRepresentable {
  let data: [[String]]
  @Binding var selectedItem: [String]
  
  func makeUIView(context: Context) -> UIPickerView {
    let v = UIPickerView()
    v.delegate = context.coordinator
    v.dataSource = context.coordinator
    
    (0 ..< selectedItem.count).forEach {
      v.selectRow(data[$0].count / 2, inComponent: $0, animated: true)
    }
    return v
  }
  
  func updateUIView(_ uiView: UIPickerView, context: Context) {
    uiView.subviews.forEach {
      $0.backgroundColor = .clear
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    private let parent: RepresentedCustomPicker
    
    init(parent: RepresentedCustomPicker) {
      self.parent = parent
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return parent.data.count
    }
    
    func pickerView(
      _ pickerView: UIPickerView,
      numberOfRowsInComponent component: Int
    ) -> Int {
      return parent.data[component].count
    }
    
    func pickerView(
      _ pickerView: UIPickerView,
      rowHeightForComponent component: Int
    ) -> CGFloat {
      return 45
    }
    
    func pickerView(
      _ pickerView: UIPickerView,
      titleForRow row: Int,
      forComponent component: Int
    ) -> String? {
      return parent.data[component][row]
    }
    
    func pickerView(
      _ pickerView: UIPickerView,
      didSelectRow row: Int,
      inComponent component: Int
    ) {
      print("selectedData: \(parent.data[component][row])")
      parent.selectedItem[component] = parent.data[component][row]
    }
  }
}
