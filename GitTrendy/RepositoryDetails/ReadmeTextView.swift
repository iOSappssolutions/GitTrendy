//
//  ReadmeTextView.swift
//  GitTrendy
//
//  Created by Miroslav Djukic on 20/09/2020.
//

import UIKit

class ReadmeTextView: UITextView {
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        setup()
    }
    
    private func setup() {
        self.isEditable = false
        self.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setReadme(text: String) {
        self.attributedText = text.html2AttributedString
        
        if(text != "") {
            self.backgroundColor = .white
        }
    }

}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
