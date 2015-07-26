//
//  TranslatorTests.swift
//  MapProgress
//
//  Created by James Robinson on 25/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation
import XCTest

class WGS84Tests: XCTestCase {
    
    func testToOSGrid1() {
        let wgs84 = WGS84(latitude: 52.657977, longitude: 1.716038)
        let result = wgs84.toOSGrid();
        let expected = OSGrid(easting: 651409, northing: 313177)
        XCTAssertEqualWithAccuracy(result.northing, expected.northing, 0.5, "Test 1 Northing")
        XCTAssertEqualWithAccuracy(result.easting, expected.easting, 0.5, "Test 1 Easting")
    }
    
    func testToOSGrid2() {
        let wgs84 = WGS84(latitude: 55.796414, longitude: -3.399691)
        let result = wgs84.toOSGrid();
        let expected = OSGrid(easting: 312345, northing: 656789)
        XCTAssertEqualWithAccuracy(result.northing, expected.northing, 0.5, "Test 1 Northing")
        XCTAssertEqualWithAccuracy(result.easting, expected.easting, 0.5, "Test 1 Easting")
    }
    
    func testToOSGrid3() {
        let wgs84 = WGS84(latitude: 57.888741, longitude: -7.06386)
        let result = wgs84.toOSGrid();
        let expected = OSGrid(easting: 100012, northing: 900056)
        XCTAssertEqualWithAccuracy(result.northing, expected.northing, 0.5, "Test 1 Northing")
        XCTAssertEqualWithAccuracy(result.easting, expected.easting, 0.5, "Test 1 Easting")
    }
    
    func testToOSGrid4() {
        let wgs84 = WGS84(latitude: 49.835883, longitude: 2.133466)
        let result = wgs84.toOSGrid();
        let expected = OSGrid(easting: 697302, northing: 1043)
        XCTAssertEqualWithAccuracy(result.northing, expected.northing, 0.5, "Test 1 Northing")
        XCTAssertEqualWithAccuracy(result.easting, expected.easting, 0.5, "Test 1 Easting")
    }
    
    func testToOSGrid5() {
        let wgs84 = WGS84(latitude: 49.851487, longitude:-5.937024)
        let result = wgs84.toOSGrid();
        let expected = OSGrid(easting: 117102, northing: 2018)
        XCTAssertEqualWithAccuracy(result.northing, expected.northing, 0.5, "Test 1 Northing")
        XCTAssertEqualWithAccuracy(result.easting, expected.easting, 0.5, "Test 1 Easting")
    }
    
}