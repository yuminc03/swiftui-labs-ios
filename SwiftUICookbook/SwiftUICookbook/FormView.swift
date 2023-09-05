//
//  FormView.swift
//  SwiftUICookbook
//
//  Created by LS-NOTE-00106 on 2023/09/05.
//

import SwiftUI

struct FormView: View {
  @State private var username = ""
  @State private var email = ""
  @State private var password = ""
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Username", text: $username)
          TextField("Email", text: $email)
        } header: {
          Text("Personal Information")
        }
        
        Section {
          SecureField("Password", text: $password)
        } header: {
          Text("Login Credentials")
        }

        Section {
          Button(action: register) {
            Text("Register")
          }
        }
      }
      .navigationTitle("Regstier Form")
    }
  }
  
  private func register() {
    
  }
}

struct FormView_Previews: PreviewProvider {
  static var previews: some View {
    FormView()
  }
}
