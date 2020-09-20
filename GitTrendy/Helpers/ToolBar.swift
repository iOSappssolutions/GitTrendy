

import Foundation
import SwiftUI

struct ToolBar: View {
    @ObservedObject var keyboardHandler: KeyboardFollower
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button("Done") {
                        UIResponder.currentFirstResponder?.resignFirstResponder()
                    }
                    .padding(.trailing)
                }
                .frame(height: 40)
                .padding(.bottom, self.keyboardHandler.toolBarPosition - geometry.safeAreaInsets.bottom)
            }
            .opacity(self.keyboardHandler.isVisible ? 1 : 0)
        }
    }
}
