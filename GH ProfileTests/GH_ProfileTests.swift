//
//  GH_ProfileTests.swift
//  GH ProfileTests
//
//  Created by Prasad De Zoysa on 4/27/21.
//

import XCTest
@testable import GH_Profile

class GH_ProfileTests: XCTestCase {
    
    /**
     * This function tests number abbrivation logic
     */
    func testNumberAbbrivation() throws {
        
        let number = Double(25156.0)
        let abbrivatedNumber = number.abbreviateNumber()
        
        XCTAssertEqual(abbrivatedNumber, "25.2k")
        
    }
    
    /**
     * This function tests the follow string construction with text abbrivation
     */
    func testFollowText() throws {
        
        let followers = 25156
        let testLabel = UILabel()
        testLabel.setFollowText(count: followers, text: "followers")
        
        XCTAssertEqual(testLabel.text, "25.2k followers")
        
    }
    
    /**
     * This function tests HEX color to RGB conversion
     */
    func testHexToRGBConvertor() throws {
        
        let hexColor = "#ffffff"
        let testLabel = UILabel()
        let color = testLabel.hexStringToUIColor(hex: hexColor)
        
        XCTAssertEqual(color, .init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1))
    }

}
