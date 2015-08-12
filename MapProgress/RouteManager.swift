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
    private var currentRoute: Route? = nil
    
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
    
    func getRoute(index: Int) -> Route {
        return map[routes[index]]!
    }
    
    func getRoutes() -> [String] {
        return routes;
    }
    
    func getCurrentRoute() -> Route {
        return currentRoute!
    }
    
    func setCurrentRoute(routeName: String) {
        println("Setting Current Route: " + routeName)
        currentRoute = getRoute(routeName)
    }
    
    func getRouteCount() -> Int {
        return routes.count;
    }
}