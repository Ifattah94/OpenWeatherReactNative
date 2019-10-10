//
//  topAnimePracticeTests.swift
//  topAnimePracticeTests
//
//  Created by C4Q on 10/8/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import XCTest
@testable import topAnimePractice

class topAnimePracticeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAnimeModelFromJson() {
        
        guard let path = Bundle.main.path(forResource: "Anime", ofType: "json") else {
                 print("could not find path to json file")
                    return  }
            
             let url = URL(fileURLWithPath: path)
            
            do {
            let data = try Data(contentsOf: url)
                let animeArr = try AnimeResultsWrapper.getAnimeFromData(data: data)
                XCTAssert(animeArr.count > 0, "The count of the arr is \(animeArr.count)")
            
            }
            catch {
                print(error)
            }
        
        }
    
    
}


        



