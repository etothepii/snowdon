//
//  Routes.swift
//  MapProgress
//
//  Created by James Robinson on 20/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class RouteManager {
    
    private var map: [NSString: Route]
    
    init(map: [NSString:Route]) {
        self.map = map;
    }
    
    func getRoute(name: NSString) -> Route {
        return map[name]!;
    }
}