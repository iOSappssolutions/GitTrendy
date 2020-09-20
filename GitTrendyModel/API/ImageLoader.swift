//
//  ImageLoader.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 19/09/2020.
//

import Foundation
import SwiftUI
import Combine

public class ImageLoader: ObservableObject {
    
    @Published public var downloadedImage: UIImage?
    @Published public var isLoading: Bool = false
    public let didChange = PassthroughSubject<ImageLoader?, Never>()
    
    public init() {
        
    }
    
    public func load(url: String) {
        
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        isLoading = true
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
            }
            guard let data = data, error == nil else {
                DispatchQueue.main.async { [weak self] in
                     self?.didChange.send(nil)
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.downloadedImage = UIImage(data: data)
                self?.didChange.send(self)
            }
            
        }.resume()
    
    }
    
    
}
