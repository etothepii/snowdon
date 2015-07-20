//
//  RouteCalculatorTests.swift
//  MapProgress
//
//  Created by James Robinson on 20/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation
import XCTest

class RouteCalculatorTests: XCTestCase {
    
    let routeManager = RouteManager()
    let routeCalculator = RouteCalculator()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDistance() {
        var rockvale = routeManager.getRoute("Rockvale")
        var altitude = routeCalculator.getAltitude(routeManager.getRoute("Rockvale"))
        XCTAssertEqual(rockvale.points.count, altitude.count, "The number of elements in the altitude list should be the same as the number in the original route")
    }
    
}