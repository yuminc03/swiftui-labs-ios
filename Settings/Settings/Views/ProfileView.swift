//
//  ProfileView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

struct ProfileView: View {
    
    private let imageName: String
    private let nameText: String
    private let description: String
    
    init(
        imageName: String,
        nameText: String,
        description: String
    ) {
        self.imageName = imageName
        self.nameText = nameText
        self.description = description
    }
    
    var body: some View {
        HStack {
            profileImage
            VStack(alignment: .leading) {
                Text(nameText)
                    .font(.title2)
                Text(description)
                    .font(.footnote)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            imageName: "char_yumin",
            nameText: "Yumin Chu",
            description: "Apple ID, iCloud+, 미디어 및 구입 항목"
        )
        .previewLayout(.sizeThatFits)
    }
}

extension ProfileView {
    
    private var profileImage: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
}
