//
//  RouteDeserializer.swift
//  MapProgress
//
//  Created by James Robinson on 21/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class RouteDeserializer {
    
    init() {}
    
    func deserialize(data: NSData) -> Route {
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary;
        var name : String = jsonResult["name"] as! String;
        var points = [WayPoint]()
        for point in (jsonResult["points"] as! NSArray) {
            var wayPoint = point as! NSDictionary
            points.append(WayPoint(northing: wayPoint["northing"] as! Double,
                easting: wayPoint["easting"] as! Double,
                altitude: wayPoint["altitude"] as! Double));
        }
        return Route(name: name, points: points)
    }
    
}