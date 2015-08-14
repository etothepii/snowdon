//
//  Route.swift
//  MapProgress
//
//  Created by James Robinson on 17/04/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class Route {
    
    var name: String;
    var points: [WayPoint];
    
    init(name: String) {
        self.name = name;
        self.points = [WayPoint]();
    }
    
    init(name: String, points: [WayPoint]) {
        self.name = name;
        self.points = points;
    }
    
    func getPoints() -> [WayPoint] {
        return points
    }
    
    func getName() -> String {
        return name
    }
}