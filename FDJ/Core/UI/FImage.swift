//
//  FImage.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import SwiftUI
import Kingfisher

//TODO: This View should contains more parameters such as contentMode, fadeDuration, placeholder, ...
//TODO: It should handle all types of Images (from assets, animated images, ...), but the View was simplified for the FDJ project
struct FImage: View {
    let url: URL?
    
    var body: some View {
        KFImage(url)
            .cacheOriginalImage()
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
