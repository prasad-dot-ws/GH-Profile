//
//  Constants.swift
//  GH Profile
//
//  Created by Prasad De Zoysa on 4/27/21.
//

import CoreGraphics

struct Constants {
    
    //MARK: Backend
    static let GITHUB_GRAPH_API_KEY: String = "<replace your API key>"
    static let GRAPH_QL_ENDPOINT: String = "https://api.github.com/graphql"
    static let DEMO_GITHUB_USER_LOGIN: String = "fabpot"//taylorotwell
    
    //MARK: Caching
    static let CACHE_TIME_TO_LIVE_DAYS:Int = 1
    static let CACHE_EXPIRY_DATE_KEY: String = "expiryDate"
    
    //MARK: Fonts Settings
    static let FONT_REGULAR: String = "SourceSansPro-Regular"
    static let FONT_SEMI_BOLD: String = "SourceSansPro-SemiBold"
    static let FONT_BOLD: String = "SourceSansPro-Bold"
    
    static let FONT_SIZE_HEADER: CGFloat = 25.0
    static let FONT_SIZE_HEADER_1: CGFloat = 20.0
    static let FONT_SIZE_HEADER_2: CGFloat = 15.0
    static let FONT_SIZE_REGULAR: CGFloat = 14.0
    
    //MARK: UI Constants
    static let REPOSITORY_TILE_HEIGHT: CGFloat = 130.0
    static let PINNED_STACK_VIEW_TAG: Int = 1001
    
}
