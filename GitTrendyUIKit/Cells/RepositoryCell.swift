//
//  RepositoryCell.swift
//  GitTrendyUIKit
//
//  Created by Miroslav Djukic on 20/09/2020.
//

import UIKit
import GitTrendyModel

class RepositoryCell: UITableViewCell {
    
    private var repository: GitHubRepository?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        backgroundColor = UIColor(named: "primaryColor")
    }
    
    private let repositoryName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)

        return label
    }()
    
    private let starsCount: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private let repositoryDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private let starImageView: UIImageView = {
        let image: UIImage = UIImage(systemName: "star", withConfiguration: .none)!
                            .withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor(named: "starColor")
        
        return imageView
    }()
    
    private func addSubviews() {
        addSubview(repositoryName)
        addSubview(starImageView)
        addSubview(starsCount)
        addSubview(repositoryDescription)
    }
    
    func setCell(repository: GitHubRepository) {
        self.repositoryName.text = repository.name
        self.starsCount.text = String(repository.starsCount)
        self.repositoryDescription.text = repository.description
    }
    
    private func addConstraints() {
        repositoryName.translatesAutoresizingMaskIntoConstraints = false
        starsCount.translatesAutoresizingMaskIntoConstraints = false
        repositoryDescription.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLeading = repositoryName.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let nameTop = repositoryName.topAnchor
            .constraint(equalTo: topAnchor, constant: 16)
        
        let nameTrailing = repositoryName.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -16)
        
        let starsImageLeading = starImageView.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let starsImageTop = starImageView.topAnchor
            .constraint(equalTo: repositoryName.bottomAnchor, constant: 16)
        
        let starsImageWitdh = starImageView.widthAnchor
            .constraint(equalToConstant: 20)
        
        let starsImageHeight = starImageView.heightAnchor
            .constraint(equalToConstant: 20)
        
        let starsCountLeading = starsCount.leadingAnchor
            .constraint(equalTo: starImageView.trailingAnchor, constant: 16)
        
        let starsCountTrailing = starsCount.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -16)
        
        let starsCountCenterY = starsCount.centerYAnchor
            .constraint(equalTo: starImageView.centerYAnchor)
        
        let descriptionLeading = repositoryDescription.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let descriptionTop = repositoryDescription.topAnchor
            .constraint(equalTo: starImageView.bottomAnchor, constant: 16)
        
        let descriptionTrailing = repositoryDescription.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -16)
        
        let descriptionBottom = repositoryDescription.bottomAnchor
            .constraint(equalTo: bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([nameLeading,
                                     nameTop,
                                     nameTrailing,
                                     starsImageLeading,
                                     starsImageTop,
                                     starsImageWitdh,
                                     starsImageHeight,
                                     starsCountLeading,
                                     starsCountTrailing,
                                     starsCountCenterY,
                                     descriptionLeading,
                                     descriptionTop,
                                     descriptionTrailing,
                                     descriptionBottom])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
