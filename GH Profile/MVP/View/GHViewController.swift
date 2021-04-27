//
//  ViewController.swift
//  GH Profile
//
//  Created by Prasad De Zoysa on 4/27/21.
//

import UIKit

class GHViewController: UIViewController {

    var presenter: GHProfilePresenter! = nil
    
    var mainView: ProfileView { return self.view as! ProfileView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.FONT_BOLD, size: 19)!, NSAttributedString.Key.kern: 1]
        self.mainView.scrollView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        loadProfileData()
        
    }
    
    @objc func refresh(_ sender: UIRefreshControl){
        loadProfileData(sender: sender, forceReload: true)
    }
    
    func loadProfileData(sender: UIRefreshControl? = nil, forceReload: Bool = false) {
        presenter.fetchGitHubUserProfile(login: Constants.DEMO_GITHUB_USER_LOGIN, forceReload: forceReload) { (res) in
            
            DispatchQueue.main.async {
                switch res {
                case .success(let user):
                    self.mainView.nameLabel.text = user.name
                    self.mainView.loginLabel.text = user.login
                    self.mainView.emailLabel.text = user.email
                    self.mainView.followersCountLabel.setFollowText(count: user.followers.totalCount, text: "followers")
                    self.mainView.followingCountLabel.setFollowText(count: user.following.totalCount, text: "following")
                    
                    if let url = URL(string: user.avatarUrl) {
                        self.mainView.profileImageView.load(url: url, placeholder: UIImage(named: "profile_placeholder"))
                    }
                    
                    self.setPinnedRepos(repos: user.pinnedItems)
                    self.setTopTenRepos(repos: user.repositories)
                    self.setStarredTenRepos(repos: user.starredRepositories)
                    
                    if sender != nil {
                        sender!.endRefreshing()
                    }
                    
                    
                case.failure(_):
                    DispatchQueue.main.async {
                        if sender != nil {
                            sender!.endRefreshing()
                        }
                    }
                }
            }
        }
    }
    
    func setPinnedRepos(repos: GHRepositories) {
        
        for view in mainView.pinnedStackView.arrangedSubviews {
            mainView.pinnedStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for repo in repos.nodes {
            let view = GHRepositoryCardView()
            
            if let url = URL(string: repo.owner.avatarUrl) {
                view.profileImageView.load(url: url, placeholder: UIImage(named: "profile_placeholder"))
            }
            
            view.loginLabel.text = repo.owner.login
            view.repoNameLabel.text = repo.name
            view.repoDescriptionLabel.text = repo.description
            if let language = repo.languages.nodes.first{
                view.primaryProgrammingLanguageLabel.setLanguageAndColorCircle(language: language.name, color:language.color)
            }
            view.starredLabel.setStarredCount(count: repo.stargazerCount)
            mainView.pinnedStackView.addArrangedSubview(view)
        }
    }
    
    func setTopTenRepos(repos: GHRepositories) {
        
        for view in mainView.topRepoStackView.arrangedSubviews {
            mainView.topRepoStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for repo in repos.nodes {
            let view = GHRepositoryCardView()
            
            if let url = URL(string: repo.owner.avatarUrl) {
                view.profileImageView.load(url: url, placeholder: UIImage(named: "profile_placeholder"))
            }
            
            view.loginLabel.text = repo.owner.login
            view.repoNameLabel.text = repo.name
            view.repoDescriptionLabel.text = repo.description
            if let language = repo.languages.nodes.first{
                view.primaryProgrammingLanguageLabel.setLanguageAndColorCircle(language: language.name, color:language.color)
            }
            view.starredLabel.setStarredCount(count: repo.stargazerCount)
            view.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: UIScreen.main.bounds.size.width / 2, height: Constants.REPOSITORY_TILE_HEIGHT))
            mainView.topRepoStackView.addArrangedSubview(view)
        }
    }
    
    func setStarredTenRepos(repos: GHRepositories) {
        
        for view in mainView.starredRepoStackView.arrangedSubviews {
            mainView.starredRepoStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for repo in repos.nodes {
            let view = GHRepositoryCardView()
            
            if let url = URL(string: repo.owner.avatarUrl) {
                view.profileImageView.load(url: url, placeholder: UIImage(named: "profile_placeholder"))
            }
            
            view.loginLabel.text = repo.owner.login
            view.repoNameLabel.text = repo.name
            view.repoDescriptionLabel.text = repo.description
            if let language = repo.languages.nodes.first{
                view.primaryProgrammingLanguageLabel.setLanguageAndColorCircle(language: language.name, color:language.color)
            }
            view.starredLabel.setStarredCount(count: repo.stargazerCount)
            view.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: UIScreen.main.bounds.size.width / 2, height: Constants.REPOSITORY_TILE_HEIGHT))
            mainView.starredRepoStackView.addArrangedSubview(view)
        }
    }
    
    override func loadView() {
        presenter = GHProfilePresenter()
        self.view = ProfileView(frame: UIScreen.main.bounds)
    }
}

