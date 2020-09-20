
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
