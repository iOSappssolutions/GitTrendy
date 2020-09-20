//
//  TxScrollView.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit
import GitTrendyModel
import Kingfisher
import MMMarkdown

class RepositoryContentView: UIView {

    private var repository: GitHubRepository
    
    lazy private var ownerPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 75
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        if let avatarUrl = repository.user.avatarUrl, let url = URL(string: avatarUrl) {
            imageView.kf.setImage(with: url)
        }
        return imageView
    }()
    
    private let ownerName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "orange")
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    lazy private var starsCountContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "secondaryTextColor")?.cgColor
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = .clear
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.addArrangedSubview(star)
        stackView.addArrangedSubview(starsCount)
        view.addSubview(stackView)
     
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive =  true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive =  true
        
        return view
    }()
    
    lazy private var forkCountContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "secondaryTextColor")?.cgColor
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = .clear
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.addArrangedSubview(fork)
        stackView.addArrangedSubview(forkCount)
        view.addSubview(stackView)
     
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive =  true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive =  true
        
        
        return view
    }()
    
    lazy private var starsCount: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "secondaryTextColor")
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.text = String(repository.starsCount) + " Stars"
        
        return label
    }()
    
    private let star: UIImageView = {
        let image = UIImage(systemName: "star.fill", withConfiguration: .none)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor(named: "secondaryTextColor")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    lazy private var forkStarContainerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.addArrangedSubview(starsCountContainer)
        stack.addArrangedSubview(forkCountContainer)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.widthAnchor
            .constraint(equalToConstant: 300).isActive = true
        stack.heightAnchor
            .constraint(equalToConstant: 50).isActive = true
        
        return stack
    }()
    
    private let fork: UIImageView = {
        let image: UIImage = #imageLiteral(resourceName: "fork.png").withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor(named: "secondaryTextColor")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    lazy private var forkCount: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "secondaryTextColor")
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.text = String(repository.forksCount) + " Forks"
        
        return label
    }()
    
    private let repsoitoryDescription: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private let horizontalDash: UIView = {
        let dash = UIView()
        dash.backgroundColor = UIColor(named: "searchBarColor")
        dash.translatesAutoresizingMaskIntoConstraints = false
        dash.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dash.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        return dash
    }()
    
    private let readmeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Readme.md"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    private let readme: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        
        return textView
    }()
    
    func setReadme(text: String) {
        guard text != "",
              let htmlString = try? MMMarkdown.htmlString(withMarkdown: text),
              let data = htmlString.data(using: String.Encoding.utf8) else {
            return
        }
        do {
            readme.attributedText = try NSAttributedString(data: data,
                                                 options: [.documentType: NSAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
            if(htmlString != "") {
                readme.backgroundColor = .white
            }
        } catch {
            return
        }
    }
    
    init(repository: GitHubRepository) {
        self.repository = repository
        super.init(frame: .zero)
        
        self.ownerName.text = repository.name
        self.repsoitoryDescription.text = repository.description
        self.backgroundColor = UIColor(named: "primaryColor")
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(ownerPhoto)
        addSubview(ownerName)
        addSubview(horizontalDash)
        addSubview(repsoitoryDescription)
        addSubview(forkStarContainerView)
        addSubview(readmeTitle)
        addSubview(readme)
    }
    
    private func addConstraints() {
        ownerName.translatesAutoresizingMaskIntoConstraints = false
        repsoitoryDescription.translatesAutoresizingMaskIntoConstraints = false
        readme.translatesAutoresizingMaskIntoConstraints = false
        
        let ownerPhotoCenterX = ownerPhoto.centerXAnchor
            .constraint(equalTo: centerXAnchor)
        
        let ownerPhotoTop = ownerPhoto.topAnchor
            .constraint(equalTo: topAnchor, constant: 16)
        
        let ownerNameLeading = ownerName.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let ownerNameTop = ownerName.topAnchor
            .constraint(equalTo: ownerPhoto.bottomAnchor, constant: 16)
        
        let ownerNameTrailing = ownerName.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -16)
        
        let dashTop = horizontalDash.topAnchor
            .constraint(equalTo: ownerName.bottomAnchor, constant: 16)
        
        let dashCenterX = horizontalDash.centerXAnchor
            .constraint(equalTo: centerXAnchor)
        
        let repositoryDescriptionLeading = repsoitoryDescription.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let repositoryDescriptionTrailing = repsoitoryDescription.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -16)
        
        let repositoryDescriptionTop = repsoitoryDescription.topAnchor
            .constraint(equalTo: horizontalDash.bottomAnchor, constant: 16)
        
        let starForkContainerCenterX = forkStarContainerView.centerXAnchor
            .constraint(equalTo: centerXAnchor)
        
        let starForkContainerTop = forkStarContainerView.topAnchor
            .constraint(equalTo: repsoitoryDescription.bottomAnchor, constant: 16)
        
        let readmeTitleLeading = readmeTitle.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let readmeTitleTrailing = readmeTitle.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -16)
        
        let rreadmeTitleTop = readmeTitle.topAnchor
            .constraint(equalTo: forkStarContainerView.bottomAnchor, constant: 16)
        
        let readmeTop = readme.topAnchor
            .constraint(equalTo: readmeTitle.bottomAnchor, constant: 16)
        
        let readmeLeading = readme.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let readmeTrailing = readme.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -16)
        
        let readmeBottom = readme.bottomAnchor
            .constraint(equalTo: bottomAnchor)
        
        NSLayoutConstraint.activate([ownerPhotoCenterX,
                                     ownerPhotoTop,
                                     ownerNameLeading,
                                     ownerNameTop,
                                     ownerNameTrailing,
                                     dashTop,
                                     dashCenterX,
                                     repositoryDescriptionLeading,
                                     repositoryDescriptionTrailing,
                                     repositoryDescriptionTop,
                                     starForkContainerCenterX,
                                     starForkContainerTop,
                                     readmeTitleLeading,
                                     readmeTitleTrailing,
                                     rreadmeTitleTop,
                                     readmeTop,
                                     readmeLeading,
                                     readmeTrailing,
                                     readmeBottom
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
