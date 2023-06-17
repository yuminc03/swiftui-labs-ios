//
//  SecondExample.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/01.
//

import SwiftUI

struct SecondExample: View {
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                TitleLabel(title: "관리")
                
                HStack(spacing: 20) {
                    profileImage
                    
                    PersonalInfoView(name: "추유민", age: 19, isMale: false)
                }
                
                HStack {
                    Spacer()
                    ManagementSelector(title: "받은진료", count: 0, imageName: "stethoscope")
                    Spacer()
                    ManagementSelector(title: "복약", count: 0, imageName: "pills")
                    Spacer()
                    ManagementSelector(title: "친사", count: 0, imageName: "face.smiling")
                    Spacer()
                }
            }
            .frame(width: .infinity, height: 330)
        }
    }
}

struct SecondExample_Previews: PreviewProvider {
    static var previews: some View {
        SecondExample()
            .previewLayout(.sizeThatFits)
    }
}

extension SecondExample {
    
    var profileImage: some View {
        Image("photo1")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundColor(.purple)
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .padding(.horizontal)
    }
}

struct TitleLabel: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
            Spacer()
        }
    }
}

struct ManagementSelector: View {
    
    let title: String
    let count: Int
    let imageName: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 35)
            
            HStack(alignment: .center, spacing: 2) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                
                Text("\(count)")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
            }
        }
        .padding(20)
        .frame(width: 120)
    }
}

struct PersonalInfoView: View {
    
    let name: String
    let age: Int
    let isMale: Bool
    
    var body: some View {
        
        VStack(spacing: 5) {
            HStack(spacing: 5) {
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                
                VStack(spacing: 0) {
                    Spacer()
                    Text("님")
                        .font(.body)
                }
                
                Spacer()
            }
            .frame(height: 40)
            
            HStack {
                Text("만 \(age)세 (\(isMale ? "남" : "여"))")
                    .font(.body)
                
                Spacer()
            }
        }
        .frame(width: .infinity, alignment: .leading)
    }
}
