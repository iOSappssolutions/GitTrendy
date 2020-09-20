//
//  URLImage.swift
//  GitTrendy
//
//  Created by Miroslav Djukic on 19/09/2020.
//

import Foundation
import GitTrendyModel
import SwiftUI

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    @State private var imageLoaded = false
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        self.imageLoader.load(url: url)
    }
    
    @State var image:UIImage = UIImage()
    @State private var opacity = 0.2
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }.onReceive(imageLoader.didChange) { data in
            self.image = data?.downloadedImage ?? UIImage()
            withAnimation(.easeInOut(duration: 0.5
            )) {
                self.opacity = 1.0
            }
        }
        .opacity(opacity)
        .imageLoading(isLoading: self.$imageLoader.isLoading)
    }
    
}
