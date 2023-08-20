//
//  ContentView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink {
                        
                    } label: {
                        ProfileView(
                            imageName: "char_yumin",
                            nameText: "Yumin Chu",
                            description: "Apple ID, iCloud+, 미디어 및 구입 항목"
                        )
                    }
                } header: {
                    SearchView()
                        .padding(.bottom)
                }
                Section {
                    NavigationLink {
                        
                    } label: {
                        SettingsItemView(
                            imageName: "airpodspro",
                            squareColor: .gray,
                            title: "유민의 AirPads Pro 2"
                        )
                    }
                }
                Section {
                    Toggle(isOn: $isOn) {
                        SettingsItemView(
                            imageName: "airplane",
                            squareColor: .orange,
                            title: "에어플레인 모드"
                        )
                    }
                    NavigationLink {
                        
                    } label: {
                        SettingsItemView(
                            imageName: "wifi",
                            squareColor: .blue,
                            title: "Wi-Fi",
                            rightText: "LS_DEV"
                        )
                    }
                    NavigationLink {
                        
                    } label: {
                        SettingsItemView(
                            imageName: "bluetooth",
                            squareColor: .blue,
                            title: "Bluetooth",
                            rightText: "켬"
                        )
                    }
                    NavigationLink {
                        
                    } label: {
                        SettingsItemView(
                            imageName: "antenna.radiowaves.left.and.right",
                            squareColor: .green,
                            title: "셀룰러"
                        )
                    }
                    NavigationLink {
                        
                    } label: {
                        SettingsItemView(
                            imageName: "personalhotspot",
                            squareColor: .green,
                            title: "개인용 핫스팟",
                            rightText: "끔"
                        )
                    }
                    NavigationLink {
                        
                    } label: {
                        SettingsItemView(
                            imageName: "vpn",
                            squareColor: .blue,
                            title: "VPN",
                            rightText: "연결 안 됨"
                        )
                    }
                }
            }
            
            Section {
                NavigationLink {
                    
                } label: {
                    SettingsItemView(imageName: "bell.badge", squareColor: .red, title: "알림")
                }
                NavigationLink {
                    
                } label: {
                    SettingsItemView(imageName: "speaker.wave.3.fill", squareColor: .pink, title: "사운드 및 햅틱")
                }
                NavigationLink {
                    
                } label: {
                    SettingsItemView(imageName: "moon.fill", squareColor: .teal, title: "집중 모드")
                }
                NavigationLink {
                    
                } label: {
                    SettingsItemView(imageName: "hourglass", squareColor: .teal, title: "스크린 타임")
                }
            }
            
            .navigationTitle("설정")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
