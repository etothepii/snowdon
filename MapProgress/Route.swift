//
//  Route.swift
//  MapProgress
//
//  Created by James Robinson on 17/04/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class Route {
    
    var name: NSString;
    var points: [WayPoint];
    
    init(name: NSString) {
        self.name = name;
        self.points = [WayPoint]();
    }
    
    init(name: NSString, points: [WayPoint]) {
        self.name = name;
        self.points = points;
    }
}