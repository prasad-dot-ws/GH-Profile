//
//  GHProfileView.swift
//  GH Profile
//
//  Created by Prasad De Zoysa on 4/27/21.
//

import UIKit

class ProfileView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup views
    
    func setupViews() {
        
        self.addSubview(scrollView)
        
        //Adding UI elements to the view
        [profileImageView, nameLabel, loginLabel, emailLabel, followersCountLabel, followingCountLabel, pinnedHeaderLabel, pinnedViewAllLabel, pinnedStackView, topRepoHeaderLabel, topRepoViewAllLabel, topRepoScroller, starredRepoHeaderLabel, starredRepoViewAllLabel, starredRepoScroller].forEach { scrollView.addSubview($0) }
        
        [topRepoStackView].forEach { topRepoScroller.addSubview($0) }

        [starredRepoStackView].forEach { starredRepoScroller.addSubview($0) }
        
    }

    //MARK: Constraints
    
    /**
     * This function applies all the required constraints  to profile view
     */
    func setupConstraints() {
        
        scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)

        profileImageView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 15, bottom: 0, right: 0), size: .init(width: 70, height: 0))
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true

        nameLabel.anchor(top: nil, leading: profileImageView.trailingAnchor, bottom: profileImageView.centerYAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))

        loginLabel.anchor(top: profileImageView.centerYAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))

        emailLabel.anchor(top: profileImageView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 15, bottom: 0, right: 10))

        followersCountLabel.anchor(top: emailLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 15, bottom: 0, right: 0))

        followingCountLabel.anchor(top: followersCountLabel.topAnchor, leading: followersCountLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0))

        pinnedHeaderLabel.anchor(top: followersCountLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 15, bottom: 0, right: 0))

        pinnedViewAllLabel.anchor(top: nil, leading: nil, bottom: pinnedHeaderLabel.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))

        pinnedStackView.anchor(top: pinnedViewAllLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing:self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15))

        topRepoHeaderLabel.anchor(top: pinnedStackView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing:nil, padding: .init(top: 15, left: 15, bottom: 0, right: 0))

        topRepoViewAllLabel.anchor(top: topRepoHeaderLabel.topAnchor, leading: nil, bottom: nil, trailing:self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        
        topRepoScroller.anchor(top: topRepoViewAllLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: Constants.REPOSITORY_TILE_HEIGHT+(15+15)))//(15+15 is for top and bottom margins)
        
        topRepoStackView.anchor(top: topRepoScroller.topAnchor, leading: topRepoScroller.leadingAnchor, bottom:topRepoScroller.bottomAnchor, trailing:topRepoScroller.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15))
        
        starredRepoHeaderLabel.anchor(top: topRepoScroller.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing:nil, padding: .init(top: 0, left: 15, bottom: 15, right: 0))
        
        starredRepoViewAllLabel.anchor(top: starredRepoHeaderLabel.topAnchor, leading: nil, bottom: nil, trailing:self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        
        starredRepoScroller.anchor(top: starredRepoViewAllLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        starredRepoScroller.heightAnchor.constraint(equalTo: topRepoScroller.heightAnchor).isActive = true
        
        starredRepoStackView.anchor(top: starredRepoScroller.topAnchor, leading: starredRepoScroller.leadingAnchor, bottom:starredRepoScroller.bottomAnchor, trailing:starredRepoScroller.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15))
    }
    
    //MARK: UI Components
    
    let scrollView: UIScrollView = {
        
        var refreshControl = UIRefreshControl()
        
        let scroller = UIScrollView(frame: .zero)
        scroller.delaysContentTouches = false
        scroller.refreshControl = refreshControl
        return scroller
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "profile_placeholder")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont(name:Constants.FONT_BOLD, size: Constants.FONT_SIZE_HEADER)
        return label
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont(name:Constants.FONT_REGULAR, size: Constants.FONT_SIZE_REGULAR)
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name:Constants.FONT_SEMI_BOLD, size: Constants.FONT_SIZE_REGULAR)
        return label
    }()
    
    let followersCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name:Constants.FONT_REGULAR, size: Constants.FONT_SIZE_REGULAR)
        return label
    }()
    
    let followingCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name:Constants.FONT_REGULAR, size: Constants.FONT_SIZE_REGULAR)
        return label
    }()
    
    let pinnedHeaderLabel: UILabel = {
        let label = UILabel()
        label.addCharactersSpacing(spacing: 1, text: "Pinned")
        label.numberOfLines = 0
        label.font = UIFont(name:Constants.FONT_BOLD, size: Constants.FONT_SIZE_HEADER_1)
        return label
    }()
    
    let pinnedViewAllLabel: UIButton = {
        let button = UIButton(type: .system)
        button.underline(text: "View all")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name:Constants.FONT_SEMI_BOLD, size: Constants.FONT_SIZE_HEADER_2)
        return button
    }()
    
    let pinnedStackView: UIStackView = {
        let stack = UIStackView()
        stack.tag = Constants.PINNED_STACK_VIEW_TAG
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        
        return stack
    }()
    
    let topRepoHeaderLabel: UILabel = {
        let label = UILabel()
        label.addCharactersSpacing(spacing: 1, text: "Top repositories")
        label.numberOfLines = 0
        label.font = UIFont(name:Constants.FONT_BOLD, size: Constants.FONT_SIZE_HEADER_1)
        return label
    }()
    
    let topRepoViewAllLabel: UIButton = {
        let button = UIButton(type: .system)
        button.underline(text: "View all")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name:Constants.FONT_SEMI_BOLD, size: Constants.FONT_SIZE_HEADER_2)
        return button
    }()
    
    let topRepoScroller: UIScrollView = {
        let scroller = UIScrollView(frame: .zero)
        scroller.showsHorizontalScrollIndicator = false
        scroller.delaysContentTouches = false
        return scroller
    }()
    
    let topRepoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        
        return stack
    }()
    
    let starredRepoHeaderLabel: UILabel = {
        let label = UILabel()
        label.addCharactersSpacing(spacing: 1, text: "Starred repositories")
        label.numberOfLines = 0
        label.font = UIFont(name:Constants.FONT_BOLD, size: Constants.FONT_SIZE_HEADER_1)
        return label
    }()
    
    let starredRepoViewAllLabel: UIButton = {
        let button = UIButton(type: .system)
        button.underline(text: "View all")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name:Constants.FONT_SEMI_BOLD, size: Constants.FONT_SIZE_HEADER_2)
        return button
    }()
    
    let starredRepoScroller: UIScrollView = {
        let scroller = UIScrollView(frame: .zero)
        scroller.showsHorizontalScrollIndicator = false
        scroller.delaysContentTouches = false
        return scroller
    }()
    
    let starredRepoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        
        return stack
    }()
}
