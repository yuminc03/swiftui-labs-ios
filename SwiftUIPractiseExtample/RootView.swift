//
//  RootView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/14.
//

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
                Section("🍑 TCA Tutorials") {
                    NavigationLink {
                        CounterFeatureView()
                    } label: {
                        Text("Counter")
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
                Section("🍊 TCA Challenge") {
                    NavigationLink {
                        KeyPadView()
                    } label: {
                        Text("KeyPad")
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
