import SwiftUI

struct RootView: View {
  
  var body: some View {
    NavigationView {
      Form {
        Section("🫐 Getting started") {
          NavigationLink(destination: TextFontExampleView()) {
            Text("Text and Font")
          }
          NavigationLink(destination: SafeAreaRegionsExampleView()) {
            Text("SafeArea Regions")
          }
          NavigationLink(destination: TextFieldExampleView()) {
            Text("Input Name in TextField")
          }
          NavigationLink(destination: ListBootcampView()) {
            Text("List")
          }
        }
        
        Section("🍎 iOS Team Challenge") {
          NavigationLink(destination: RectanglePictureView()) {
            Text("Rectangle Picture")
          }
          NavigationLink(destination: ManagementProfileView()) {
            Text("Management Profile")
          }
          NavigationLink(destination: RoutinePopupExampleView()) {
            Text("Routine Popup")
          }
          NavigationLink(destination: SegmentedTodosView()) {
            Text("Todos")
          }
        }
        
        Section("🍒 UIViewRepresentable Prectise") {
          NavigationLink {
            VideoView()
          } label: {
            Text("Represented AVPlayer")
          }
        }
        
        Section("🍣 Custom Components") {
          NavigationLink {
            CustomWheelPicker()
          } label: {
            Text("Custom Wheel Picker")
          }
          
          NavigationLink {
            SwiftUIStackView()
          } label: {
            Text("SwiftUI StackView")
          }
          
          NavigationLink {
            UIKitStackView()
          } label: {
            Text("UIKit StackView")
          }
        }
      }
      .navigationTitle("SwiftUI Practise")
    }
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
