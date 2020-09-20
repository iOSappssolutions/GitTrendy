////
////  StyledText.swift
////  GitTrendy
////
////  Created by Miroslav Djukic on 19/09/2020.
////
//
//import SwiftUI
//import MMMarkdown
//
//public struct StyledText {
//    // This is a value type. Don't be tempted to use NSMutableAttributedString here unless
//    // you also implement copy-on-write.
//    private var attributedString: NSAttributedString
//
//    private init(attributedString: NSAttributedString) {
//        self.attributedString = attributedString
//    }
//
//    public func style<S>(_ style: TextStyle,
//                         ranges: (String) -> S) -> StyledText
//        where S: Sequence, S.Element == Range<String.Index>
//    {
//
//        // Remember this is a value type. If you want to avoid this copy,
//        // then you need to implement copy-on-write.
//        let newAttributedString = NSMutableAttributedString(attributedString: attributedString)
//
//        for range in ranges(attributedString.string) {
//            let nsRange = NSRange(range, in: attributedString.string)
//            newAttributedString.addAttribute(style.key, value: style, range: nsRange)
//        }
//
//        return StyledText(attributedString: newAttributedString)
//    }
//}
//
//public extension StyledText {
//    // A convenience extension to apply to a single range.
//    func style(_ style: TextStyle,
//               range: (String) -> Range<String.Index> = { $0.startIndex..<$0.endIndex }) -> StyledText {
//        self.style(style, ranges: { [range($0)] })
//    }
//}
//
//extension StyledText {
//    public init(verbatim content: String, styles: [TextStyle] = []) {
//        let attributes = styles.reduce(into: [:]) { result, style in
//            result[style.key] = style
//        }
//        attributedString = NSMutableAttributedString(string: content, attributes: attributes)
//    }
//}
//
//extension StyledText: View {
//    public var body: some View { text() }
//
//    public func text() -> Text {
//        var text: Text = Text(verbatim: "")
//        attributedString
//            .enumerateAttributes(in: NSRange(location: 0, length: attributedString.length),
//                                 options: [])
//            { (attributes, range, _) in
//                let string = attributedString.attributedSubstring(from: range).string
//                let modifiers = attributes.values.map { $0 as! TextStyle }
//                text = text + modifiers.reduce(Text(verbatim: string)) { segment, style in
//                    style.apply(segment)
//                }
//        }
//        return text
//    }
//}
//
//public struct TextStyle {
//    // This type is opaque because it exposes NSAttributedString details and
//    // requires unique keys. It can be extended by public static methods.
//
//    // Properties are internal to be accessed by StyledText
//    internal let key: NSAttributedString.Key
//    internal let apply: (Text) -> Text
//
//    private init(key: NSAttributedString.Key, apply: @escaping (Text) -> Text) {
//        self.key = key
//        self.apply = apply
//    }
//}
//
//// Public methods for building styles
//public extension TextStyle {
//    static func foregroundColor(_ color: Color) -> TextStyle {
//        TextStyle(key: .init("TextStyleForegroundColor"), apply: { $0.foregroundColor(color) })
//    }
//
//    static func underline() -> TextStyle {
//        TextStyle(key: .init("TextStyleUnderline"), apply: { $0.underline() })
//    }
//
//    static func italic() -> TextStyle {
//        TextStyle(key: .init("TextStyleItalic"), apply: { $0.italic() })
//    }
//
//    static func bold() -> TextStyle {
//        TextStyle(key: .init("TextStyleBold"), apply: { $0.bold() })
//    }
//}

import GitTrendyModel
import SwiftUI
import MMMarkdown

struct TextView: UIViewRepresentable {

    typealias TheUIView = UITextView
    @ObservedObject var githubRepositoryDetailsViewModel: GithubRepositoryDetailsViewModel
    
    let view = TheUIView()
    func makeUIView(context: Context) -> UIView {
        view.isEditable = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let view = uiView as? UITextView else { return }
        view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor).isActive = true
        guard githubRepositoryDetailsViewModel.readme != "",
              let htmlString = try? MMMarkdown.htmlString(withMarkdown: githubRepositoryDetailsViewModel.readme),
              let data = htmlString.data(using: String.Encoding.utf8) else {
            return
        }
        do {
            view.attributedText = try NSAttributedString(data: data,
                                                 options: [.documentType: NSAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
            if(htmlString != "") {
                view.backgroundColor = .white
            }
        } catch {
            return
        }
        return 
    }
}
