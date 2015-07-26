//
//  TranslatorTests.swift
//  MapProgress
//
//  Created by James Robinson on 25/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation
import XCTest

class TranslatorTests: XCTestCase {
    let translator = Translator()
    
    func testTranslate1() {
        let wsg84 = LatLon(latitude: 52.657977, longitude: 1.716038)
        let result = translator.latLonToOsGrid(wsg84)
        let expected = OSGrid(easting: 651409, northing: 313177)
        XCTAssertEqualWithAccuracy(result.northing, expected.northing, 0.5, "Test 1 Northing")
        XCTAssertEqualWithAccuracy(result.easting, expected.easting, 0.5, "Test 1 Easting")
    }
    
}