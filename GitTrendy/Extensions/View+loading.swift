//
//  View+loading.swift
//  GitTrendy
//
//  Created by Miroslav Djukic on 19/09/2020.
//

import Foundation
import SwiftUI

extension View {
    public func loading(isLoading: Binding<Bool>) -> some View {
        return LoadingView(isShowing: isLoading) {
            self
        }
    }
    
    public func imageLoading(isLoading: Binding<Bool>) -> some View {
        return ImageLoadingView(isShowing: isLoading) {
            self
        }
    }
}
