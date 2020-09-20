
import GitTrendyModel
import SwiftUI
import MMMarkdown

struct TextView: UIViewRepresentable {

    @ObservedObject var githubRepositoryDetailsViewModel: GithubRepositoryDetailsViewModel
    
    let view = ReadmeTextView()
    
    func makeUIView(context: Context) -> UIView {
        print("make readme text view")
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let view = uiView as? ReadmeTextView else { return }

        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor).isActive = true

        guard githubRepositoryDetailsViewModel.readme != "",
              let htmlString = try? MMMarkdown.htmlString(withMarkdown: githubRepositoryDetailsViewModel.readme) else {
            return
        }
        
        view.setReadme(text: htmlString)
    }
}


