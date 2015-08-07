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
    var routes = [String]()
    var altitude = [String:[Double]]()
    var distance = [String:[Double]]()
    var proximity = [String:[ProximityTest]]()
    
    override func setUp() {
        super.setUp();
        routeManager = RouteManager();
        routeCalculator = RouteCalculator();
        addRoute("rockvale");
    }
    
    func addRoute(name: String) {
        var path = NSBundle(forClass: self.classForCoder).pathForResource(name, ofType: "json")!;
        var jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!;
        var route = routeDeserializer.deserialize(jsonData)
        routeManager!.addRoute(route)
        path = NSBundle(forClass: self.classForCoder).pathForResource(name + "_results", ofType: "json")!;
        jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!;
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary;
        var routeAltitudes = [Double]()
        for value in (jsonResult["altitude"] as! NSArray) {
            var routeAltitude = value as! Double
            routeAltitudes.append(routeAltitude)
        }
        altitude[route.name] = routeAltitudes
        var routeDistances = [Double]()
        for value in (jsonResult["distance"] as! NSArray) {
            var routeDistance = value as! Double
            routeDistances.append(routeDistance)
        }
        distance[route.name] = routeDistances
        var proximityTests = [ProximityTest]()
        for value in (jsonResult["proximity"] as! NSArray) {
            var proximityJson = value as! NSDictionary
            var easting = proximityJson["easting"] as! Double
            var northing = proximityJson["northing"] as! Double
            var index = proximityJson["index"] as! Int
            var proximityTest = ProximityTest(osGrid: OSGrid(easting: easting, northing: northing), index: index)
            proximityTests.append(proximityTest)
        }
        proximity[route.name] = proximityTests
        routes.append(route.name)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAltitude() {
        for key in routes {
            var route = routeManager!.getRoute(key)
            routeCalculator!.setRoute(route)
            var result = routeCalculator!.getAltitude()
            var expected = altitude[key]!
            XCTAssertEqual(route.points.count, expected.count, "The number of elements in the altitude list should be the same as the number in the original route")
            for index in 0...expected.count - 1 {
                var msg = String(format: "Value %d: %4d should equal %4d", index, result[index], expected[index])
                XCTAssertEqualWithAccuracy(result[index], expected[index], 0.0001, msg)
            }
        }
    }
    
    func testDistance() {
        for key in routes {
            var route = routeManager!.getRoute(key)
            routeCalculator!.setRoute(route)
            var result = routeCalculator!.getDistance()
            var expected = distance[key]!
            XCTAssertEqual(route.points.count, expected.count, "The number of elements in the distance list should be the same as the number in the original route")
            for index in 0...expected.count - 1 {
                var msg = String(format: "Value %d: %4d should equal %4d", index, result[index], expected[index])
                XCTAssertEqualWithAccuracy(result[index], expected[index], 0.0001, msg)
            }
        }
    }
    
    func testSetLocation() {
        for key in routes {
            var route = routeManager!.getRoute(key)
            routeCalculator!.setRoute(route)
            for proximityTest in proximity[key]! {
                let result = routeCalculator!.setLocation(proximityTest.osGrid)
                let expected = proximityTest.index
                var msg = String(format: "Value (%d, %d): %d should equal %d", proximityTest.osGrid.easting, proximityTest.osGrid.northing, result, expected)
                XCTAssertEqual(result, expected, msg)
            }
        }
    }
}