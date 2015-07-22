//
//  Routes.swift
//  MapProgress
//
//  Created by James Robinson on 20/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class RouteManager {
    
    private var map: [String: Route];
    
    init() {
        self.map = [String:Route]();
    }
    
    func addRoute(route: Route) {
        map[route.name] = route;
    }
    
    func getRoute(name: String) -> Route {
        return map[name]!;
    }
}