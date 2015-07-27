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
    private var routes: [String]
    
    init() {
        self.map = [String:Route]();
        self.routes = [String]();
    }
    
    func addRoute(route: Route) {
        map[route.name] = route;
        routes.append(route.name);
    }
    
    func getRoute(name: String) -> Route {
        return map[name]!;
    }
    
    func getRoutes() -> [String] {
        return routes;
    }
    
    func getCurrentRoute() -> Route {
        return getRoute(routes[0]);
    }
}