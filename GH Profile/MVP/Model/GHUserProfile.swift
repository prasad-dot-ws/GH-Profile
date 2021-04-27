//
//  UserProfile.swift
//  GH Profile
//
//  Created by Prasad De Zoysa on 4/27/21.
//

import Foundation

struct GitHubResponseData: Decodable {
    let data: GHData
}

struct GHData: Decodable {
    let user: GHUser
}

struct GHUser: Decodable {
    let id: String
    let avatarUrl: String
    let login: String
    let name: String
    let email: String?
    let followers: GHFollow
    let following: GHFollow
    let pinnedItems: GHRepositories
    let repositories: GHRepositories
    let starredRepositories: GHRepositories
}

struct GHFollow: Decodable {
    let totalCount: Int
}

struct GHRepositories: Decodable {
    let nodes: [GHRepository]
}

struct GHRepository: Decodable {
    let name: String
    let description: String?
    let stargazerCount: Int
    let languages: GHProgrammingLanguages
    let owner: GHRepoOwner
}

struct GHRepoOwner: Decodable {
    let avatarUrl: String
    let login: String
}

struct GHProgrammingLanguages: Decodable {
    let nodes: [GHProgrammingLanguage]
}

struct GHProgrammingLanguage: Decodable {
    let id: String
    let name: String
    let color: String
}
