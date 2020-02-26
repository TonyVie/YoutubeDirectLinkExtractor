//
//  YoutubeDirectLinkExtractorTests.swift
//  Andrey Sevrikov
//
//  Created by Andrey Sevrikov on 04/03/2018.
//  Copyright © 2018 Andrey Sevrikov. All rights reserved.
//

import Foundation
import XCTest
@testable import YoutubeDirectLinkExtractor

class YoutubeDirectLinkExtractorTests: XCTestCase {
    
    let stubAllQualities = String(contentsOfBundleFile: "ResponseAllQualities", type: "txt")!
    let stubUpToMediumQualities = String(contentsOfBundleFile: "ResponseUpToMediumQualities", type: "txt")!
    
    func testExtractsInfoForAllQualities() {
        // when
        let result = YoutubeDirectLinkExtractor().extractInfo(from: stubAllQualities)
        
        // then
        XCTAssertEqual(result.0.count, 2)
    }

    func testExtractsInfoForUpToMediumQualities() {
        // when
        let result = YoutubeDirectLinkExtractor().extractInfo(from: stubUpToMediumQualities)

        // then
        XCTAssertEqual(result.0.count, 1)
    }
    
    // MARK: - Real-world testing
    
    let testRealApi = false
    
    func testRealExtractInfo() {
        guard testRealApi else { return }
        
        // given
        let videoId = "Jvph0r09nDU"
        let expectation = XCTestExpectation(description: "Get callback fired")

        // then
        YoutubeDirectLinkExtractor().extractInfo(for: .id(videoId), success: { info in
            expectation.fulfill()
        }) { error in
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }
    
    func testRealExtractRawInfo() {
        guard testRealApi else { return }
        
        // given
        let videoId = "hMloyp6NI4E"
        let expectation = XCTestExpectation(description: "Get callback fired")

        // then
        YoutubeDirectLinkExtractor().extractRawInfo(for: .id(videoId)) { info, error in
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }
    
    func testRealExtractInfoSuccess() {
        guard testRealApi else { return }
        
        // given
        let videoId = "kOZ3YsdfdSg"
        let expectation = XCTestExpectation(description: "Get callback fired")
        
        // then
        YoutubeDirectLinkExtractor().extractInfo(for: .id(videoId), success: { info in
            expectation.fulfill()
        }) { error in
            XCTFail("Error: \(error)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
