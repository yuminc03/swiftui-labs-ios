//
//  CaptionedPhotoContentView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct CaptionedPhotoContentView: View {
    var body: some View {
        CaptionedPhoto(
            assertName: "Pink_Peony",
            captionText: "A cluster of bright pink peonies with yellow stamens."
        )
    }
}

struct CaptionedPhotoContentView_Previews: PreviewProvider {
    static var previews: some View {
        CaptionedPhotoContentView()
    }
}
