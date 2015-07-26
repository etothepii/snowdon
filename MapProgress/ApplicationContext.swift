//
//  ApplicationContext.swift
//  MapProgress
//
//  Created by James Robinson on 26/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class ApplicationContext {

    let routeDeserializer = RouteDeserializer();
    let routeManager = RouteManager()
    let dataPath: String;
    let routesPath: String;
    var error: NSError?;
    
    init() {
        let fileManager = NSFileManager.defaultManager()
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray;
        let documentsDir = paths.firstObject as! String;
        dataPath = documentsDir.stringByAppendingPathComponent("MapProgress");
        if (!fileManager.fileExistsAtPath(dataPath)) {
            println("Creating dataPath: " + dataPath)
            fileManager.createDirectoryAtPath(dataPath, withIntermediateDirectories: false, attributes: nil, error: &error)
        }
        println("Created dataPath: " + dataPath)
        routesPath = dataPath.stringByAppendingPathComponent("Routes");
        if (!fileManager.fileExistsAtPath(routesPath)) {
            println("Creating routesPath: " + routesPath)
            fileManager.createDirectoryAtPath(routesPath, withIntermediateDirectories: false, attributes: nil, error: &error)
        }
        println("Created routesPath: " + routesPath)
        let enumerator: NSDirectoryEnumerator = fileManager.enumeratorAtPath(routesPath)!
        while let element = enumerator.nextObject() as? String {
            println("Found file: " + element)
            if element.hasSuffix("json") {
                let routePath = routesPath.stringByAppendingPathComponent(element)
                println("Loading file: " + routePath)
                routeManager.addRoute(
                    routeDeserializer.deserialize(
                        NSData(contentsOfFile: routePath, options: .DataReadingMappedIfSafe, error: nil)!));
                println("Loaded file: " + routePath)
            }
        }
    }

}