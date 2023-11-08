import SwiftUI

struct ModalView: View {
  var body: some View {
    blueButton(title: "Back") {
      
    }
  }
}

#Preview {
  ModalView()
}

extension ModalView {
  
  func blueButton(title: String, action: @escaping () -> Void) -> some View {
    Button(title) {
      action()
    }
    .padding(20)
    .background(Color.blue)
    .foregroundColor(.white)
    .cornerRadius(10)
  }
}
