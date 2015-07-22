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
    
    let routeDeserializer = RouteDeserializer()
    var routeManager: RouteManager?
    var routeCalculator: RouteCalculator?
    
    override func setUp() {
        super.setUp();
        routeManager = RouteManager();
        routeCalculator = RouteCalculator();
        addRoute("rockvale");
    }
    
    func addRoute(name: String) {
        let path = NSBundle(forClass: self.classForCoder).pathForResource(name, ofType: "json")!;
        let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!;
        routeManager!.addRoute(routeDeserializer.deserialize(jsonData))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAltitude() {
        var rockvale = routeManager!.getRoute("Rockvale")
        var altitude = routeCalculator!.getAltitude(rockvale)
        XCTAssertEqual(rockvale.points.count, altitude.count, "The number of elements in the altitude list should be the same as the number in the original route")
    }
    
    func testDistance() {
        var rockvale = routeManager!.getRoute("Rockvale")
        var distance = routeCalculator!.getDistance(rockvale)
        XCTAssertEqual(rockvale.points.count, distance.count, "The number of elements in the distance list should be the same as the number in the original route")
    }
}