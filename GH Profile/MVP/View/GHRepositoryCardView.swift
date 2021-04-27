//
//  RepositoryCardView.swift
//  GH Profile
//
//  Created by Prasad De Zoysa on 4/27/21.
//

import UIKit

class GHRepositoryCardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        layer.borderWidth = 1.0
        layer.cornerRadius = 7
        layer.borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1).cgColor
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup views
    
    func setupViews() {
        
        [profileImageView, loginLabel, repoNameLabel, repoDescriptionLabel, starredLabel, primaryProgrammingLanguageLabel].forEach { self.addSubview($0) }

    }
    
    //MARK: Constraints

    func setupConstraints() {

        profileImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 15, bottom: 15, right: 0), size: .init(width: 20, height: 0))
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true

        loginLabel.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, bottom: profileImageView.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))

        repoNameLabel.anchor(top: profileImageView.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 5, left: 15, bottom: 0, right: 10))
        
        repoDescriptionLabel.anchor(top: repoNameLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 5, left: 15, bottom: 0, right: 10))
        
        starredLabel.anchor(top: repoDescriptionLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 15, bottom: 0, right: 0))
        
        primaryProgrammingLanguageLabel.anchor(top: starredLabel.topAnchor, leading: starredLabel.trailingAnchor, bottom: self.bottomAnchor, trailing:nil, padding: .init(top: 0, left: 20, bottom: 20, right: 0))
    }
    
    //MARK: UI Components
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.font = UIFont(name:Constants.FONT_REGULAR, size: Constants.FONT_SIZE_REGULAR)
        return label
    }()
    
    let repoNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.font = UIFont(name:Constants.FONT_SEMI_BOLD, size: Constants.FONT_SIZE_REGULAR)
        return label
    }()
    
    let repoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.font = UIFont(name:Constants.FONT_REGULAR, size: Constants.FONT_SIZE_REGULAR)
        return label
    }()
    
    let starredLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name:Constants.FONT_REGULAR, size: Constants.FONT_SIZE_REGULAR)
        label.text = " "
        
        return label
    }()
    
    let primaryProgrammingLanguageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name:Constants.FONT_REGULAR, size: Constants.FONT_SIZE_REGULAR)
        label.text = " "
        
        return label
    }()
}
