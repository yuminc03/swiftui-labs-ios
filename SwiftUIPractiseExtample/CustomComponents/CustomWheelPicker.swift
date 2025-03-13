import SwiftUI

struct CustomWheelPicker: View {
  let data: [[String]] = [
    Array(0 ... 300).map { "\($0)" },
    Array(0 ... 300).map { "\($0)" },
    Array(0 ... 300).map { "\($0)" },
  ]
  
  @State private var selectedItems = ["0", "0", "0"]
  
  var body: some View {
    VStack {
      PickerView
    }
  }
}

private extension CustomWheelPicker {
  var PickerView: some View {
    RepresentedCustomPicker(
      data: data,
      selectedItem: $selectedItems
    )
  }
}

#Preview {
  CustomWheelPicker()
}
